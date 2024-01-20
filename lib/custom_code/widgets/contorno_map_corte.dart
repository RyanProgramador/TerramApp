// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;

import '../../contorno_da_fazenda/contorno_da_fazenda_model.dart';
export 'package:terram_app/contorno_da_fazenda/contorno_da_fazenda_model.dart';

class ContornoMapCorte extends StatefulWidget {
  const ContornoMapCorte({
    Key? key,
    this.width,
    this.height,
    this.ativoOuNao,
    this.localAtual,
    this.oservid,
    this.idContorno,
    this.fazNome,
    this.fazLatLng,
    this.toleranciaEmMetrosEntreUmaCapturaEOutra,
    this.listaLatLngTalhao,
    this.fazid,
  }) : super(key: key);

  final double? width;
  final double? height;
  final bool? ativoOuNao;
  final LatLng? localAtual;
  final String? oservid;
  final String? idContorno;
  final String? fazid;
  final String? fazNome;
  final LatLng? fazLatLng;
  final int? toleranciaEmMetrosEntreUmaCapturaEOutra;
  final List<String>? listaLatLngTalhao;
  @override
  _ContornoMapCorteState createState() => _ContornoMapCorteState();
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class _ContornoMapCorteState extends State<ContornoMapCorte> {
  Position? position;
  google_maps.GoogleMapController? _googleMapController;
  List<google_maps.Marker> markers = [];
  List<google_maps.Polygon> polygons = [];
  List<google_maps.Polyline> polylines = [];
  bool isLocationPaused = false;
  bool isVisivel = true;
  double currentZoom = 20.0;
  google_maps.LatLng? currentTarget;
  // late String oservid;
  // late String idContorno;
  // late String fazid;
  //IMPEDIR DE PEGAR NO MESMO LUGAR
  Position? lastPosition;
//isso é para mudar o estado de fora do widget custom
  late ContornoDaFazendaModel _model;
//cores do contorno
  List<String> coresHex = [
    "#000000" //preto
  ];
  List<google_maps.LatLng> fixedPolygonCoordinates = [
    // google_maps.LatLng(-29.91541825768134, -51.19612947790546),
    // google_maps.LatLng(-29.915492652480637, -51.19359747287395),
    // google_maps.LatLng(-29.913111991335484, -51.19323269248806),
    // google_maps.LatLng(-29.912944598957193, -51.1966230043099),
  ];

  //
  List<Map<String, dynamic>> dados = []; // Variável para armazenar dados
  List<Map<String, dynamic>> latlngRecorte =
      []; // Variável para armazenar dados

  @override
  void initState() {
    super.initState();

    // Filtra os dados com base no 'contorno_grupo'
    var filtrado = FFAppState()
        .contornoFazenda
        .where((item) => item['contorno_grupo'] == widget.idContorno)
        .map((item) => item['latlng'] as String)
        .toList();

    _model = createModel(context, () => ContornoDaFazendaModel());
    _getCurrentLocation();

    // Verifica se a lista está disponível e não vazia
    if (filtrado.isNotEmpty) {
      fixedPolygonCoordinates = toLatLng(filtrado);
      _initializePolygons();
    }

    Timer.periodic(
        Duration(milliseconds: 1000), (Timer t) => _getCurrentLocation());
  }

  List<google_maps.LatLng> toLatLng(List<String> latLngStrings) {
    List<google_maps.LatLng> latLngList = [];
    for (String latLngString in latLngStrings) {
      final latLngSplit = latLngString.split(',').map((s) => s.trim()).toList();
      if (latLngSplit.length == 2) {
        try {
          final lat = double.parse(latLngSplit[0]);
          final lng = double.parse(latLngSplit[1]);
          latLngList.add(google_maps.LatLng(lat, lng));
        } catch (e) {
          // Handle parsing error if any.
        }
      }
    }
    return latLngList;
  }

  void _initializePolygons() {
    // Polígono fixo
    var fixedPolygon = google_maps.Polygon(
      polygonId: google_maps.PolygonId('FixedAreaPolygon'),
      points: fixedPolygonCoordinates,
      fillColor: Colors.black.withOpacity(0.4),
      strokeColor: Colors.black,
      strokeWidth: 3,
    );

    setState(() {
      polygons.add(fixedPolygon);
    });
  }

  void _onMapCreated(google_maps.GoogleMapController controller) {
    _googleMapController = controller;
    _getCurrentLocation(); // Inicializar a posição atual ao criar o mapa
  }

  void _getCurrentLocation() async {
    if (widget.ativoOuNao == true) {
      if (!isLocationPaused) {
        Position newLoc = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        // Se for a primeira vez ou se a distância entre a última posição e a nova for >= 1m
        if (lastPosition == null ||
            Geolocator.distanceBetween(
                  lastPosition!.latitude,
                  lastPosition!.longitude,
                  newLoc.latitude,
                  newLoc.longitude,
                ) >=
                (widget.toleranciaEmMetrosEntreUmaCapturaEOutra ?? 1)) {
          // Atualiza a última posição conhecida
          lastPosition = newLoc;
          double currentZoomLevel = await _googleMapController!.getZoomLevel();
          if (_googleMapController != null) {
            _googleMapController!.animateCamera(
              google_maps.CameraUpdate.newCameraPosition(
                google_maps.CameraPosition(
                  target: google_maps.LatLng(
                    newLoc.latitude,
                    newLoc.longitude,
                  ),
                  zoom: currentZoomLevel,
                ),
              ),
            );
          }
          currentTarget = google_maps.LatLng(newLoc.latitude, newLoc.longitude);
          currentZoom = 20;

          setState(() {
            position = newLoc;
            _addUserMarker(
                google_maps.LatLng(newLoc.latitude, newLoc.longitude));
            _updatePolyline();
          });
        }
      }
    }
  }

  void _centerMap() {
    if (currentTarget != null && _googleMapController != null) {
      _googleMapController!.animateCamera(
        google_maps.CameraUpdate.newLatLngZoom(
          google_maps.LatLng(currentTarget!.latitude, currentTarget!.longitude),
          currentZoom,
        ),
      );
    }
  }

  void _updatePolyline() {
    setState(() {
      // Recalcular as coordenadas da linha
      List<google_maps.LatLng> polylineCoordinates =
          markers.map((marker) => marker.position).toList();
      polylines.clear(); // Limpar linhas existentes
      if (polylineCoordinates.isNotEmpty) {
        var polyline = google_maps.Polyline(
          polylineId: google_maps.PolylineId('RoutePolyline'),
          points: polylineCoordinates,
          color: Colors.blue,
          // color: HexColor("$corAleatoria"),
          width: isLocationPaused ? 0 : 5,
        );
        polylines.add(polyline);
      }
    });
  }

  void _finalizeArea() {
    if (markers.isNotEmpty && _distanceToStart() <= 50) {
      final Random random = Random();
      final String corAleatoria = coresHex[random.nextInt(coresHex.length)];

      // setState(() {

      // Polígono criado pelo usuário
      var userCreatedPolygon = google_maps.Polygon(
        polygonId: google_maps.PolygonId('UserCreatedAreaPolygon'),
        points: List<google_maps.LatLng>.from(
            markers.map((marker) => marker.position)),
        fillColor: Colors.red.withOpacity(0.2),
        strokeColor: Colors.red,
        strokeWidth: 3,
      );

      setState(() {
        polygons.add(
            userCreatedPolygon); // Adiciona o novo polígono sem remover o existente
      });

      // Transformar a linha em um polígono fechado
      var polygonCoordinates = List<google_maps.LatLng>.from(
          markers.map((marker) => marker.position));
      polygonCoordinates.add(markers.first.position); // Fechar o polígono
      // polygons.clear();//limpar poligonos, remover isso após testes
      polygons.add(
        google_maps.Polygon(
          polygonId: google_maps.PolygonId('AreaPolygon'),
          points: polygonCoordinates,
          fillColor: HexColor("#DB2400").withOpacity(0.2),
          strokeColor: HexColor("#DB2400"),
          strokeWidth: 3,
        ),
      );

      // Salvar dados
      int markerId = 1;
      // for (var coord in polygonCoordinates) {
      //   Map<String, dynamic> contorno = {
      //     "contorno_grupo": widget.idContorno,
      //     "marker_id": markerId++,
      //     "oserv_id": widget.oservid,
      //     "latlng": "${coord.latitude}, ${coord.longitude}",
      //   };
      //   FFAppState().contornoFazenda.add(contorno);
      // }
      DateTime dataHoraAtual = DateTime.now();
      String formattedDataHora = dataHoraAtual
          .toLocal()
          .toString(); // Obtém a data e hora atual como uma string

      Map<String, dynamic> grupocontorno = {
        "contorno_grupo": widget.idContorno,
        "oserv_id": widget.oservid,
        "dthr_fim": formattedDataHora,
        "faz_id": widget.fazid,
        "cor": "$corAleatoria",
        "nome": "Talh_" + widget.idContorno.toString()
      };
      // FFAppState().latlngRecorteTalhao.add(grupocontorno);

      isVisivel = false;
      isLocationPaused = true;
      // });
    }
    _updatePolyline();
  }

  void _setFinalizou() {
    if (markers.isNotEmpty && _distanceToStart() <= 50) {
      final String corAleatoria = coresHex[Random().nextInt(coresHex.length)];

      // Polígono criado pelo usuário
      var userCreatedPolygon = google_maps.Polygon(
        polygonId: google_maps.PolygonId('UserCreatedAreaPolygon'),
        points: List<google_maps.LatLng>.from(
            markers.map((marker) => marker.position)),
        fillColor: Colors.red.withOpacity(0.2),
        strokeColor: Colors.red,
        strokeWidth: 3,
      );

      setState(() {
        polygons.add(userCreatedPolygon); // Adiciona o novo polígono
      });

      // Capturar os pontos do polígono
      List<String> polygonPoints = userCreatedPolygon.points
          .map((p) => "${p.latitude}, ${p.longitude}")
          .toList();

      // Armazenar no latlngRecorte
      setState(() {
        latlngRecorte.add({
          "idContorno": widget.idContorno,
          "fazid": widget.fazid,
          "listaLatLngRecorte": polygonPoints
        });
        // Converter latlngRecorte em JSON e adicionar ao FFAppState
        String latlngRecorteJson = jsonEncode(latlngRecorte);
        FFAppState().latlngRecorteTalhao.add(latlngRecorteJson);
      });

      // Outras ações de finalização
      isVisivel = false;
      isLocationPaused = true;
    }
    _updatePolyline();
  }

  double _distanceToStart() {
    if (markers.isEmpty || position == null) return double.infinity;
    var start = markers.first.position;
    var current = google_maps.LatLng(position!.latitude, position!.longitude);
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      current.latitude,
      current.longitude,
    );
  }

  void _toggleLocationPause() {
    setState(() {
      isLocationPaused = !isLocationPaused;
    });
  }

  void _clearMarkersAndPolygons() {
    setState(() {
      markers.clear();
      polygons.clear();
      polylines.clear();
      dados.clear();
    });
  }

  void _addUserMarker(google_maps.LatLng position) {
    markers.add(
      google_maps.Marker(
        markerId: google_maps.MarkerId('UserMarkerID'),
        position: google_maps.LatLng(
          position.latitude,
          position.longitude,
        ),
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
          google_maps.BitmapDescriptor.hueRed,
        ),
        visible: true,
        draggable: false,
        infoWindow: google_maps.InfoWindow(
          title: 'Você esta aqui!', // Adicione o título do marcador
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Contorno finalizado com sucesso!"),
          actions: [
            TextButton(
              onPressed: () {
                _setFinalizou();
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showDeletarContornoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Deseja excluir progresso atual?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo.
              },
              child: Text("Não"),
            ),
            TextButton(
              onPressed: () {
                _clearMarkersAndPolygons();
                Navigator.of(context).pop(); // Fecha o diálogo.
              },
              child: Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  void _mensagemDeConfimacaoDeFinalizacao(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Deseja finalizar o contorno?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo.
              },
              child: Text("Não"),
            ),
            TextButton(
              onPressed: () {
                _finalizeArea();

                Navigator.of(context).pop();
                _showSuccessDialog(context);
                // Navigator.of(context).pop();
              },
              child: Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width ?? 400.0,
          height: widget.height ?? 400.0,
          child: google_maps.GoogleMap(
            initialCameraPosition: google_maps.CameraPosition(
              target: google_maps.LatLng(
                widget.localAtual?.latitude ?? 0.0,
                widget.localAtual?.longitude ?? 0.0,
              ),
              zoom: 20,
            ),
            onMapCreated: _onMapCreated,
            markers: {...markers}.toSet(),
            polygons: {...polygons}.toSet(),
            polylines: {...polylines}.toSet(),
            mapType: google_maps.MapType.satellite,
            mapToolbarEnabled: false,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
          ),
        ),
        Positioned(
          top: 62,
          right: 16,
          child: ElevatedButton(
            onPressed: _toggleLocationPause,
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Color(0xFF00736D),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isLocationPaused
                  ? Icon(
                      Icons.play_arrow,
                      size: 25.0,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.pause,
                      size: 25.0,
                      color: Colors.white,
                    ),
            ),
          ),
        ),
        Positioned(
          top: 62,
          left: MediaQuery.of(context).size.width / 2 - 44,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Color(0xFF00736D),
            ),
            onPressed: _centerMap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.center_focus_strong,
                size: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          top: 62,
          left: 16,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Color(0xFF00736D),
            ),
            onPressed: () {
              _showDeletarContornoDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete,
                size: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          top: 552,
          right: -8,
          child: Visibility(
            visible: _distanceToStart() <= 50 && isVisivel == true,
            child: ElevatedButton(
              onPressed: () {
                _mensagemDeConfimacaoDeFinalizacao(context);
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Color(0xFFC13131),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check,
                  size: 62.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _showVariablesAlert(context),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Color(0xFF00736D),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.info_outline,
                    size: 35.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showVariablesAlert(BuildContext context) {
    var filtrado = FFAppState()
        .contornoFazenda
        .where((item) => item['contorno_grupo'] == widget.idContorno)
        .map((item) => item['latlng'])
        .toList();

    // Decodificar a lista JSON em uma lista de objetos
    var latlngRecorteJson = FFAppState()
        .latlngRecorteTalhao
        .map((stringItem) => jsonDecode(stringItem) as Map<String, dynamic>)
        .toList();

    // Filtrar os recortes do contorno correto
    var filtradoRecorte = latlngRecorteJson
        .where((item) => item['contorno_grupo'].toString() == widget.idContorno)
        .map((item) => item['listaLatLngRecorte'])
        .toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Variáveis e Valores'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Width: ${widget.width}'),
                Text('Height: ${widget.height}'),
                Text('Lista de LatLng: $filtrado'),
                Text('Local Atual: ${widget.localAtual}'),
                Text('OSERVID: ${widget.oservid}'),
                Text('ID do Contorno: ${widget.idContorno}'),
                Text('ID da Fazenda: ${widget.fazid}'),
                Text('Nome da Fazenda: ${widget.fazNome}'),
                Text('LatLng da Fazenda: ${widget.fazLatLng}'),
                // Text('lista de latlng do cont: $latlngRecorte'),
                // Text('apenas as latlng do contorno correto: $filtradoRecorte'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

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
import 'package:wakelock/wakelock.dart';
import 'package:background_location/background_location.dart';
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
    //this.listaLatLngTalhao,
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
  //final List<String>? listaLatLngTalhao;
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
  bool isVisivel = false;
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
  // Map<String, dynamic> latlngRecorte; // Variável para armazenar dados

  @override
  void initState() {
    Wakelock.enable();
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
    var filtradoRecorte = FFAppState()
        .latlngRecorteTalhao
        .where((item) => item['idContorno'] == widget.idContorno)
        .map((item) => item['listaLatLngRecorte'])
        .toList();
    if (filtradoRecorte != null) {
      _createRecortePolygons();
    }

    Timer.periodic(
        Duration(milliseconds: 1000), (Timer t) => _getCurrentLocation());
  }

  bool _isLocationServiceRunning = false;
  void startLocationService() {
    if (!_isLocationServiceRunning) {
      BackgroundLocation.startLocationService(distanceFilter: 0);
      _isLocationServiceRunning = true;
    }
  }

  void stopLocationService() {
    if (_isLocationServiceRunning) {
      BackgroundLocation.stopLocationService();
      _isLocationServiceRunning = false;
    }
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

  void _createRecortePolygons() {
    var filtradoRecorte = FFAppState()
        .latlngRecorteTalhao
        .where((item) => item['idContorno'] == widget.idContorno)
        // .map((item) => item['listaLatLngRecorte'])
        .toList();

// Agrupar por grupoDeRecorte
    var gruposDeRecorte = <int, List<dynamic>>{};
    for (var item in filtradoRecorte) {
      int grupoId = item['grupoDeRecorte'];
      if (!gruposDeRecorte.containsKey(grupoId)) {
        gruposDeRecorte[grupoId] = [];
      }
      gruposDeRecorte[grupoId]!.add(item);
    }

    // Criar um polígono para cada grupo
    gruposDeRecorte.forEach((grupoId, itens) {
      List<google_maps.LatLng> recorteLatLngList = itens.map((item) {
        var parts = item['listaLatLngRecorte'].split(',');
        return google_maps.LatLng(
            double.parse(parts[0].trim()), double.parse(parts[1].trim()));
      }).toList();

      if (recorteLatLngList.isNotEmpty) {
        // Criar e adicionar o polígono de recorte
        var recortePolygon = google_maps.Polygon(
          polygonId: google_maps.PolygonId('Recorte_$grupoId'),
          points: recorteLatLngList,
          fillColor: Colors.red.withOpacity(0.4),
          strokeColor: Colors.red,
          strokeWidth: 3,
        );

        setState(() {
          polygons.add(recortePolygon);
        });
      }
    });
  }

  void _onMapCreated(google_maps.GoogleMapController controller) {
    _googleMapController = controller;
    _getCurrentLocation(); // Inicializar a posição atual ao criar o mapa
  }

  void _getCurrentLocation() async {
    startLocationService();
    if (widget.ativoOuNao == true) {
      isVisivel = true;
      if (!isLocationPaused) {
        BackgroundLocation.getLocationUpdates((location) async {
          // Adicionado async aqui
          Position newLoc = Position(
            latitude: location.latitude ?? 0.0,
            longitude: location.longitude ?? 0.0,
            timestamp: DateTime.now(),
            accuracy: location.accuracy ?? 0.0,
            altitude: location.altitude ?? 0.0,
            heading: location.bearing ?? 0.0,
            speed: location.speed ?? 0.0,
            speedAccuracy: 1 ?? 0.0,
          );

          // Se for a primeira vez ou se a distância entre a última posição e a nova for >= 1m
          if (lastPosition == null ||
              Geolocator.distanceBetween(
                    lastPosition!.latitude,
                    lastPosition!.longitude,
                    location.latitude ?? 0.0,
                    location.longitude ?? 0.0,
                  ) >=
                  (widget.toleranciaEmMetrosEntreUmaCapturaEOutra ?? 3)) {
            // Atualiza a última posição conhecida
            lastPosition = newLoc;

            if (_googleMapController != null) {
              double currentZoomLevel = await _googleMapController!
                  .getZoomLevel(); // Usando await aqui
              _googleMapController!.animateCamera(
                google_maps.CameraUpdate.newCameraPosition(
                  google_maps.CameraPosition(
                    target: google_maps.LatLng(
                      location.latitude ?? 0.0,
                      location.longitude ?? 0.0,
                    ),
                    zoom: currentZoomLevel,
                  ),
                ),
              );
            }
            currentTarget =
                google_maps.LatLng(newLoc.latitude, newLoc.longitude);
            currentZoom = 20;
            // Atualiza o estado com a nova localização
            setState(() {
              position = newLoc;
              _addUserMarker(
                  google_maps.LatLng(newLoc.latitude, newLoc.longitude));
              _updatePolyline();
            });
          }
        });
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
    if (markers.isNotEmpty /*&& _distanceToStart() <= 50*/) {
      final Random random = Random();
      final String corAleatoria = coresHex[random.nextInt(coresHex.length)];

      // Polígono criado pelo usuário
      var userCreatedPolygon = google_maps.Polygon(
        polygonId: google_maps.PolygonId('UserCreatedAreaPolygon'),
        points: List<google_maps.LatLng>.from(
            markers.map((marker) => marker.position)),
        fillColor: Colors.red.withOpacity(0.2),
        strokeColor: Colors.red,
        strokeWidth: 3,
      );
      polygons.clear();
      setState(() {
        polygons.add(
            userCreatedPolygon); // Adiciona o novo polígono sem remover o existente
      });

      // // Transformar a linha em um polígono fechado
      // var polygonCoordinates = List<google_maps.LatLng>.from(
      //     markers.map((marker) => marker.position));
      // polygonCoordinates.add(markers.first.position); // Fechar o polígono
      // // polygons.clear();//limpar poligonos, remover isso após testes
      // polygons.add(
      //   google_maps.Polygon(
      //     polygonId: google_maps.PolygonId('AreaPolygon'),
      //     points: polygonCoordinates,
      //     fillColor: HexColor("#DB2400").withOpacity(0.2),
      //     strokeColor: HexColor("#DB2400"),
      //     strokeWidth: 3,
      //   ),
      // );

      var grupoDeRecorte = FFAppState()
          .latlngRecorteTalhao
          .where((item) => item['idContorno'] == widget.idContorno)
          .map((item) => item['grupoDeRecorte']
              as int) // Assegure-se de que está mapeando para int.
          .toList();

      int maiorNumero;
      if (grupoDeRecorte.isNotEmpty) {
        maiorNumero = grupoDeRecorte.reduce((a, b) => a > b ? a : b) +
            1; // Incrementa o maior número encontrado.
        print("O maior número é: $maiorNumero");
      } else {
        maiorNumero = 1; // Começa de 1 se a lista estiver vazia.
      }

      // int markerId = 1;
      // google_maps.LatLng? lastCoord;
      //
      // userCreatedPolygon.points.forEach((point) {
      //   // Verifica se a coordenada atual é diferente da última coordenada processada
      //   if (lastCoord == null ||
      //       (lastCoord?.latitude != point.latitude &&
      //           lastCoord?.longitude != point.longitude)) {
      //     Map<String, dynamic> latlngRecorte = {
      //       "idContorno": widget.idContorno,
      //       "marker_id": markerId.toString(),
      //       "fazid": widget.fazid,
      //       "listaLatLngRecorte": "${point.latitude},${point.longitude}",
      //       "grupoDeRecorte": maiorNumero,
      //     };
      //
      //     // Adiciona o Map diretamente ao FFAppState().latlngRecorteTalhao
      //     FFAppState().latlngRecorteTalhao.add(latlngRecorte);
      //     markerId++;
      //     lastCoord = point; // Atualiza a última coordenada processada
      //   }
      // });

      int markerId = 1;
      google_maps.LatLng? lastCoord;

      for (var point in userCreatedPolygon.points) {
        // Verifica se a coordenada atual é diferente da última coordenada processada
        if (lastCoord == null ||
            (lastCoord.latitude != point.latitude &&
                lastCoord.longitude != point.longitude) ||
            (_calculaDistance(lastCoord, point) >= 2.0)) {
          Map<String, dynamic> latlngRecorte = {
            "idContorno": widget.idContorno,
            "marker_id": markerId.toString(),
            "fazid": widget.fazid,
            "listaLatLngRecorte": "${point.latitude},${point.longitude}",
            "grupoDeRecorte": maiorNumero,
          };

          // Adiciona o Map diretamente ao FFAppState().latlngRecorteTalhao
          FFAppState().latlngRecorteTalhao.add(latlngRecorte);
          lastCoord = point; // Atualiza a última coordenada processada
        }

        markerId++;
      }

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
    stopLocationService();
    _updatePolyline();
  }

  double _calculaDistance(google_maps.LatLng start, google_maps.LatLng end) {
    return Geolocator.distanceBetween(
        start.latitude, start.longitude, end.latitude, end.longitude);
  }

  void _setFinalizou() {
    if (markers.isNotEmpty && _distanceToStart() <= 50) {
      // final String corAleatoria = coresHex[Random().nextInt(coresHex.length)];
      //
      // // Polígono criado pelo usuário
      // var userCreatedPolygon = google_maps.Polygon(
      //   polygonId: google_maps.PolygonId('UserCreatedAreaPolygon'),
      //   points: List<google_maps.LatLng>.from(
      //       markers.map((marker) => marker.position)),
      //   fillColor: Colors.red.withOpacity(0.2),
      //   strokeColor: Colors.red,
      //   strokeWidth: 3,
      // );
      //
      // setState(() {
      //   polygons.add(userCreatedPolygon); // Adiciona o novo polígono
      // });
      //
      // // Capturar os pontos do polígono
      // List<String> polygonPoints = userCreatedPolygon.points
      //     .map((p) => "${p.latitude}, ${p.longitude}")
      //     .toList();

      // Outras ações de finalização
      // isVisivel = false;
      // isLocationPaused = true;
    }
    // _updatePolyline();
    stopLocationService();
    context.goNamed(
      'ListaContornos',
      queryParameters: {
        'nomeFazenda': serializeParam(
          widget.fazNome,
          ParamType.String,
        ),
        'oservID': serializeParam(
          widget.oservid,
          ParamType.String,
        ),
        'fazid': serializeParam(
          widget.fazid,
          ParamType.String,
        ),
        'fazlatlng': serializeParam(
          widget.fazLatLng,
          ParamType.LatLng,
        ),
      }.withoutNulls,
      extra: <String, dynamic>{
        kTransitionInfoKey: TransitionInfo(
          hasTransition: true,
          transitionType: PageTransitionType.fade,
          duration: Duration(milliseconds: 0),
        ),
      },
    );
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
    // Obtém o tamanho da tela
    Size screenSize = MediaQuery.of(context).size;

    // Calcula a posição do botão com base no tamanho da tela
    double topPosition = screenSize.height * 0.59; // 90% da altura da tela
    double rightPosition = screenSize.width * 0.05; // 5% da largura da tela

    return WillPopScope(
        onWillPop: () async {
          // Aqui você pode implementar qualquer lógica adicional necessária
          // antes de permitir o comportamento padrão de voltar.
          final shouldPop = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Você tem certeza que quer sair do recorte?'),
              content: Text(''),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pop(false), // Não permite sair da tela
                  child: Text('Não'),
                ),
                TextButton(
                  onPressed: () {
                    // Permite sair da tela e redireciona
                    Navigator.of(context)
                        .pop(true); // Primeiro, fecha o diálogo
                    // Substitua 'blankRedirecona' pelo nome da rota para a qual você deseja navegar
                    // return true;
                    setState(() {
                      FFAppState().update(() {
                        FFAppState().latlngRecorteTalhao = FFAppState()
                            .latlngRecorteTalhao
                            .toList()
                            .cast<dynamic>();
                      });
                    });
                    setState(() {});
                  },
                  child: const Text('Sim'),
                ),
              ],
            ),
          ); // Permite o comportamento padrão de voltar.
          return shouldPop ?? false;
        },
        child: Scaffold(
            body: Stack(
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
              top: topPosition,
              right: -8,
              child: Visibility(
                visible: /* _distanceToStart() <= 50 && */ isVisivel == true,
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
            // Positioned(
            //   bottom: 10,
            //   left: 10,
            //   right: 10,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       ElevatedButton(
            //         onPressed: () => _showVariablesAlert(context),
            //         style: ElevatedButton.styleFrom(
            //           shape: CircleBorder(),
            //           backgroundColor: Color(0xFF00736D),
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(16.0),
            //           child: Icon(
            //             Icons.info_outline,
            //             size: 35.0,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        )));
  }

  void _showVariablesAlert(BuildContext context) {
    // var filtrado = FFAppState()
    //     .contornoFazenda
    //     .where((item) => item['contorno_grupo'] == widget.idContorno)
    //     .map((item) => item['latlng'])
    //     .toList();
    //
    // var filtradoRecorte = FFAppState()
    //     .latlngRecorteTalhao
    //     .where((item) => item['idContorno'] == widget.idContorno)
    //     .map((item) => item['listaLatLngRecorte'])
    //     .toList();

    // Convertendo a lista para JSON
    // String filtradoRecorteString = jsonEncode(filtradoRecorte);

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
                // Text('Lista de LatLng: $filtrado'),
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

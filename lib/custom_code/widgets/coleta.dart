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

import 'package:flutter/services.dart';
import 'dart:convert';
// import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:background_location/background_location.dart'
    as background_location;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Coleta extends StatefulWidget {
  final double? width;
  final double? height;
  final List<String>? listaPontosComProfundidadeParaMedicao;
  final int? intervaloDeColetaParaProximaFoto;
  final List<String>? possiveisProfundidades;
  final List<String>? listaDeLocaisDeContornoDeArea;

  const Coleta({
    Key? key,
    this.width,
    this.height,
    this.listaPontosComProfundidadeParaMedicao,
    this.intervaloDeColetaParaProximaFoto,
    this.possiveisProfundidades,
    this.listaDeLocaisDeContornoDeArea,
  }) : super(key: key);
  final String customIconUrl =
      'https://cdn-icons-png.flaticon.com/128/3253/3253113.png';

  @override
  _ColetaState createState() => _ColetaState();
}

class _ColetaState extends State<Coleta> {
  google_maps.GoogleMapController? _googleMapController;
  Set<google_maps.Polygon> polygons = Set();
  Set<google_maps.Marker> markers = Set();
  Position? _currentPosition;
  StreamSubscription<Position>? _positionStreamSubscription;
  double? _userZoom;
  double _currentZoom = 18.0; // Inicializa o zoom padrão
// adiciona ponto novo na coleta
  bool isAddingPoint = false;

  //seleciona profundidade

  Set<String> profundidadesSelecionadas = {};
  List<String> possiveisProfundidades = ['0-10', '10-20', '20-30'];

  // Listas para armazenar os dados
  List<Map<String, String>> pontosMovidos = [];
  List<Map<String, String>> pontosColetados = [];
  List<Map<String, String>> pontosExcluidos = [];

  Map<String, Set<String>> coletasPorMarcador = {};

  //

  //tira foto
  bool podeTirarFoto = true;
  int intervaloDeColetaParaProximaFoto = 3;
  int vezAtualDoIntervaloDeColeta = 0;

//double tap no marcador
  bool focoNoMarcador = false;
  google_maps.LatLng? latlngMarcador;
  Map<String, DateTime> lastTapTimestamps = {};

//
  Map<String, bool> coletados = {};
  Map<String, google_maps.LatLng> markerPositions = {};

// ICONE

  Uint8List? customIconBytes;
//
  //IMPEDIR DE PEGAR NO MESMO LUGAR
  Position? lastPosition;

  Position? position;
  double currentZoom = 20.0;
  google_maps.LatLng? currentTarget;

  //
  dynamic listaDeLocais = [
    {"grupo": "2", "latlng": "-29.915044, -51.195798"},
    {"grupo": "2", "latlng": "-29.915091, -51.194011"},
    {"grupo": "2", "latlng": "-29.913644, -51.193930"},
    {"grupo": "2", "latlng": "-29.913558, -51.195563"},
  ];

  // Implementação de exemplo
  List<Map<String, dynamic>> latLngListMarcadores = [
    {
      "marcador_nome": "A",
      "latlng_marcadores": "-29.914939224621914, -51.195420011983714",
      "profundidades": [
        {"nome": "0-10", "icone": "location_dot", "cor": "#FFC0CB"},
        {"nome": "0-20", "icone": "flag", "cor": "#FF4500"},
        {"nome": "0-25", "icone": "map_pin", "cor": "#0000CD"}
      ],
      "foto_de_cada_profundidade": [],
    },
    {
      "marcador_nome": "B",
      "latlng_marcadores": "-29.91495486428177, -51.19437347868409",
      "profundidades": [
        {"nome": "0-10", "icone": "location_dot", "cor": "#FFC0CB"},
        {"nome": "0-20", "icone": "flag", "cor": "#FF4500"},
        {"nome": "0-25", "icone": "map_pin", "cor": "#0000CD"}
      ],
      "foto_de_cada_profundidade": [],
    },
    {
      "marcador_nome": "C",
      "latlng_marcadores": "-29.914305816333297, -51.19483359246237",
      "profundidades": [
        {"nome": "0-10", "icone": "location_dot", "cor": "#FFC0CB"},
        {"nome": "0-20", "icone": "flag", "cor": "#FF4500"},
        {"nome": "0-25", "icone": "map_pin", "cor": "#0000CD"},
        {"nome": "0-35", "icone": "plane", "cor": "#0000CD"}
      ],
      "foto_de_cada_profundidade": [],
    },
    {
      "marcador_nome": "D",
      "latlng_marcadores": "-29.91391738877275, -51.19420634010805",
      "profundidades": [
        {"nome": "0-10", "icone": "location_dot", "cor": "#FFC0CB"},
        {"nome": "0-20", "icone": "flag", "cor": "#FF4500"},
        {"nome": "0-25", "icone": "map_pi", "cor": "#0000CD"}
      ],
      "foto_de_cada_profundidade": [],
    },
  ];

  @override
  void initState() {
    super.initState();

    intervaloDeColetaParaProximaFoto =
        widget.intervaloDeColetaParaProximaFoto ??
            intervaloDeColetaParaProximaFoto;
    listaDeLocais = widget.listaDeLocaisDeContornoDeArea ?? listaDeLocais;

    latLngListMarcadores = widget.listaPontosComProfundidadeParaMedicao
            ?.cast<Map<String, dynamic>>() ??
        latLngListMarcadores;

// Atribuição condicional, garantindo que o parâmetro é uma lista de strings
    if (widget.possiveisProfundidades != null) {
      possiveisProfundidades =
          List<String>.from(widget.possiveisProfundidades!);
    }

    _initializePolygons();
    _criaMarcadores();
    _getCurrentLocation();
    // _loadCustomIcon();
    _trackUserLocation();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    _googleMapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(google_maps.GoogleMapController controller) {
    _googleMapController = controller;
    _getCurrentLocation(); // Inicializar a posição atual ao criar o mapa
  }

  void _getCurrentLocation() async {
    Position newLoc = await Geolocator.getCurrentPosition();
    // Se for a primeira vez ou se a distância entre a última posição e a nova for >= 1m
    // if (lastPosition == null ||
    //     Geolocator.distanceBetween(
    //           lastPosition!.latitude,
    //           lastPosition!.longitude,
    //           newLoc.latitude,
    //           newLoc.longitude,
    //         ) >=
    //         1) {
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
      _addUserMarker(google_maps.LatLng(newLoc.latitude, newLoc.longitude));
    });
    // }
  }

  void _onCameraMove(google_maps.CameraPosition position) {
    _currentZoom = position.zoom; // Atualiza o zoom atual
  }

  //trnasforme json em um formato elegivel pelo sistema
  List<google_maps.LatLng> _transformaJsonEmLatLng(List<dynamic> jsonList) {
    return jsonList.map((jsonItem) {
      List<String> latLng = jsonItem["latlng"].split(', ');
      return google_maps.LatLng(
          double.parse(latLng[0]), double.parse(latLng[1]));
    }).toList();
  }

  void _initializePolygons() {
    // Implementação de exemplo
    List<google_maps.LatLng> latLngList =
        _transformaJsonEmLatLng(listaDeLocais);
    String cor = "#000000";

    final polygon = google_maps.Polygon(
      polygonId: const google_maps.PolygonId('AreaPolygon'),
      points: latLngList,
      fillColor: HexColor(cor).withOpacity(0.2),
      strokeColor: HexColor(cor),
      strokeWidth: 3,
    );

    setState(() {
      polygons.add(polygon);
    });
  }

  void _criaMarcadores() {
    for (var marcador in latLngListMarcadores) {
      var latlng = marcador["latlng_marcadores"]!.split(",");
      var markerId = google_maps.MarkerId(marcador["marcador_nome"]!);
      var position =
          google_maps.LatLng(double.parse(latlng[0]), double.parse(latlng[1]));

      // Coletar os nomes das profundidades em uma string
      String nomesProfundidades = marcador["profundidades"]!
          .map((profundidade) => profundidade["nome"]!)
          .join(", "); // Junta os nomes com vírgula e espaço

      // Inicializar markerPositions com a posição original
      markerPositions[marcador["marcador_nome"]!] = position;

      var marker = google_maps.Marker(
        markerId: markerId,
        position: position,
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
            google_maps.BitmapDescriptor.hueRed),
        onTap: () {
          focoNoMarcador = true;
          latlngMarcador = google_maps.LatLng(
              double.parse(latlng[0]), double.parse(latlng[1]));

          _onMarkerTapped(markerId, marcador["marcador_nome"]!);
        },
        infoWindow: google_maps.InfoWindow(
          title: "PONTO : " + marcador["marcador_nome"]!,
          snippet: "Lista de profundidades: " + nomesProfundidades,
        ),
        draggable: false,
      );

      setState(() {
        markers.add(marker);
      });
    }
  }

//double tap, ou seja, dois clicks no marker para abrir
  void _onMarkerTapped(google_maps.MarkerId markerId, String markerName) {
    print("Marker tapped: $markerName");
    DateTime now = DateTime.now();
    String markerIdValue = markerId.value;

    // Retrieve the position of the tapped marker
    google_maps.LatLng markerLatLng = markerPositions[markerIdValue]!;

    // Calculate the distance between the user's current location and the marker
    double distance = Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      markerLatLng.latitude,
      markerLatLng.longitude,
    );

    // Check if the last tap was within 1.8 seconds to consider it a double tap
    if (lastTapTimestamps.containsKey(markerIdValue) &&
        now.difference(lastTapTimestamps[markerIdValue]!).inMilliseconds <
            1800) {
      // Check if the distance is greater than 30 meters
      if (distance > 900) {
        //metros de distancia para coletar
        // Show alert
        _showDistanceAlert();
      } else {
        // Continue with the normal double tap logic
        _showModalOptions(markerName);
      }
    }

    // Update the timestamp of the last tap
    lastTapTimestamps[markerIdValue] = now;
  }

  void _showDistanceAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aproxime-se do ponto!'),
          content: Text('Você está a mais de 30 metros do ponto de coleta.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadCustomIcon() async {
    final String customIconUrl = 'htt-128.png';
    try {
      final response = await http.get(Uri.parse(customIconUrl));
      if (response.statusCode == 200) {
        setState(() {
          customIconBytes = response.bodyBytes;
        });
      } else {
        print(
            "Failed to load custom icon. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error loading custom icon: $e");
    }
  }

  void _addUserMarker(google_maps.LatLng position) {
    final userLocationMarker = google_maps.Marker(
      markerId: const google_maps.MarkerId('current_location'),
      position: position,
      onTap: () {
        focoNoMarcador = false;
      },
      alpha: 0.0,
      // icon: customIconBytes == null
      //     ? google_maps.BitmapDescriptor.defaultMarkerWithHue(
      //         google_maps.BitmapDescriptor.hueBlue)
      //     : google_maps.BitmapDescriptor.fromBytes(customIconBytes!),
    );

    setState(() {
      markers.add(userLocationMarker);
    });
  }

  void _trackUserLocation() {
    _positionStreamSubscription = Geolocator.getPositionStream().listen(
      (Position position) {
        setState(() {
          _currentPosition = position;
          _updateUserLocationMarker(
              position); // Método para atualizar o marcador
          _updateMapLocation();
        });
      },
    );
  }

  void _updateUserLocationMarker(Position position) {
    final userLocationMarker = google_maps.Marker(
      markerId: const google_maps.MarkerId('current_location'),
      position: google_maps.LatLng(position.latitude, position.longitude),
      alpha: 0.0,
      icon: google_maps.BitmapDescriptor.defaultMarker,
    );

    setState(() {
      markers.removeWhere((marker) =>
          marker.markerId == google_maps.MarkerId('current_location'));
      markers.add(userLocationMarker);
    });
  }

  void _updateMapLocation() {
    if (_currentPosition != null && _googleMapController != null) {
      _googleMapController!.animateCamera(
        google_maps.CameraUpdate.newCameraPosition(
          google_maps.CameraPosition(
            target: focoNoMarcador == false
                ? google_maps.LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude)
                : google_maps.LatLng(
                    latlngMarcador!.latitude, latlngMarcador!.longitude),
            zoom: _currentZoom,
          ),
        ),
      );
    }
  }

  void _showModalOptions(String idMarcador) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: EdgeInsets.all(20),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Ponto: $idMarcador",
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.close,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 36,
                ),
              ),
            ],
          ),
          content: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildElevatedButton(
                    context, "Fazer uma coleta", Color(0xFF00736D), () {
                  Navigator.of(context).pop();
                  _ontapColetar(idMarcador);
                }),
                SizedBox(height: 10),
                _buildElevatedButton(
                    context, "Coleta inacessível", Color(0xFF9D291C), () {
                  Navigator.of(context).pop();
                  _ontapInacessivel(idMarcador);
                }),
                // SizedBox(height: 10),
                // _buildElevatedButton(context, "Criar Ponto", Colors.blue, () {
                //   Navigator.of(context).pop();
                //   // _adicionarNovoPonto();
                //   _showAdicionaProfundidades();
                //   _showTutorialModal();
                // }),
                // SizedBox(height: 10),
                // _buildElevatedButton(context, "Tirar Foto", Colors.orange, () {
                //   Navigator.of(context).pop();
                //   _tiraFoto(idMarcador);
                // }),
              ],
            ),
          ),
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 5,
        );
      },
    );
  }

  // void _tiraFoto() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  //
  //   if (image != null) {
  //     final bytes = await image.readAsBytes();
  //     String base64Image = base64Encode(bytes);
  //     String nomeProfundidade = 'Nome da profundidade'; // Defina como desejar
  //
  //     setState(() {
  //       latLngListMarcadores[0]["foto_de_cada_profundidade"].add({
  //         "nome": nomeProfundidade,
  //         // "foto": 'data:image/png;base64,$base64Image',
  //         "foto": 'data:image/png;base64,base64Image',
  //       });
  //     });
  //   }
  // }

  void _tiraFoto(String nomeMarcadorAtual, String nomeProfundidade) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      final bytes = await image.readAsBytes();
      String base64Image = base64Encode(bytes);

      setState(() {
        // Encontra o marcador pelo nome
        int indexMarcador = latLngListMarcadores.indexWhere(
            (marcador) => marcador['marcador_nome'] == nomeMarcadorAtual);

        if (indexMarcador != -1) {
          latLngListMarcadores[indexMarcador]['foto_de_cada_profundidade'].add({
            'nome': nomeProfundidade,
            'foto': 'data:image/png;base64,base64Image',
            // 'foto': 'data:image/png;base64,$base64Image',
          });
          pontosColetados.add({
            "marcador_nome": nomeMarcadorAtual,
            "profundidade": nomeProfundidade,
            "foto": 'fotoBase64',
          });
          FFAppState().PontosColetados.add(jsonEncode({
                "marcador_nome": nomeMarcadorAtual,
                "profundidade": nomeProfundidade,
                "foto": '$base64Image',
              }));
        }
      });
      // setState(() {
      //   pontosColetados.add({
      //     "marcador_nome": nomeMarcadorAtual,
      //     "profundidade": nomeProfundidade,
      //     "foto": 'fotoBase64',
      //   });
      // });
    }
  }

  void _showAdicionaProfundidades() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selecione as Profundidades'),
          content: SingleChildScrollView(
            child: ListBody(
              children: possiveisProfundidades.map((String value) {
                return CheckboxListTile(
                  title: Text(value),
                  value: profundidadesSelecionadas.contains(value),
                  onChanged: (bool? selected) {
                    setState(() {
                      if (selected ?? false) {
                        profundidadesSelecionadas.add(value);
                      } else {
                        profundidadesSelecionadas.remove(value);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                // Aqui você pode chamar um método para adicionar um novo ponto
                // ou fazer outra ação com as profundidades selecionadas.
              },
            ),
          ],
        );
      },
    );
  }

  void _showTutorialModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tutorial'),
          content:
              Text('Clique 1 vez no local onde queira adicionar um novo ponto'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isAddingPoint = true; // Enable map tap for adding a new point
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _onMapTap(google_maps.LatLng position) {
    if (isAddingPoint) {
      _addNewPointAtPosition(position);
      setState(() {
        isAddingPoint = false; // Reset the flag
      });
    }
  }

  void _addNewPointAtPosition(google_maps.LatLng position) {
    String novoNomeMarcador = _gerarNomeNovoMarcador();

    Map<String, dynamic> novoPonto = {
      "marcador_nome": novoNomeMarcador,
      "latlng_marcadores": "${position.latitude}, ${position.longitude}",
      "profundidades": [
        {
          "nome": profundidadesSelecionadas ?? '0-10',
          "icone": "location_dot",
          "cor": "#FFC0CB"
        },
        // Adicione outras opções aqui se necessário
      ],
    };

    setState(() {
      latLngListMarcadores.add(novoPonto);
      markerPositions[novoNomeMarcador] = position; // Adicione esta linha

      String nomesProfundidades = novoPonto["profundidades"]!
          .map((profundidade) => profundidade["nome"]!)
          .join(", "); // Junta os nomes com vírgula e espaço

      var newMarker = google_maps.Marker(
        markerId: google_maps.MarkerId(novoNomeMarcador),
        position: position,
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
            google_maps.BitmapDescriptor.hueRed),
        onTap: () {
          focoNoMarcador = true;
          latlngMarcador =
              google_maps.LatLng(position.latitude, position.longitude);

          _onMarkerTapped(google_maps.MarkerId(novoNomeMarcador),
              novoPonto["marcador_nome"]!);
        },
        infoWindow: google_maps.InfoWindow(
          title: "PONTO: $novoNomeMarcador",
          snippet: "Lista de profundidades: " + nomesProfundidades,
        ),
      );

      markers.add(newMarker);
    });
  }

  Widget _buildElevatedButton(
      BuildContext context, String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      child: Text(
        text,
        style: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Readex Pro',
              color: Colors.white,
            ),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 3,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      ),
    );
  }

  void _ontapColetar(String marcadorNome) {
    _showProfundidadesParaColeta(marcadorNome);
  }

  Map<String, IconData> faIcons = {
    "location_dot": FontAwesomeIcons.locationDot,
    "flag": FontAwesomeIcons.flag,
    "map_pin": FontAwesomeIcons.mapPin,
    "plane": FontAwesomeIcons.plane,
    "campground": FontAwesomeIcons.campground,
    "anchor": FontAwesomeIcons.anchor,
    "land_mine_on": FontAwesomeIcons.landMineOn,
  };

  IconData getFontAwesomeIconByName(String iconName) {
    return faIcons[iconName] ?? FontAwesomeIcons.questionCircle; // Ícone padrão
  }

  void _showProfundidadesParaColeta(String marcadorNome) {
    // Encontra o marcador pelo nome
    var marcador = latLngListMarcadores.firstWhere(
      (m) => m["marcador_nome"] == marcadorNome,
      orElse: () => {},
    );

    if (marcador.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            titlePadding: EdgeInsets.all(20),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Coletar profundidades para ${marcador["marcador_nome"]}",
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 36,
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: marcador["profundidades"].map<Widget>((profundidade) {
                  bool jaColetada = coletasPorMarcador[marcadorNome]
                          ?.contains(profundidade["nome"]) ??
                      false;
                  return Row(
                    children: [
                      Icon(
                        getFontAwesomeIconByName(profundidade["icone"]),
                        color: HexColor(profundidade["cor"]),
                      ),
                      SizedBox(width: 10),
                      Text(profundidade["nome"]),
                      Spacer(),
                      _buildElevatedButton(
                        context,
                        jaColetada ? "Coletada" : "Coletar",
                        jaColetada ? Color(0xFF9D291C) : Color(0xFF00736D),
                        () {
                          if (jaColetada) {
                            _confirmarRecoleta(
                                context, marcadorNome, profundidade["nome"]);
                          } else {
                            _confirmarColeta(
                                context, marcadorNome, profundidade["nome"]);
                          }
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 5,
          );
        },
      );
    }
  }

  String _gerarNomeNovoMarcador() {
    if (latLngListMarcadores.isEmpty) {
      return "A";
    }

    // Converte todos os nomes de marcadores em uma lista de listas de inteiros (0-25)
    List<List<int>> marcadoresNumericos =
        latLngListMarcadores.map<List<int>>((marcador) {
      String nomeMarcador = marcador["marcador_nome"]
          as String; // Garante que o nome é uma String
      return nomeMarcador.split('').map<int>((String char) {
        return char.codeUnitAt(0) - 'A'.codeUnitAt(0); // Conversão para int
      }).toList();
    }).toList();

    // Encontra o último nome de marcador e o converte para a representação numérica
    List<int> ultimoMarcadorNumerico = marcadoresNumericos.last;

    // Incrementa o último valor
    int index = ultimoMarcadorNumerico.length - 1;
    while (index >= 0) {
      if (ultimoMarcadorNumerico[index] < 25) {
        // Menor que 'Z'
        ultimoMarcadorNumerico[index]++;
        break;
      } else {
        ultimoMarcadorNumerico[index] =
            0; // Reseta para 'A' e incrementa o próximo caractere
        if (index == 0) {
          ultimoMarcadorNumerico.insert(
              0, 0); // Insere um novo 'A' se todos os caracteres forem 'Z'
          break;
        }
        index--;
      }
    }

    // Converte de volta para string
    return String.fromCharCodes(
      ultimoMarcadorNumerico.map((n) => n + 'A'.codeUnitAt(0)),
    );
  }

  void _confirmarRecoleta(
      BuildContext context, String marcadorNome, String profundidadeNome) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Recoleta"),
          content: Text("Deseja coletar essa profundidade novamente?"),
          actions: <Widget>[
            TextButton(
              child: Text("Não"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              child: Text("Sim"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                _tiraFoto(marcadorNome, profundidadeNome);
                _coletarProfundidade(
                    marcadorNome, profundidadeNome); // Realiza a coleta
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmarColeta(
      BuildContext context, String marcadorNome, String profundidadeNome) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Efetuar coleta'),
          content: Text('Deseja realmente efetuar esta coleta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (podeTirarFoto) {
                  if (vezAtualDoIntervaloDeColeta ==
                          intervaloDeColetaParaProximaFoto ||
                      vezAtualDoIntervaloDeColeta == 0) {
                    _tiraFoto(marcadorNome, profundidadeNome);
                    setState(() {
                      vezAtualDoIntervaloDeColeta = 1;
                    });
                    _coletarProfundidade(marcadorNome, profundidadeNome);
                  } else {
                    setState(() {
                      vezAtualDoIntervaloDeColeta += 1;
                    });
                    _coletarProfundidade(marcadorNome, profundidadeNome);
                  }
                } else {
                  _coletarProfundidade(marcadorNome, profundidadeNome);
                }
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  void _coletarProfundidade(String marcadorNome, String profundidadeNome) {
    setState(() {
      pontosColetados.add({
        "marcador_nome": marcadorNome,
        "profundidade": profundidadeNome,
      });
      coletasPorMarcador.putIfAbsent(marcadorNome, () => {});
      coletasPorMarcador[marcadorNome]!.add(profundidadeNome);

      // Verifica se todas as profundidades foram coletadas
      var todasProfundidades = latLngListMarcadores
          .firstWhere(
              (m) => m["marcador_nome"] == marcadorNome)["profundidades"]
          .map((p) => p["nome"])
          .toSet();

      if (coletasPorMarcador[marcadorNome]!.containsAll(todasProfundidades)) {
        // Todas as profundidades coletadas, mude a cor do marcador para verde
        _updateMarkerColor(marcadorNome, true);
      }
    });
    Navigator.of(context).pop(); // Fecha o modal atual
    _mostrarModalSucesso(context, marcadorNome);
  }

  void _mostrarModalSucesso(BuildContext context, String marcadorNome) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 0, milliseconds: 940), () {
          Navigator.of(context).pop(); // Fecha o modal de sucesso
          _showProfundidadesParaColeta(
              marcadorNome); // Reabre o modal de coletas
        });

        return AlertDialog(
          title: Text('Sucesso'),
          content: Text('Profundidade coletada!'),
        );
      },
    );
  }

  void _updateMarkerColor(String marcadorNome, bool todasColetadas) {
    var newIcon = todasColetadas
        ? google_maps.BitmapDescriptor.defaultMarkerWithHue(
            google_maps.BitmapDescriptor.hueGreen)
        : google_maps.BitmapDescriptor.defaultMarkerWithHue(
            google_maps.BitmapDescriptor.hueRed);

    setState(() {
      markers = markers.map((m) {
        if (m.markerId.value == marcadorNome) {
          return m.copyWith(iconParam: newIcon);
        }
        return m;
      }).toSet();
    });
  }

  void _ontapInacessivel(String marcadorNome) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: EdgeInsets.all(20),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Opções para o ponto $marcadorNome",
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.close,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 36,
                ),
              ),
            ],
          ),
          content: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildElevatedButton(context, "Mover", Color(0xFF9D291C), () {
                  Navigator.of(context).pop();
                  _enableMarkerDrag(marcadorNome);
                }),
                SizedBox(height: 10),
                _buildElevatedButton(
                    context, "Excluir Ponto", Color(0xFF9D291C), () {
                  Navigator.of(context).pop();
                  _removeMarker(marcadorNome);
                }),
                SizedBox(height: 10),
                _buildElevatedButton(
                    context, "Criar novo ponto", Color(0xFF9D291C), () {
                  Navigator.of(context).pop();
                  // _adicionarNovoPonto();
                  _showAdicionaProfundidades();
                  _showTutorialModal();
                }),
              ],
            ),
          ),
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 5,
        );
      },
    );
  }

  void _enableMarkerDrag(String marcadorNome) {
    setState(() {
      markers = markers.map((m) {
        if (m.markerId.value == marcadorNome) {
          return m.copyWith(
              draggableParam: true,
              onDragEndParam: (newPosition) {
                markerPositions[marcadorNome] = newPosition;

                // Adiciona à lista de pontos movidos
                var latLngOriginal = latLngListMarcadores.firstWhere((map) =>
                    map["marcador_nome"] == marcadorNome)["latlng_marcadores"];

                if (latLngOriginal != null) {
                  pontosMovidos.add({
                    "marcador_nome": marcadorNome,
                    "latlng_original": latLngOriginal,
                    "latlng_movido_para":
                        "${newPosition.latitude}, ${newPosition.longitude}"
                  });
                  FFAppState().PontosMovidos.add(jsonEncode(pontosMovidos));
                }
              });
        }
        return m;
      }).toSet();
    });
  }

  void _removeMarker(String marcadorNome) {
    var latLng = markerPositions[marcadorNome];

    pontosExcluidos.add({
      "marcador_nome": marcadorNome,
      "latlng": "${latLng?.latitude}, ${latLng?.longitude}"
    });
    setState(() {
      markers.removeWhere((m) => m.markerId.value == marcadorNome);
      markerPositions.remove(marcadorNome);
    });
  }

//muda o foco
  void mudaFoco() {
    focoNoMarcador = false;
  }

  // Widget _exibirDados() {
  //   return Column(
  //     children: [
  //       Text(
  //         "Pontos: ${jsonEncode(latLngListMarcadores)}",
  //         style: TextStyle(
  //           color: Colors.yellow, // Define a cor vermelha
  //           fontSize: 12.0, // Define o tamanho da fonte como 8
  //         ),
  //       ),
  //       Text(
  //         "Pontos Movidos: ${jsonEncode(pontosMovidos)}",
  //         style: TextStyle(
  //           color: Colors.yellow, // Define a cor vermelha
  //           fontSize: 12.0, // Define o tamanho da fonte como 8
  //         ),
  //       ),
  //       Text(
  //         "Pontos Coletados: ${jsonEncode(pontosColetados)}",
  //         style: TextStyle(
  //           color: Colors.yellow, // Define a cor vermelha
  //           fontSize: 12.0, // Define o tamanho da fonte como 8
  //         ),
  //       ),
  //       Text(
  //         "Pontos Excluídos: ${jsonEncode(pontosExcluidos)}",
  //         style: TextStyle(
  //           color: Colors.yellow, // Define a cor vermelha
  //           fontSize: 12.0, // Define o tamanho da fonte como 8
  //         ),
  //       ),
  //     ],
  //   );
  // }

  void _exibirDados() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Dados da Coleta'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  "Pontos: ${jsonEncode(latLngListMarcadores)}",
                  style: TextStyle(color: Colors.black, fontSize: 12.0),
                ),
                Text(
                  "Pontos Movidos: ${jsonEncode(pontosMovidos)}",
                  style: TextStyle(color: Colors.black, fontSize: 12.0),
                ),
                Text(
                  "Pontos Coletados: ${jsonEncode(pontosColetados)}",
                  style: TextStyle(color: Colors.black, fontSize: 12.0),
                ),
                Text(
                  "Pontos Excluídos: ${jsonEncode(pontosExcluidos)}",
                  style: TextStyle(color: Colors.black, fontSize: 12.0),
                ),
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width ?? double.infinity,
          height: widget.height ?? double.infinity,
          child: google_maps.GoogleMap(
            initialCameraPosition: google_maps.CameraPosition(
              target: google_maps.LatLng(-29.913558, -51.195563),
              zoom: _currentZoom,
            ),
            onMapCreated: (controller) {
              _googleMapController = controller;
              _onMapCreated(controller);
            },
            onTap: _onMapTap,
            onCameraMove: _onCameraMove,
            polygons: polygons,
            markers: markers,
            myLocationEnabled: true,
            mapType: google_maps.MapType.satellite,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
          ),
        ),
        Positioned(
          top: 62,
          right: 16,
          child: ElevatedButton(
            onPressed: mudaFoco,
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Color(0xFF00736D),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.center_focus_strong_sharp,
                  size: 25.0,
                  color: Colors.white,
                )),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: ElevatedButton(
            onPressed: _exibirDados,
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Color(0xFF00736D),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.info,
                  size: 25.0,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = _extractHexCode(hexColor);
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse('0x$hexColor');
  }

  static String _extractHexCode(String input) {
    RegExp regex = RegExp(r'([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})');
    Match? match = regex.firstMatch(input);
    return match?.group(0) ?? "000000";
  }
}

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
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:background_location/background_location.dart'
    as background_location;

class Coleta extends StatefulWidget {
  final double? width;
  final double? height;

  const Coleta({
    Key? key,
    this.width,
    this.height,
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
//double tap no marcador
  bool focoNoMarcador = false;
  google_maps.LatLng? latlngMarcador;
  Map<String, DateTime> lastTapTimestamps = {};
//
  Map<String, bool> coletados = {};
  Map<String, google_maps.LatLng> markerPositions = {};
// ICONE

  Uint8List? customIconBytes;
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
  List<Map<String, String>> latLngListMarcadores = [
    {
      "marcador_nome": "A",
      "latlng_marcadores": "-29.914939224621914, -51.195420011983714"
    },
    {
      "marcador_nome": "B",
      "latlng_marcadores": "-29.91495486428177, -51.19437347868409"
    },
    {
      "marcador_nome": "C",
      "latlng_marcadores": "-29.914305816333297, -51.19483359246237"
    },
    {
      "marcador_nome": "D",
      "latlng_marcadores": "-29.91391738877275, -51.19420634010805"
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializePolygons();
    _criaMarcadores();
    _getCurrentLocation();
    _loadCustomIcon();
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
    if (lastPosition == null ||
        Geolocator.distanceBetween(
              lastPosition!.latitude,
              lastPosition!.longitude,
              newLoc.latitude,
              newLoc.longitude,
            ) >=
            1) {
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
    }
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

      var marker = google_maps.Marker(
        markerId: markerId,
        position: google_maps.LatLng(
            double.parse(latlng[0]), double.parse(latlng[1])),
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
    DateTime now = DateTime.now();
    String markerIdValue = markerId.value;

    if (lastTapTimestamps.containsKey(markerIdValue) &&
        now.difference(lastTapTimestamps[markerIdValue]!).inMilliseconds <
            1800) {
      // Considerado um toque duplo
      _showModalOptions(markerName);
    }

    // Atualiza o timestamp do último toque
    lastTapTimestamps[markerIdValue] = now;
  }

  Future<void> _loadCustomIcon() async {
    final String customIconUrl =
        'https://cdn3.iconfinder.com/data/icons/map-14/144/Map-10-128.png';
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
      icon: customIconBytes == null
          ? google_maps.BitmapDescriptor.defaultMarkerWithHue(
              google_maps.BitmapDescriptor.hueBlue)
          : google_maps.BitmapDescriptor.fromBytes(customIconBytes!),
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
      icon: customIconBytes == null
          ? google_maps.BitmapDescriptor.defaultMarker
          : google_maps.BitmapDescriptor.fromBytes(customIconBytes!),
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
          title: Text("Ponto: $idMarcador"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                child: Text(
                  "Coletar ponto",
                  style: TextStyle(
                    color: Colors.black, // Defina a cor do texto como preto
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _ontapColetar(idMarcador);
                },
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
              ElevatedButton(
                child: Text(
                  "Informar Inacessibilidade",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _ontapInacessivel(idMarcador);
                },
                style: ElevatedButton.styleFrom(primary: Colors.yellow),
              ),
            ],
          ),
        );
      },
    );
  }

  void _ontapColetar(String marcadorNome) {
    setState(() {
      var markerPos = markerPositions[marcadorNome];
      if (markerPos != null) {
        var newMarker = google_maps.Marker(
          markerId: google_maps.MarkerId(marcadorNome),
          position: markerPos,
          icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
              google_maps.BitmapDescriptor.hueGreen),
          onTap: () {
            _showModalOptions(marcadorNome);
          },
          draggable: false,
        );
        markers.removeWhere((m) => m.markerId.value == marcadorNome);
        markers.add(newMarker);
      } else {
        coletados[marcadorNome] = true;
        _updateMarkerColor(marcadorNome, true);
      }
    });
  }

  void _updateMarkerColor(String marcadorNome, bool coletado) {
    var newIcon = coletado
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
          title: Text("Opções para o ponto $marcadorNome"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _enableMarkerDrag(marcadorNome);
              },
              child: Text("Mover"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _removeMarker(marcadorNome);
              },
              child: Text("Excluir Ponto"),
            ),
          ],
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
              });
        }
        return m;
      }).toSet();
    });
  }

  void _removeMarker(String marcadorNome) {
    setState(() {
      markers.removeWhere((m) => m.markerId.value == marcadorNome);
      markerPositions.remove(marcadorNome);
    });
  }

//muda o foco
  void mudaFoco() {
    focoNoMarcador = false;
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
            onCameraMove: _onCameraMove,
            polygons: polygons,
            markers: markers,
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

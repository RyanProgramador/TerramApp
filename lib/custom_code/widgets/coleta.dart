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
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:geolocator/geolocator.dart';

class Coleta extends StatefulWidget {
  final double? width;
  final double? height;

  const Coleta({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

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

  double _currentZoom = 15.0; // Inicializa o zoom padrão
  Map<String, bool> coletados = {};

  @override
  void initState() {
    super.initState();
    _initializePolygons();
    _criaMarcadores();

    _trackUserLocation();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    _googleMapController?.dispose();
    super.dispose();
  }

  void _onCameraMove(google_maps.CameraPosition position) {
    _currentZoom = position.zoom; // Atualiza o zoom atual
  }

  void _initializePolygons() {
    // Implementação de exemplo
    List<google_maps.LatLng> latLngList = [
      google_maps.LatLng(-29.915044, -51.195798),
      google_maps.LatLng(-29.915091, -51.194011),
      google_maps.LatLng(-29.913644, -51.193930),
      google_maps.LatLng(-29.913558, -51.195563),
    ];
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
    ];

    for (var marcador in latLngListMarcadores) {
      var latlng = marcador["latlng_marcadores"]!.split(",");
      var marker = google_maps.Marker(
        markerId: google_maps.MarkerId(marcador["marcador_nome"]!),
        position: google_maps.LatLng(
            double.parse(latlng[0]), double.parse(latlng[1])),
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
            google_maps.BitmapDescriptor.hueRed),
        onTap: () {
          _showModalOptions(marcador["marcador_nome"]!);
        },
        draggable: false,
      );

      setState(() {
        markers.add(marker);
      });
    }
  }

  void _addUserMarker(google_maps.LatLng position) {
    final userLocationMarker = google_maps.Marker(
      markerId: const google_maps.MarkerId('current_location'),
      position: position,
      icon: google_maps.BitmapDescriptor
          .defaultMarker, // Substitua por um ícone personalizado se necessário
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
          _updateMapLocation();
        });
      },
    );
  }

  void _updateMapLocation() {
    if (_currentPosition != null && _googleMapController != null) {
      _googleMapController!.animateCamera(
        google_maps.CameraUpdate.newCameraPosition(
          google_maps.CameraPosition(
            target: google_maps.LatLng(
                _currentPosition!.latitude, _currentPosition!.longitude),
            zoom: _currentZoom ?? 18,
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
                child: Text("Coletar"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _ontapColetar(idMarcador);
                },
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
              ElevatedButton(
                child: Text("Informar Inacessibilidade"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _ontapInacessivel(idMarcador);
                },
                style: ElevatedButton.styleFrom(primary: Colors.yellow),
              ),
            ],
          ),
          actions: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _ontapColetar(String marcadorNome) {
    setState(() {
      coletados[marcadorNome] = true;
      _updateMarkerColor(marcadorNome, true);
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
          return m.copyWith(draggableParam: true);
        }
        return m;
      }).toSet();
    });
  }

  void _removeMarker(String marcadorNome) {
    setState(() {
      markers.removeWhere((m) => m.markerId.value == marcadorNome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: google_maps.GoogleMap(
        initialCameraPosition: google_maps.CameraPosition(
          target: google_maps.LatLng(-29.913558, -51.195563),
          zoom: _currentZoom,
        ),
        onMapCreated: (controller) {
          _googleMapController = controller;
        },
        onCameraMove: _onCameraMove,
        // Monitora movimentos da câmera
        polygons: polygons,
        markers: markers,
        mapType: google_maps.MapType.satellite,
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
      ),
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

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
import 'package:image/image.dart' as img;

import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;

class AreasPolygonos extends StatefulWidget {
  final double? width;
  final double? height;

  const AreasPolygonos({Key? key, this.width, this.height}) : super(key: key);

  @override
  State<AreasPolygonos> createState() => _AreasPolygonosState();
}

class _AreasPolygonosState extends State<AreasPolygonos> {
  // Define um zoom inicial para o mapa
  final double _currentZoom = 14.0;

  // Lista de coordenadas para os marcadores (deve ser convertida para LatLng)
  final List<google_maps.LatLng> _latLngListMarcadores = [
    google_maps.LatLng(-29.915140299498194, -51.19572058884172),
    google_maps.LatLng(-29.915121700737764, -51.19405761943544),
    google_maps.LatLng(-29.913615189607068, -51.19396105992153),
    google_maps.LatLng(-29.913531493875997, -51.19558111398829),
  ];

  // Inicializa o conjunto de polígonos
  Set<google_maps.Polygon> _polygons = {};

  @override
  void initState() {
    super.initState();
    _inicializaPoligonos();
  }

  void _inicializaPoligonos() {
    // Adiciona um polígono baseado na lista de marcadores
    setState(() {
      _polygons.add(
        google_maps.Polygon(
          polygonId: google_maps.PolygonId('area1'),
          points: _latLngListMarcadores,
          fillColor: Colors.green.withOpacity(0.5),
          strokeColor: Colors.green,
          strokeWidth: 2,
        ),
      );
    });
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
            polygons: _polygons,
            myLocationEnabled: true,
            mapType: google_maps.MapType.satellite,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
          ),
        ),
        // Widgets Positioned para botões removidos para brevidade
      ],
    );
  }

  // Métodos _exibirDados e mudaFoco removidos para brevidade
}

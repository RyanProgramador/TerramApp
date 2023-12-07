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

import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;

class MapsOffline extends StatefulWidget {
  const MapsOffline({
    Key? key,
    this.width,
    this.height,
    required this.coordenadasIniciais,
    required this.coordenadasFinais,
    this.json2,
  }) : super(key: key);

  final double? width;
  final double? height;
  final LatLng? coordenadasIniciais;
  final LatLng coordenadasFinais;
  final String? json2;

  @override
  _MapsOfflineState createState() => _MapsOfflineState();
}

class _MapsOfflineState extends State<MapsOffline> {
  Uint8List? customIconBytes;

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
  }

  Future<void> _loadCustomIcon() async {
    // Adicione a lógica para carregar o ícone customizado, se necessário
    // Deixe esta função vazia se você não quiser um ícone customizado
  }

  Set<google_maps.Marker> _createMarkers() {
    Set<google_maps.Marker> markers = Set();

    // Adicione o marcador inicial
    markers.add(
      google_maps.Marker(
        markerId: google_maps.MarkerId('MarkerID-Inicio'),
        position: google_maps.LatLng(
          widget.coordenadasIniciais?.latitude ?? 0.0,
          widget.coordenadasIniciais?.longitude ?? 0.0,
        ),
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
          google_maps.BitmapDescriptor.hueBlue,
        ),
      ),
    );

    // Adicione o marcador final
    markers.add(
      google_maps.Marker(
        markerId: google_maps.MarkerId(
            'MarkerID-Fim-${widget.coordenadasFinais.latitude}-${widget.coordenadasFinais.longitude}'),
        position: google_maps.LatLng(
          widget.coordenadasFinais.latitude ?? 0.0,
          widget.coordenadasFinais.longitude ?? 0.0,
        ),
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
          google_maps.BitmapDescriptor.hueRed,
        ),
      ),
    );

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 250.0,
      height: widget.height ?? 250.0,
      child: google_maps.GoogleMap(
        initialCameraPosition: google_maps.CameraPosition(
          target: google_maps.LatLng(
            widget.coordenadasIniciais?.latitude ?? 0.0,
            widget.coordenadasIniciais?.longitude ?? 0.0,
          ),
          zoom: 13,
        ),
        markers: _createMarkers(),
      ),
    );
  }
}

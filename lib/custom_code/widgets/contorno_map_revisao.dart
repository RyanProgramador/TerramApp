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
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;

class ContornoMapRevisao extends StatefulWidget {
  const ContornoMapRevisao({
    Key? key,
    this.width,
    this.height,
    required this.listaDeLatLng,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<google_maps.LatLng>? listaDeLatLng;

  @override
  _ContornoMapRevisaoState createState() => _ContornoMapRevisaoState();
}

class _ContornoMapRevisaoState extends State<ContornoMapRevisao> {
  google_maps.GoogleMapController? _googleMapController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width ?? MediaQuery.of(context).size.width,
          height: widget.height ?? MediaQuery.of(context).size.height,
          child: google_maps.GoogleMap(
            initialCameraPosition: google_maps.CameraPosition(
              target: widget.listaDeLatLng![0], // Define o centro do mapa
              zoom: 15.0, // Define o nível de zoom inicial
            ),
            onMapCreated: (controller) {
              setState(() {
                _googleMapController = controller;
              });
            },
            polygons: <google_maps.Polygon>{
              google_maps.Polygon(
                polygonId: google_maps.PolygonId('area'),
                points: widget.listaDeLatLng!,
                strokeWidth: 2,
                strokeColor: Colors.blue,
                fillColor: Colors.blue.withOpacity(0.3),
              ),
            },
          ),
        ),
      ],
    );
  }
}

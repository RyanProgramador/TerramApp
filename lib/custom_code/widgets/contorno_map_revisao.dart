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

import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;

class ContornoMapRevisao extends StatefulWidget {
  final double? width;
  final double? height;
  final List<google_maps.LatLng>? listaDeLatLng;

  const ContornoMapRevisao({
    Key? key,
    this.width,
    this.height,
    required this.listaDeLatLng,
  }) : super(key: key);

  @override
  _ContornoMapRevisaoState createState() => _ContornoMapRevisaoState();
}

class _ContornoMapRevisaoState extends State<ContornoMapRevisao> {
  google_maps.GoogleMapController? _googleMapController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: google_maps.GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: google_maps.CameraPosition(
          target: widget.listaDeLatLng?.first ?? google_maps.LatLng(0, 0),
          zoom: 14.0,
        ),
        markers: _buildMarkers(),
        polygons: _buildPolygons(),
      ),
    );
  }

  void _onMapCreated(google_maps.GoogleMapController controller) {
    setState(() {
      _googleMapController = controller;
    });
  }

  Set<google_maps.Marker> _buildMarkers() {
    return widget.listaDeLatLng?.map((google_maps.LatLng latLng) {
          return google_maps.Marker(
            markerId: google_maps.MarkerId('PolygonMarker'),
            position: latLng,
          );
        }).toSet() ??
        {};
  }

  Set<google_maps.Polygon> _buildPolygons() {
    return widget.listaDeLatLng != null && widget.listaDeLatLng!.length >= 3
        ? [
            google_maps.Polygon(
              polygonId: google_maps.PolygonId('Polygon'),
              points: widget.listaDeLatLng!,
              strokeWidth: 2,
              strokeColor: Colors.blue,
              fillColor: Colors.blue.withOpacity(0.3),
            ),
          ].toSet()
        : {};
  }
}

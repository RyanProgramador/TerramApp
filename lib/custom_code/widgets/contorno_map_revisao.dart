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
  const ContornoMapRevisao({
    Key? key,
    this.width,
    this.height,
    this.listaDeLatLng,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<String>? listaDeLatLng;

  @override
  _ContornoMapRevisaoState createState() => _ContornoMapRevisaoState();
}

class _ContornoMapRevisaoState extends State<ContornoMapRevisao> {
  List<google_maps.LatLng> toLatLng(List<String>? latLngStrings) {
    if (latLngStrings == null) return [];

    return latLngStrings
        .map((latLngString) {
          final latLngSplit =
              latLngString.split(',').map((s) => s.trim()).toList();
          if (latLngSplit.length == 2) {
            final lat = double.tryParse(latLngSplit[0]);
            final lng = double.tryParse(latLngSplit[1]);
            if (lat != null && lng != null) {
              return google_maps.LatLng(lat, lng);
            }
          }
          return null;
        })
        .where((latLng) => latLng != null)
        .cast<google_maps.LatLng>()
        .toList();
  }

  google_maps.GoogleMapController? _googleMapController;
  Set<google_maps.Polygon> polygons = Set();

  @override
  void initState() {
    super.initState();
    _initializePolygons();
  }

  void _initializePolygons() {
    final List<google_maps.LatLng> latLngList = toLatLng(widget.listaDeLatLng);

    if (latLngList.isNotEmpty) {
      final polygon = google_maps.Polygon(
        polygonId: const google_maps.PolygonId('AreaPolygon'),
        points: latLngList,
        fillColor: Colors.blue.withOpacity(0.2),
        strokeColor: Colors.blue,
        strokeWidth: 3,
      );

      setState(() {
        polygons.add(polygon);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final initialTarget =
        widget.listaDeLatLng != null && widget.listaDeLatLng!.isNotEmpty
            ? toLatLng(widget.listaDeLatLng)?.first
            : google_maps.LatLng(0.0, 0.0);

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: google_maps.GoogleMap(
        initialCameraPosition: google_maps.CameraPosition(
          target: initialTarget,
          zoom: 15,
        ),
        onMapCreated: (controller) => _googleMapController = controller,
        polygons: polygons,
        mapType: google_maps.MapType.satellite,
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
      ),
    );
  }
}

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
    this.cor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<String>? listaDeLatLng;
  final Color? cor;

  @override
  _ContornoMapRevisaoState createState() => _ContornoMapRevisaoState();
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

class _ContornoMapRevisaoState extends State<ContornoMapRevisao> {
  google_maps.GoogleMapController? _googleMapController;
  Set<google_maps.Polygon> polygons = Set();
  List<google_maps.LatLng> latLngList = [];

  @override
  void initState() {
    super.initState();
    if (widget.listaDeLatLng != null) {
      latLngList = toLatLng(widget.listaDeLatLng!);
      _initializePolygons();
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
    var corSTR = widget.cor.toString();
    if (latLngList.isNotEmpty) {
      final polygon = google_maps.Polygon(
        polygonId: const google_maps.PolygonId('AreaPolygon'),
        points: latLngList,
        fillColor: HexColor("$corSTR").withOpacity(0.2),
        strokeColor: HexColor("$corSTR"),
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
        latLngList.isNotEmpty ? latLngList.first : google_maps.LatLng(0.0, 0.0);

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

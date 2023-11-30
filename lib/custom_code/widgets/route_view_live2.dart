// Automatic FlutterFlow imports
import '/backend/backend.dart';
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

class RouteViewLive2 extends StatefulWidget {
  const RouteViewLive2({
    Key? key,
    this.width,
    this.height,
    required this.coordinates,
    required this.coordenadasIniciais,
    required this.coordenadasFinais,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<LatLng> coordinates;
  final LatLng coordenadasIniciais;
  final LatLng coordenadasFinais;

  @override
  _RouteViewLive2State createState() => _RouteViewLive2State();
}

class _RouteViewLive2State extends State<RouteViewLive2> {
  List<google_maps.LatLng> _convertToGoogleMapsLatLng(
      List<LatLng> coordinates) {
    return coordinates
        .map((coord) => google_maps.LatLng(coord.latitude, coord.longitude))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<google_maps.LatLng> googleMapsCoordinates =
        _convertToGoogleMapsLatLng(widget.coordinates);

    // Create a Set of markers for route coordinates
    final Set<google_maps.Marker> routeMarkers =
        googleMapsCoordinates.map((coordinate) {
      return google_maps.Marker(
        markerId: google_maps.MarkerId(
            'MarkerID-${coordinate.latitude}-${coordinate.longitude}'),
        position: coordinate,
        visible: false, // Ocultar os marcadores padrão
        icon: google_maps.BitmapDescriptor.defaultMarker,
      );
    }).toSet();

    // Create a Set of markers for coordenadasIniciais and coordenadasFinais
    final Set<google_maps.Marker> additionalMarkers = {
      google_maps.Marker(
        markerId: google_maps.MarkerId('MarkerID-Inicial'),
        position: google_maps.LatLng(
          widget.coordenadasIniciais.latitude,
          widget.coordenadasIniciais.longitude,
        ),
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
          google_maps.BitmapDescriptor.hueGreen,
        ),
      ),
      google_maps.Marker(
        markerId: google_maps.MarkerId('MarkerID-Final'),
        position: google_maps.LatLng(
          widget.coordenadasFinais.latitude,
          widget.coordenadasFinais.longitude,
        ),
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
          google_maps.BitmapDescriptor.hueRed,
        ),
      ),
    };

    // Create a Polyline with blue color
    final google_maps.Polyline polyline = google_maps.Polyline(
      polylineId: google_maps.PolylineId("PolylineID"),
      color: Colors.blue,
      points: googleMapsCoordinates,
    );

    routeMarkers.addAll(
        additionalMarkers); // Adicionar os marcadores adicionais ao conjunto de marcadores da rota

    return Container(
      width: widget.width ?? 400.0,
      height: widget.height ?? 400.0,
      child: google_maps.GoogleMap(
        initialCameraPosition: google_maps.CameraPosition(
          target: googleMapsCoordinates.last,
          zoom: 15,
        ),
        markers: routeMarkers, // Set de marcadores
        polylines: {polyline}, // Adicionar a polilinha ao mapa
      ),
    );
  }
}

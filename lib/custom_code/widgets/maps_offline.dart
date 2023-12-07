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

import 'dart:typed_data';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;

class MapsOffline extends StatefulWidget {
  const MapsOffline({
    Key? key,
    this.width,
    this.height,
    required this.coordenadasIniciais,
    required this.coordenadasFinais,
  }) : super(key: key);

  final double? width;
  final double? height;
  final LatLng? coordenadasIniciais;
  final LatLng
      coordenadasFinais; // = LatLng(-29.234876535697982, -51.8712256298171);

  LatLng calculateMiddlePosition() {
    double middleLat =
        (coordenadasIniciais!.latitude + coordenadasFinais.latitude) / 2;
    double middleLong =
        (coordenadasIniciais!.longitude + coordenadasFinais.longitude) / 2;

    return LatLng(middleLat, middleLong);
  }

  @override
  _MapsOfflineState createState() => _MapsOfflineState();
}

class _MapsOfflineState extends State<MapsOffline> {
  Uint8List? customIconBytes;
  late google_maps.GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
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

  void _onMapCreated(google_maps.GoogleMapController controller) {
    mapController = controller;
    _adjustCamera();
  }

  double calculateZoomLevel(LatLng point1, LatLng point2) {
    const double initialZoom = 11.64567; // Zoom inicial
    const double zoomThreshold =
        12.0; // Limite de distância para o zoom inicial

    double distance = calculateDistance(point1, point2);

    if (distance <= zoomThreshold) {
      return initialZoom;
    } else {
      // Fórmula de ajuste do zoom com base na distância
      return initialZoom - (math.log(distance / zoomThreshold) / math.log(2.0));
    }
  }

  double calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371.0; // Raio médio da Terra em quilômetros

    double lat1Radians = radians(point1.latitude);
    double lon1Radians = radians(point1.longitude);
    double lat2Radians = radians(point2.latitude);
    double lon2Radians = radians(point2.longitude);

    double dlon = lon2Radians - lon1Radians;
    double dlat = lat2Radians - lat1Radians;

    double a = math.pow(math.sin(dlat / 2), 2) +
        math.cos(lat1Radians) *
            math.cos(lat2Radians) *
            math.pow(math.sin(dlon / 2), 2);

    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }

  double radians(double degrees) {
    return degrees * (math.pi / 180);
  }

  void _adjustCamera() {
    if (widget.coordenadasIniciais != null &&
        widget.coordenadasFinais != null) {
      double zoomLevel = calculateZoomLevel(
        widget.coordenadasIniciais!,
        widget.coordenadasFinais,
      );

      google_maps.LatLngBounds bounds = google_maps.LatLngBounds(
        southwest: google_maps.LatLng(
          widget.coordenadasIniciais!.latitude,
          widget.coordenadasIniciais!.longitude,
        ),
        northeast: google_maps.LatLng(
          widget.coordenadasFinais.latitude,
          widget.coordenadasFinais.longitude,
        ),
      );

      mapController.animateCamera(
        google_maps.CameraUpdate.newLatLngBounds(
          bounds,
          50.0, // 50 padding, adjust as needed
        ),
      );

      mapController.animateCamera(google_maps.CameraUpdate.zoomTo(zoomLevel));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 250.0,
      height: widget.height ?? 250.0,
      child: google_maps.GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: google_maps.CameraPosition(
          target: google_maps.LatLng(
            widget.calculateMiddlePosition().latitude,
            widget.calculateMiddlePosition().longitude,
          ),
          zoom: 13,
        ),
        markers: _createMarkers(),
      ),
    );
  }
}

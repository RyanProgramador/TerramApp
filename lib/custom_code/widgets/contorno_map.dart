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

class ContornoMap extends StatefulWidget {
  const ContornoMap(
      {Key? key,
      this.width,
      this.height,
      this.ativoOuNao,
      required this.localizacaoAtual})
      : super(key: key);

  final double? width;
  final double? height;
  final bool? ativoOuNao;
  final double? localizacaoAtual;

  @override
  _ContornoMapState createState() => _ContornoMapState();
}

class _ContornoMapState extends State<ContornoMap> {
  Position? position;
  google_maps.GoogleMapController? _googleMapController;
  List<google_maps.Marker> markers = [];
  List<google_maps.Polygon> polygons = [];
  bool isLocationPaused = false;

  double currentZoom = 10.0;
  LatLng? currentTarget;

  void _onMapCreated(google_maps.GoogleMapController controller) {
    _googleMapController = controller;
    _getCurrentLocation(); // Inicializar a posição atual ao criar o mapa
  }

  void _getCurrentLocation() async {
    if (widget.ativoOuNao == true) {
      if (!isLocationPaused) {
        Position newLoc = await Geolocator.getCurrentPosition();

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
        currentTarget = LatLng(newLoc.latitude, newLoc.longitude);
        currentZoom = 10; // Atualizar o zoom padrão

        setState(() {
          position = newLoc;
          markers.add(
            google_maps.Marker(
              markerId: google_maps.MarkerId('UserMarkerID${markers.length}'),
              position: google_maps.LatLng(
                newLoc.latitude,
                newLoc.longitude,
              ),
              icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
                google_maps.BitmapDescriptor.hueBlue,
              ),
              visible: true,
              draggable: false,
              infoWindow: google_maps.InfoWindow(
                title:
                    'UserMarkerID${markers.length}', // Define a posição do pop-up para o centro do marcador
              ),
            ),
          );
          _updatePolygon();
        });
      }
    }
  }

  void _centerMap() {
    if (currentTarget != null && _googleMapController != null) {
      _googleMapController!.animateCamera(
        google_maps.CameraUpdate.newLatLngZoom(
          google_maps.LatLng(currentTarget!.latitude, currentTarget!.longitude),
          currentZoom,
        ),
      );
    }
  }

  void _updatePolygon() {
    setState(() {
      // Recalcular as coordenadas do polígono
      List<google_maps.LatLng> polygonCoordinates =
          markers.map((marker) => marker.position).toList();
      polygons.clear(); // Limpar polígonos existentes
      if (polygonCoordinates.length >= 3) {
        var polygon = google_maps.Polygon(
          polygonId: google_maps.PolygonId('AreaPolygon'),
          points: polygonCoordinates,
          fillColor: Colors.blue.withOpacity(0.2),
          strokeColor: Colors.blue,
          strokeWidth: 6,
        );
        polygons.add(polygon);
      }
    });
  }

  void _toggleLocationPause() {
    setState(() {
      isLocationPaused = !isLocationPaused;
    });
  }

  void _clearMarkersAndPolygons() {
    setState(() {
      markers.clear();
      polygons.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    // Update location every 2 seconds
    Timer.periodic(Duration(seconds: 2), (Timer t) => _getCurrentLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width ?? 400.0,
          height: widget.height ?? 400.0,
          child: google_maps.GoogleMap(
            initialCameraPosition: google_maps.CameraPosition(
              target: google_maps.LatLng(
                widget.localizacaoAtual.latitude ?? 0.0,
                widget.localizacaoAtual.longitude ?? 0.0,
              ),
              zoom: 10,
            ),
            onMapCreated: _onMapCreated,
            markers: {...markers}.toSet(),
            polygons: {...polygons}.toSet(),
            mapType: google_maps.MapType.satellite,
          ),
        ),
        Positioned(
          top: 62,
          right: 16,
          child: ElevatedButton(
            onPressed: _toggleLocationPause,
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Color(0xFF00736D),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isLocationPaused
                  ? Icon(
                      Icons.play_arrow,
                      size: 25.0,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.pause,
                      size: 25.0,
                      color: Colors.white,
                    ),
            ),
          ),
        ),
        Positioned(
          top: 62,
          left: MediaQuery.of(context).size.width / 2 - 44,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Color(0xFF00736D),
            ),
            onPressed: _centerMap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.center_focus_strong,
                size: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          top: 62,
          left: 16,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Color(0xFF00736D),
            ),
            onPressed: _clearMarkersAndPolygons,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete,
                size: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

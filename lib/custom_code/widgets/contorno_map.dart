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
  const ContornoMap({
    Key? key,
    this.width,
    this.height,
    this.ativoOuNao,
    this.localAtual,
    this.oservid,
    this.idContorno,
  }) : super(key: key);

  final double? width;
  final double? height;
  final bool? ativoOuNao;
  final LatLng? localAtual;
  final String? oservid;
  final String? idContorno;
  @override
  _ContornoMapState createState() => _ContornoMapState();
}

class _ContornoMapState extends State<ContornoMap> {
  Position? position;
  google_maps.GoogleMapController? _googleMapController;
  List<google_maps.Marker> markers = [];
  List<google_maps.Polygon> polygons = [];
  List<google_maps.Polyline> polylines = [];
  bool isLocationPaused = false;
  double currentZoom = 20.0;
  google_maps.LatLng? currentTarget;
  late String oservid;
  late String idContorno;
  List<Map<String, dynamic>> dados = []; // Variável para armazenar dados

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
        currentTarget = google_maps.LatLng(newLoc.latitude, newLoc.longitude);
        currentZoom = 20;

        setState(() {
          position = newLoc;
          _addUserMarker(google_maps.LatLng(newLoc.latitude, newLoc.longitude));
          _updatePolyline();
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

  void _updatePolyline() {
    setState(() {
      // Recalcular as coordenadas da linha
      List<google_maps.LatLng> polylineCoordinates =
          markers.map((marker) => marker.position).toList();
      polylines.clear(); // Limpar linhas existentes
      if (polylineCoordinates.isNotEmpty) {
        var polyline = google_maps.Polyline(
          polylineId: google_maps.PolylineId('RoutePolyline'),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 3,
        );
        polylines.add(polyline);
      }
    });
  }

  void _finalizeArea() {
    if (markers.isNotEmpty && _distanceToStart() <= 50) {
      setState(() {
        // Transformar a linha em um polígono fechado
        var polygonCoordinates = List<google_maps.LatLng>.from(
            markers.map((marker) => marker.position));
        polygonCoordinates.add(markers.first.position); // Fechar o polígono
        polygons.clear();
        polygons.add(
          google_maps.Polygon(
            polygonId: google_maps.PolygonId('AreaPolygon'),
            points: polygonCoordinates,
            fillColor: Colors.blue.withOpacity(0.2),
            strokeColor: Colors.blue,
            strokeWidth: 3,
          ),
        );

        // Salvar dados
        int markerId = 1;
        for (var coord in polygonCoordinates) {
          Map<String, dynamic> contorno = {
            "contorno_grupo": widget.idContorno,
            "marker_id": markerId++,
            "oserv_id": widget.oservid,
            "latlng": "${coord.latitude}, ${coord.longitude}"
          };
          FFAppState().contornoFazenda.add(contorno);
        }
      });
    }
  }

  double _distanceToStart() {
    if (markers.isEmpty || position == null) return double.infinity;
    var start = markers.first.position;
    var current = google_maps.LatLng(position!.latitude, position!.longitude);
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      current.latitude,
      current.longitude,
    );
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
      polylines.clear();
      dados.clear();
    });
  }

  void _addUserMarker(google_maps.LatLng position) {
    markers.add(
      google_maps.Marker(
        markerId: google_maps.MarkerId('UserMarkerID'),
        position: google_maps.LatLng(
          position.latitude,
          position.longitude,
        ),
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
          google_maps.BitmapDescriptor.hueRed,
        ),
        visible: true,
        draggable: false,
        infoWindow: google_maps.InfoWindow(
          title: 'Você esta aqui!', // Adicione o título do marcador
        ),
      ),
    );
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
                widget.localAtual?.latitude ?? 0.0,
                widget.localAtual?.longitude ?? 0.0,
              ),
              zoom: 20,
            ),
            onMapCreated: _onMapCreated,
            markers: {...markers}.toSet(),
            polygons: {...polygons}.toSet(),
            polylines: {...polylines}.toSet(),
            mapType: google_maps.MapType.satellite,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
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
        Positioned(
          top: 552,
          right: -8,
          child: Visibility(
            visible: _distanceToStart() <= 50,
            child: ElevatedButton(
              onPressed: _finalizeArea,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Color(0xFFC13131),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check,
                  size: 62.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

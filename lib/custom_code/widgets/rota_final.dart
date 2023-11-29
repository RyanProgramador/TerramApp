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

import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as poly;
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:custom_marker/marker_icon.dart' as cust;

//NOTA MENTAL, ESSE CODIGO ESTA EM DESENVOLVIMENTO,
//OS COMENTARIOS FEITOS NESSE CODIGO FORAM FEITOS APÓS ELE ESTAR SEMI-FINALIZADO,
//PODE CAUSAR CONFUSÃO E TRISTEZA
class RotaFinal extends StatefulWidget {
  const RotaFinal({
    Key? key,
    this.width,
    this.height,
    required this.coordenadasIniciais,
    required this.coordenadasFinais,
    required this.json2,
    this.stringDoRotas,
  }) : super(key: key);

  final double? width;
  final double? height;
  final LatLng coordenadasIniciais;
  final LatLng coordenadasFinais;
  final String json2;
  final String? stringDoRotas;

  final String customIconUrl =
      'https://lh3.googleusercontent.com/u/9/drive-viewer/AK7aPaD4V4OUOT1q2oukdiVXFD-_sP6u4FeZRmV9RxR7CRR8Oi9Ga237m_3yoSHbXNRqx4JvQW1PmOUtuHYdk-71UYL-DjQZEw=w1278-h913';

  @override
  _MapsRoutesState createState() => _MapsRoutesState();
}

class _MapsRoutesState extends State<RotaFinal> {
  //position é a posição atual
  Position? position;
  //esse é o formato do icone cara
  Uint8List? customIconBytes;
  //inporante para o controle do maps
  google_maps.GoogleMapController? _googleMapController;
//adiciona quando o mapa é criado
  void _onMapCreated(google_maps.GoogleMapController controller) {
    _googleMapController = controller;
  }

  //para polylines
  List<google_maps.LatLng> routePoints = [];

//cria a rota para cada etapa
  Set<google_maps.Marker> _createRouteFromSteps(List<dynamic> steps) {
    Set<google_maps.Marker> routeMarkers = Set();
    List<google_maps.LatLng> routeCoordinates = [];

    for (var step in steps) {
      var startLocation = (step['start_location'] as Map<String, dynamic>);
      var endLocation = (step['end_location'] as Map<String, dynamic>);

      var startLatLng = google_maps.LatLng(
        startLocation['lat'] as double,
        startLocation['lng'] as double,
      );
      var endLatLng = google_maps.LatLng(
        endLocation['lat'] as double,
        endLocation['lng'] as double,
      );

      routeCoordinates.add(startLatLng);

      if (routeCoordinates.length > 1) {
        routeCoordinates.removeLast();
      }

      routeMarkers.add(
        google_maps.Marker(
          markerId: google_maps.MarkerId(
              'MarkerID-Start-${startLatLng.latitude}-${startLatLng.longitude}'),
          position: startLatLng,
          visible: false,
          icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
            google_maps.BitmapDescriptor.hueGreen,
          ),
        ),
      );
      routeMarkers.add(
        google_maps.Marker(
          markerId: google_maps.MarkerId(
              'MarkerID-End-${endLatLng.latitude}-${endLatLng.longitude}'),
          position: endLatLng,
          visible: false,
          icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
            google_maps.BitmapDescriptor.hueRed,
          ),
        ),
      );
    }

    return routeMarkers;
  }

//carrega o icone custom
  Future<void> _loadCustomIcon() async {
    if (widget.customIconUrl != null && widget.customIconUrl!.isNotEmpty) {
      try {
        final response = await http.get(Uri.parse(widget.customIconUrl!));
        if (response.statusCode == 200) {
          setState(() {
            customIconBytes = response.bodyBytes;
          });
        } else {
          print(
              "Failed to load custom icon. Status code: ${response.statusCode}");
        }
      } catch (e) {
        print("Error loading custom icon: $e");
      }
    }
  }

//adiciona o custom icone no mapa na posição tal
  Set<google_maps.Marker> _createCustomMarker() {
    Set<google_maps.Marker> customMarkers = Set();

    var customMarkerLatLng = google_maps.LatLng(
      position?.latitude ?? 0.0,
      position?.longitude ?? 0.0,
    );
//marcador atual do usuario
    customMarkers.add(
      google_maps.Marker(
        markerId: google_maps.MarkerId('CustomMarkerID'),
        position: customMarkerLatLng,
        icon: customIconBytes != null
            ? google_maps.BitmapDescriptor.fromBytes(customIconBytes!)
            : google_maps.BitmapDescriptor.defaultMarkerWithHue(
                google_maps.BitmapDescriptor.hueBlue,
              ),
        // Call a separate function to get the custom icon.
        anchor: Offset(0.5, 0.5),
      ),
    );

    return customMarkers;
  }

//faço a menor ideia, acho que é a parte de posição de cada atualização com a position atual
  void addRoutePoints() {
    var polylinesRed = widget.stringDoRotas;
    if (polylinesRed != null) {
      List<poly.PointLatLng> decodedPolylinePoints =
          poly.PolylinePoints().decodePolyline(polylinesRed);

      for (poly.PointLatLng point in decodedPolylinePoints) {
        routePoints.add(google_maps.LatLng(point.latitude, point.longitude));
      }
      print(
          "Route Points: $routePoints"); // Adicione este log para verificar a lista
      setState(() {});
    } else {
      var polylinesRed =
          'zwquDrcnwH`@qPFkBhNj@HiEL}DtB{FTk@bHgCjCeAnBi@hDi@|HkAn@}SrCc@jAUXKx@e@f@_@d@i@f@aA|AcGHs@Bm@I_Ai@wD?]m@}EAUBg@@aBiADkANoCLoJJgCHaHJsCD}BEgNi@v@aZ\\sKDgBN_HN_HZsG@]PKFUCUSUWEOFwCQGY?KDE~BLNADCDIAKGEs@@sGUg@PyG_@';
      List<poly.PointLatLng> decodedPolylinePoints =
          poly.PolylinePoints().decodePolyline(polylinesRed);

      for (poly.PointLatLng point in decodedPolylinePoints) {
        routePoints.add(google_maps.LatLng(point.latitude, point.longitude));
      }
      print(
          "Route Points: $routePoints"); // Adicione este log para verificar a lista
      setState(() {});
    }
  }

//atualiza a cada momento a posição atual do user
  void _getCurrentLocation() async {
    Geolocator.getPositionStream().listen((Position newLoc) async {
      if (_googleMapController != null) {
        double currentZoomLevel = await _googleMapController!.getZoomLevel();

        _googleMapController!.animateCamera(
          google_maps.CameraUpdate.newCameraPosition(
            google_maps.CameraPosition(
              target: google_maps.LatLng(
                newLoc.latitude,
                newLoc.longitude,
              ),
              zoom: currentZoomLevel ?? 14,
            ),
          ),
        );
      }

      setState(() {
        position = newLoc;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    addRoutePoints();
    _loadCustomIcon();
  }

  @override
  Widget build(BuildContext context) {
    var response = json.decode(widget.json2);

    List<dynamic> steps = (response['routes'] as List?)?[0]['legs']?[0]['steps']
            as List<dynamic>? ??
        [];

    var finalLatLng = google_maps.LatLng(
      (response['routes'] as List?)?[0]['legs']?[0]['end_location']?['lat']
              as double? ??
          0.0,
      (response['routes'] as List?)?[0]['legs']?[0]['end_location']?['lng']
              as double? ??
          0.0,
    );

    var inicialLatLng = google_maps.LatLng(
      (response['routes'] as List?)?[0]['legs']?[0]['start_location']?['lat']
              as double? ??
          0.0,
      (response['routes'] as List?)?[0]['legs']?[0]['start_location']?['lng']
              as double? ??
          0.0,
    );
    Set<google_maps.Marker> routeMarkers = _createRouteFromSteps(steps);
    routeMarkers.add(
      google_maps.Marker(
        markerId: google_maps.MarkerId(
            'MarkerID-Fim-${finalLatLng.latitude}-${finalLatLng.longitude}'),
        position: google_maps.LatLng(
          finalLatLng.latitude,
          finalLatLng.longitude,
        ),
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
          google_maps.BitmapDescriptor.hueRed,
        ),
      ),
    );
    Set<google_maps.Marker> allMarkers =
        routeMarkers.union(_createCustomMarker());

    return Container(
      width: widget.width ?? 400.0,
      height: widget.height ?? 400.0,
      child: google_maps.GoogleMap(
        initialCameraPosition: google_maps.CameraPosition(
          target: google_maps.LatLng(
            position?.latitude ?? finalLatLng.latitude,
            position?.longitude ?? finalLatLng.latitude,
          ),
          zoom: 19,
          tilt: 60,
          bearing: 90,
        ),
        onMapCreated: _onMapCreated,
        markers: allMarkers,
        polylines: {
          google_maps.Polyline(
            //polylineId: google_maps.PolylineId("PolylineID"),
            //color: Colors.blue,
            //points: routeMarkers.map((marker) => marker.position).toList(),

            //points: routePoints,
            //geodesic: true,
            //),
            //google_maps.Polyline(
            polylineId: google_maps.PolylineId("RedPolyline"),
            color: Colors.blue,
            points: routePoints ??
                routeMarkers.map((marker) => marker.position).toList(),
          ),
        },
      ),
    );
  }
}

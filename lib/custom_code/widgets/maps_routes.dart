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

import 'package:flutter_polyline_points/flutter_polyline_points.dart' as poly;
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:custom_marker/marker_icon.dart' as cust;
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;

class MapsRoutes extends StatefulWidget {
  const MapsRoutes({
    Key? key,
    this.width,
    this.height,
    required this.coordenadasIniciais,
    required this.coordenadasFinais,
    this.json2,
    this.stringDoRotas,
  }) : super(key: key);

  final double? width;
  final double? height;
  final LatLng? coordenadasIniciais;
  final LatLng coordenadasFinais;
  final String? json2;
  final String? stringDoRotas;
  final String customIconUrl =
      'https://lh3.googleusercontent.com/u/9/drive-viewer/AK7aPaD4V4OUOT1q2oukdiVXFD-_sP6u4FeZRmV9RxR7CRR8Oi9Ga237m_3yoSHbXNRqx4JvQW1PmOUtuHYdk-71UYL-DjQZEw=w1278-h913';

  @override
  _MapsRoutesState createState() => _MapsRoutesState();
}

class _MapsRoutesState extends State<MapsRoutes> {
  Uint8List? customIconBytes;
  bool? estiloMapa = false;
  //para polylines
  List<google_maps.LatLng> routePoints = [];

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

      // Adicione apenas as coordenadas intermediárias
      if (routeCoordinates.length > 1) {
        routeCoordinates.removeLast();
      }

      //Adicione marcadores para as localizações iniciais e finais de cada etapa
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

//desenha a rota no mapa
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

  Set<google_maps.Marker> _createCustomMarker() {
    Set<google_maps.Marker> customMarkers = Set();

    var customMarkerLatLng = google_maps.LatLng(
      widget.coordenadasIniciais?.latitude ?? 0.0,
      widget.coordenadasIniciais?.longitude ?? 0.0,
    );
    //nao sei mas acho que é o polylines
    customMarkers.add(
      google_maps.Marker(
        markerId: google_maps.MarkerId('CustomMarkerID'),
        position: customMarkerLatLng,
        icon: customIconBytes != null
            ? google_maps.BitmapDescriptor.fromBytes(customIconBytes!)
            : google_maps.BitmapDescriptor.defaultMarkerWithHue(
                google_maps.BitmapDescriptor.hueBlue,
              ), // Call a separate function to get the custom icon.
      ),
    );

    return customMarkers;
  }

  void mudaEstiloMapa() {
    setState(() {
      if (estiloMapa == true) {
        estiloMapa = false;
      } else {
        estiloMapa = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
    addRoutePoints();
  }

  @override
  Widget build(BuildContext context) {
    var response = json.decode(widget.json2 ?? '');

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

    var inidtialLatLng = google_maps.LatLng(
      (response['routes'] as List?)?[0]['legs']?[0]['start_location']?['lat']
              as double? ??
          0.0,
      (response['routes'] as List?)?[0]['legs']?[0]['start_location']?['lng']
              as double? ??
          0.0,
    );
    Set<google_maps.Marker> routeMarkers = _createRouteFromSteps(steps);
    // Adicione um marcador no final da rota usando as coordenadas finais
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
    //routeMarkers.add(
    //  google_maps.Marker(
    //    markerId: google_maps.MarkerId(
    //        'MarkerID-Inicio-${inidtialLatLng.latitude}-${inidtialLatLng.longitude}'),
    //    position: google_maps.LatLng(
    //      inidtialLatLng.latitude,
    //      inidtialLatLng.longitude,
    //    ),
    //    icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
    //      google_maps.BitmapDescriptor.hueGreen,
    //    ),
    //  ),
    //);
    Set<google_maps.Marker> allMarkers =
        routeMarkers.union(_createCustomMarker());

    return Stack(
      children: [
        Container(
          width: widget.width ?? 250.0,
          height: widget.height ?? 250.0,
          child: google_maps.GoogleMap(
            initialCameraPosition: google_maps.CameraPosition(
              target: google_maps.LatLng(
                widget.coordenadasIniciais?.latitude ?? inidtialLatLng.latitude,
                widget.coordenadasIniciais?.longitude ??
                    inidtialLatLng.longitude,
              ),
              zoom: 13,
            ),
            markers: allMarkers,
            mapType: estiloMapa == true
                ? google_maps.MapType.satellite
                : google_maps.MapType.normal,
            polylines: {
              google_maps.Polyline(
                //polylineId: google_maps.PolylineId("PolylineID"),
                //color: Colors.blue,
                //points: routeMarkers
                //    .map((marker) => marker.position)
                //    .toList(), // Utilizando as posições dos marcadores para criar a polilinha
                polylineId: google_maps.PolylineId("RedPolyline"),
                color: Colors.blue,
                points: routePoints ??
                    routeMarkers.map((marker) => marker.position).toList(),
              ),
            },
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 8.65 -
              28.0, // Adjust the top position as needed
          right: 5, // Adjust the left position as needed
          child: ElevatedButton(
            onPressed: () {
              mudaEstiloMapa();
            },
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Color(0xFF00736D),
            ),
            child: Transform.rotate(
              angle: 0, // Your rotation angle here based on compass direction,
              child: Icon(
                Icons.satellite_alt_sharp, // or any other compass-related icon
                size: 25.0,
                color: Colors.white, // Adjust the size as needed
              ),
            ),
          ),
        ),
      ],
    );
  }
}

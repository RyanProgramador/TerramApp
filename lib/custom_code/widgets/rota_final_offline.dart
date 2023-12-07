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

class RotaFinalOffline extends StatefulWidget {
  const RotaFinalOffline({
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
  _RotaFinalOfflineState createState() => _RotaFinalOfflineState();
}

class _RotaFinalOfflineState extends State<RotaFinalOffline> {
  Uint8List? customIconBytes;

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
    //var polylinesRed = widget.stringDoRotas;
    var polylinesRed =
        r'ntquDhnmwH~Rv@HiEL}DtB{FTk@bHgCjCeAnBi@hDi@|HkAn@}SrCc@jAUXKx@e@f@_@d@i@f@aA|AcGHs@Bm@I_Ai@wD?]m@}EAUBg@@aBWcBEOm@}AcF_Iu@kAg@g@sEmCo@_@q@i@s@_ASk@kEyTk@cDKuAGsA?q@FsCBW{Rw@QWWGQDg@AqBMGY?KDE~BLNADCDIAKGEs@@oGW';
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

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
    addRoutePoints();
  }

  @override
  Widget build(BuildContext context) {
    var response = json.decode(widget.json2 ??
        r'{ "geocoded_waypoints" : [ { "geocoder_status" : "OK", "place_id" : "ChIJiUEINLJ6GZURVbONaqvR8yo", "types" : [ "street_address" ] }, { "geocoder_status" : "OK", "place_id" : "ChIJ-djliDRxGZURaclQCmXxYjg", "types" : [ "street_address" ] } ], "routes" : [ { "bounds" : { "northeast" : { "lat" : -29.9148598, "lng" : -51.16550429999999 }, "southwest" : { "lat" : -29.9265705, "lng" : -51.19249 } }, "copyrights" : "Map data ©2023", "legs" : [ { "distance" : { "text" : "4,4 km", "value" : 4445 }, "duration" : { "text" : "12 minutos", "value" : 746 }, "end_address" : "Av. Farroupilha, 4545 - Mathias Velho, Canoas - RS, 92020-475, Brasil", "end_location" : { "lat" : -29.9157738, "lng" : -51.16550429999999 }, "start_address" : "Av. José Maia Filho, 835 - Harmonia, Canoas - RS, 92310-500, Brasil", "start_location" : { "lat" : -29.9148598, "lng" : -51.1922428 }, "steps" : [ { "distance" : { "text" : "0,3 km", "value" : 315 }, "duration" : { "text" : "1 min", "value" : 37 }, "end_location" : { "lat" : -29.9176801, "lng" : -51.19249 }, "html_instructions" : "Siga na direção \u003cb\u003esul\u003c/b\u003e na \u003cb\u003eAv. José Maia Filho\u003c/b\u003e em direção à \u003cb\u003eR. Machado de Assis\u003c/b\u003e", "polyline" : { "points" : "zvquDnnmwHhADzDPrFTx@B" }, "start_location" : { "lat" : -29.9148598, "lng" : -51.1922428 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0,4 km", "value" : 352 }, "duration" : { "text" : "1 min", "value" : 63 }, "end_location" : { "lat" : -29.9184986, "lng" : -51.189049 }, "html_instructions" : "Vire à \u003cb\u003eesquerda\u003c/b\u003e depois de Agropecuária Harmonia (à direita)", "maneuver" : "turn-left", "polyline" : { "points" : "nhruD`pmwHDeBBcBL}DvA}D?AJWPc@Tk@" }, "start_location" : { "lat" : -29.9176801, "lng" : -51.19249 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0,6 km", "value" : 602 }, "duration" : { "text" : "1 min", "value" : 82 }, "end_location" : { "lat" : -29.923657, "lng" : -51.1872245 }, "html_instructions" : "Curva suave à \u003cb\u003edireita\u003c/b\u003e na \u003cb\u003eR. Brasil\u003c/b\u003e", "maneuver" : "turn-slight-right", "polyline" : { "points" : "rmruDpzlwHFCLEZMl@UbBk@~Am@h@WTIjAc@r@Uz@SjBYt@MFA`BUzEu@" }, "start_location" : { "lat" : -29.9184986, "lng" : -51.189049 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0,3 km", "value" : 324 }, "duration" : { "text" : "1 min", "value" : 49 }, "end_location" : { "lat" : -29.9239045, "lng" : -51.1838735 }, "html_instructions" : "Vire à \u003cb\u003eesquerda\u003c/b\u003e depois de Churrascaria Brasil (à esquerda)", "maneuver" : "turn-left", "polyline" : { "points" : "zmsuDbolwHDyAN{DLcEJcE" }, "start_location" : { "lat" : -29.923657, "lng" : -51.1872245 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0,7 km", "value" : 737 }, "duration" : { "text" : "2 minutos", "value" : 101 }, "end_location" : { "lat" : -29.9260876, "lng" : -51.1780262 }, "html_instructions" : "Vire à \u003cb\u003edireita\u003c/b\u003e na \u003cb\u003eR. Dr. Barcelos\u003c/b\u003e", "maneuver" : "turn-right", "polyline" : { "points" : "josuDdzkwH~@OrASjAUXKf@WPMRORONQTWLWXi@z@eDHUVgAHs@@]@OC]?IEWGe@ACSwACICUCU@YAC?KKw@SmAKy@AI?GAUBg@" }, "start_location" : { "lat" : -29.9239045, "lng" : -51.1838735 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0,6 km", "value" : 550 }, "duration" : { "text" : "2 minutos", "value" : 95 }, "end_location" : { "lat" : -29.9232064, "lng" : -51.1737014 }, "html_instructions" : "Continue para \u003cb\u003eAv. Inconfidência\u003c/b\u003e", "polyline" : { "points" : "`}suDtujwH@aBM{@Ig@EOm@}Am@aAW_@S[[c@EIg@u@Q[QU[k@u@kAQSIIEEECGEKGSMi@]SKWOu@c@" }, "start_location" : { "lat" : -29.9260876, "lng" : -51.1780262 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0,8 km", "value" : 768 }, "duration" : { "text" : "3 minutos", "value" : 153 }, "end_location" : { "lat" : -29.920898, "lng" : -51.1665351 }, "html_instructions" : "Continue em frente quando passar por Droga Raia para permanecer na \u003cb\u003eAv. Inconfidência\u003c/b\u003e", "maneuver" : "straight", "polyline" : { "points" : "`ksuDrziwH_@SWMA?MIGGWQMKKKSYQSMQEKCGCEAGCIQy@Oy@eAiFs@uDQy@]kB[aBOaACWCQAYAQAOASAQA]?q@@kA@I@g@@U" }, "start_location" : { "lat" : -29.9232064, "lng" : -51.1737014 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0,4 km", "value" : 366 }, "duration" : { "text" : "1 min", "value" : 47 }, "end_location" : { "lat" : -29.9177399, "lng" : -51.1661362 }, "html_instructions" : "Vire à \u003cb\u003eesquerda\u003c/b\u003e na \u003cb\u003eAv. Farroupilha\u003c/b\u003e", "maneuver" : "turn-left", "polyline" : { "points" : "r|ruDzmhwH@Q@Eg@C}CMM?m@Ei@Am@C}@EcAEE?oAE[CMAMAQ?" }, "start_location" : { "lat" : -29.920898, "lng" : -51.1665351 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0,1 km", "value" : 126 }, "duration" : { "text" : "1 min", "value" : 14 }, "end_location" : { "lat" : -29.91666859999999, "lng" : -51.1659286 }, "html_instructions" : "Na rotatória, pegue a \u003cb\u003e2ª\u003c/b\u003e saída e mantenha-se na \u003cb\u003eAv. Farroupilha\u003c/b\u003e", "maneuver" : "roundabout-right", "polyline" : { "points" : "zhruDjkhwHACACACCAACCAACCAA?CAAAC?A?CAA?C?A?A@A?A@A?A@A?A@e@CqBM" }, "start_location" : { "lat" : -29.9177399, "lng" : -51.1661362 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0,3 km", "value" : 305 }, "duration" : { "text" : "2 minutos", "value" : 105 }, "end_location" : { "lat" : -29.9157738, "lng" : -51.16550429999999 }, "html_instructions" : "Vire à \u003cb\u003edireita\u003c/b\u003e\u003cdiv style=\"font-size:0.9em\"\u003eEstrada de uso restrito\u003c/div\u003e\u003cdiv style=\"font-size:0.9em\"\u003eO destino estará à direita\u003c/div\u003e", "maneuver" : "turn-right", "polyline" : { "points" : "dbruD`jhwHEOAI?KDEHAR@J@VB|@FNADCDIAKGEIAM@O@E?E?_@CiFQEA" }, "start_location" : { "lat" : -29.91666859999999, "lng" : -51.1659286 }, "travel_mode" : "DRIVING" } ], "traffic_speed_entry" : [], "via_waypoint" : [] } ], "overview_polyline" : { "points" : "zvquDnnmwHrPp@HiEL}DvA}DJYf@oA~Am@bEyA~@a@~By@z@SjBY|@O|HkAn@}SrCc@dBa@x@e@f@_@d@i@f@aAdA{DVgAHs@Bm@Cg@c@yCG_@CU@YAO_@eCOaBDiCWcBs@mBeAaB}A_CuBiDg@g@sDyBgAk@y@q@e@m@S]M_@{CsO{AiIKuAGsA@}BBq@Bg@@Eg@CkDMwAGuDOgCMQ?ACCGKKKEU?GBg@AqBMEOAUDEHA^BtAJTEDIAKQG]BuGUEA" }, "summary" : "Av. Inconfidência", "warnings" : [], "waypoint_order" : [] } ], "status" : "OK" }');

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
            'MarkerID-Fim-${widget.coordenadasFinais.latitude}-${widget.coordenadasFinais.longitude}'),
        position: google_maps.LatLng(
          widget.coordenadasFinais.latitude ?? finalLatLng.latitude,
          widget.coordenadasFinais.longitude ?? finalLatLng.longitude,
        ),
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
          google_maps.BitmapDescriptor.hueRed,
        ),
      ),
    );
    Set<google_maps.Marker> allMarkers =
        routeMarkers.union(_createCustomMarker());

    return Container(
      width: widget.width ?? 250.0,
      height: widget.height ?? 250.0,
      child: google_maps.GoogleMap(
        initialCameraPosition: google_maps.CameraPosition(
          target: google_maps.LatLng(
            widget.coordenadasIniciais?.latitude ?? inidtialLatLng.latitude,
            widget.coordenadasIniciais?.longitude ?? inidtialLatLng.longitude,
          ),
          zoom: 13,
        ),
        markers: allMarkers,
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
    );
  }
}

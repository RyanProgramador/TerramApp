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

class MapsRoutes2 extends StatefulWidget {
  const MapsRoutes2({
    Key? key,
    this.width,
    this.height,
    this.customIconUrl,
    required this.coordenadasIniciais,
    required this.coordenadasFinais,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? customIconUrl;
  final LatLng coordenadasIniciais;
  final LatLng coordenadasFinais;

  @override
  _MapsRoutes2State createState() => _MapsRoutes2State();
}

class _MapsRoutes2State extends State<MapsRoutes2> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//class _MapsRoutesState extends State<MapsRoutes2> {
//  late google_maps.GoogleMapController mapController;
//
//  Set<google_maps.Marker> routeMarkers = Set();
//
//  @override
//  Widget build(BuildContext context) {
//    var response = {
//      "geocoded_waypoints": [
//        {
//          "geocoder_status": "OK",
//          "place_id": "ChIJu9wU-LR6GZURAcM0yaNTDj8",
//          "types": ["street_address"]
//        },
//        {
//          "geocoder_status": "OK",
//          "place_id": "ChIJeZTsV1NlGZURarrY0uWwres",
//          "types": ["route"]
//        }
//      ],
//      "routes": [
//        {
//          "bounds": {
//            "northeast": {"lat": -29.9074096, "lng": -51.1846979},
//            "southwest": {"lat": -29.9152321, "lng": -51.1969954}
//          },
//          "copyrights": "Map data ©2023",
//          "legs": [
//            {
//              "distance": {"text": "2,0 km", "value": 1977},
//              "duration": {"text": "5 minutos", "value": 275},
//              "end_address":
//                  "R. Florianópolis - Centro, Canoas - RS, 92420-040, Brasil",
//              "end_location": {"lat": -29.9077946, "lng": -51.1846979},
//              "start_address":
//                  "R. Carlos Gomes, 286 - Harmonia, Canoas - RS, 92310-390, Brasil",
//              "start_location": {"lat": -29.9149287, "lng": -51.1969954},
//              "steps": [
//                {
//                  "distance": {"text": "0,5 km", "value": 456},
//                  "duration": {"text": "1 min", "value": 72},
//                  "end_location": {"lat": -29.9152321, "lng": -51.1922732},
//                  "html_instructions":
//                      "Siga na direção \u003cb\u003eleste\u003c/b\u003e na \u003cb\u003eR. Machado de Assis\u003c/b\u003e em direção à \u003cb\u003eR. Cel. Camisão\u003c/b\u003e",
//                  "polyline": {
//                    "points": "hwquDflnwHN}FBqADqA@w@Bm@BcADwABuADkAFkB"
//                  },
//                  "start_location": {"lat": -29.9149287, "lng": -51.1969954},
//                  "travel_mode": "DRIVING"
//                },
//                {
//                  "distance": {"text": "0,9 km", "value": 875},
//                  "duration": {"text": "2 minutos", "value": 117},
//                  "end_location": {"lat": -29.9074096, "lng": -51.1913808},
//                  "html_instructions":
//                      "Vire à \u003cb\u003eesquerda\u003c/b\u003e na \u003cb\u003eAv. José Maia Filho\u003c/b\u003e\u003cdiv style=\"font-size:0.9em\"\u003eVocê verá Mr. Magnus Barber Shop (à direita em 450 m)\u003c/div\u003e",
//                  "maneuver": "turn-left",
//                  "polyline": {
//                    "points":
//                        "dyquDtnmwHiAEkAEgACgACi@CuBK_DOiAEiAEgBKuAIgBKiHq@QCkAKq@CYCg@E"
//                  },
//                  "start_location": {"lat": -29.9152321, "lng": -51.1922732},
//                  "travel_mode": "DRIVING"
//                },
//                {
//                  "distance": {"text": "0,6 km", "value": 646},
//                  "duration": {"text": "1 min", "value": 86},
//                  "end_location": {"lat": -29.9077946, "lng": -51.1846979},
//                  "html_instructions":
//                      "Vire à \u003cb\u003edireita\u003c/b\u003e depois de Lavagem (à esquerda)",
//                  "maneuver": "turn-right",
//                  "polyline": {
//                    "points": "hhpuDbimwHTyJHqDJsDHwE@SFiC@o@DeBBw@?S"
//                  },
//                  "start_location": {"lat": -29.9074096, "lng": -51.1913808},
//                  "travel_mode": "DRIVING"
//                }
//              ],
//              "traffic_speed_entry": [],
//              "via_waypoint": []
//            }
//          ],
//          "overview_polyline": {
//            "points": "hwquDflnwHl@yVLwDuCKoHWiFUqDQ}DU{Hu@}BOaAIt@w\\T_K"
//          },
//          "summary": "Av. José Maia Filho e R. Florianópolis",
//          "warnings": [],
//          "waypoint_order": []
//        }
//      ],
//      "status": "OK"
//    };
//    List<dynamic> steps = (response['routes'] as List?)?[0]['legs']?[0]['steps']
//            as List<dynamic>? ??
//        [];
//
//    var finalLatLng = google_maps.LatLng(
//      (response['routes'] as List?)?[0]['legs']?[0]['end_location']?['lat']
//              as double? ??
//          0.0,
//      (response['routes'] as List?)?[0]['legs']?[0]['end_location']?['lng']
//              as double? ??
//          0.0,
//    );
//
//    Set<google_maps.Marker> routeMarkers = _createRouteFromSteps(steps);
//
//    // Adicione um marcador no final da rota usando as coordenadas finais
//    routeMarkers.add(
//      google_maps.Marker(
//        markerId: google_maps.MarkerId(
//            'MarkerID-Fim-${finalLatLng.latitude}-${finalLatLng.longitude}'),
//        position: google_maps.LatLng(
//          finalLatLng.latitude,
//          finalLatLng.longitude,
//        ),
//        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
//          google_maps.BitmapDescriptor.hueRed,
//        ),
//      ),
//    );
//
//    return Container(
//      width: widget.width ?? 400.0,
//      height: widget.height ?? 400.0,
//      child: google_maps.GoogleMap(
//        onMapCreated: (google_maps.GoogleMapController controller) {
//          mapController = controller;
//        },
//        initialCameraPosition: google_maps.CameraPosition(
//          target: google_maps.LatLng(
//            widget.coordenadasIniciais.latitude,
//            widget.coordenadasIniciais.longitude,
//          ),
//          zoom: 23,
//          tilt: 60, // Ajusta o ângulo de inclinação
//          bearing: 90, // Ajusta a direção do mapa (em graus)
//        ),
//        markers: routeMarkers,
//        polylines: {
//          google_maps.Polyline(
//            polylineId: google_maps.PolylineId("PolylineID"),
//            color: Colors.blue,
//            points: routeMarkers
//                .map((marker) => marker.position)
//                .toList(), // Utilizando as posições dos marcadores para criar a polilinha
//          )
//        },
//      ),
//    );
//  }
//
//  Set<google_maps.Marker> _createRouteFromSteps(List<dynamic> steps) {
//    List<google_maps.LatLng> routeCoordinates = [];
//
//    for (var step in steps) {
//      var startLocation = (step['start_location'] as Map<String, dynamic>);
//      var endLocation = (step['end_location'] as Map<String, dynamic>);
//
//      var startLatLng = google_maps.LatLng(
//        startLocation['lat'] as double,
//        startLocation['lng'] as double,
//      );
//      var endLatLng = google_maps.LatLng(
//        endLocation['lat'] as double,
//        endLocation['lng'] as double,
//      );
//
//      routeCoordinates.add(startLatLng);
//
//      // Adicione apenas as coordenadas intermediárias
//      if (routeCoordinates.length > 1) {
//        routeCoordinates.removeLast();
//      }
//
//      // Adicione marcadores para as localizações iniciais e finais de cada etapa
//      routeMarkers.add(
//        google_maps.Marker(
//          markerId: google_maps.MarkerId(
//              'MarkerID-Start-${startLatLng.latitude}-${startLatLng.longitude}'),
//          position: startLatLng,
//          visible: false,
//          icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
//            google_maps.BitmapDescriptor.hueGreen,
//          ),
//        ),
//      );
//      routeMarkers.add(
//        google_maps.Marker(
//          markerId: google_maps.MarkerId(
//              'MarkerID-End-${endLatLng.latitude}-${endLatLng.longitude}'),
//          position: endLatLng,
//          visible: false,
//          icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
//            google_maps.BitmapDescriptor.hueRed,
//          ),
//        ),
//      );
//    }
//
//    return routeMarkers;
//  }
//}
//
//class ActualPosition extends StatefulWidget {
//  const ActualPosition({
//    Key? key,
//    this.width,
//    this.height,
//    this.customIconUrl,
//  }) : super(key: key);
//
//  final double? width;
//  final double? height;
//  final String? customIconUrl;
//
//  @override
//  _ActualPositionState createState() => _ActualPositionState();
//}
//
//class _ActualPositionState extends State<ActualPosition> {
//  late google_maps.GoogleMapController mapController;
//  LocationData? currentLocation;
//  Uint8List? customIconBytes;
//
//  @override
//  void initState() {
//    super.initState();
//    _getUserLocation();
//    _loadCustomIcon();
//  }
//
//  Future<void> _getUserLocation() async {
//    var location = Location();
//    try {
//      var userLocation = await location.getLocation();
//      if (mounted) {
//        setState(() {
//          currentLocation = userLocation;
//        });
//      }
//    } catch (e) {
//      print("Error getting user location: $e");
//    }
//  }
//
//  Future<void> _loadCustomIcon() async {
//    if (widget.customIconUrl != null && widget.customIconUrl!.isNotEmpty) {
//      try {
//        final response = await http.get(Uri.parse(widget.customIconUrl!));
//        if (response.statusCode == 200) {
//          setState(() {
//            customIconBytes = response.bodyBytes;
//          });
//        }
//      } catch (e) {
//        print("Error loading custom icon: $e");
//      }
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return SizedBox(
//      width: widget.width,
//      height: widget.height,
//      child: google_maps.GoogleMap(
//        onMapCreated: (google_maps.GoogleMapController controller) {
//          mapController = controller;
//        },
//        initialCameraPosition: google_maps.CameraPosition(
//          target: google_maps.LatLng(
//            currentLocation?.latitude ?? 0.0,
//            currentLocation?.longitude ?? 0.0,
//          ),
//          zoom: 15.0,
//        ),
//        markers: {
//          google_maps.Marker(
//            markerId: google_maps.MarkerId('user_location'),
//            position: google_maps.LatLng(
//              currentLocation?.latitude ?? 0.0,
//              currentLocation?.longitude ?? 0.0,
//            ),
//            icon: customIconBytes != null
//                ? google_maps.BitmapDescriptor.fromBytes(customIconBytes!)
//                : google_maps.BitmapDescriptor.defaultMarkerWithHue(
//                    google_maps.BitmapDescriptor.hueBlue,
//                  ),
//          ),
//        },
//      ),
//    );
//  }
//}

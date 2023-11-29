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

class ActualPosition extends StatefulWidget {
  const ActualPosition({
    Key? key,
    this.width,
    this.height,
    this.customIconUrl,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? customIconUrl;

  @override
  _ActualPositionState createState() => _ActualPositionState();
}

class _ActualPositionState extends State<ActualPosition> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//import 'dart:typed_data';
//import 'package:location/location.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
//import 'package:http/http.dart' as http;
//
//class ActualPosition extends StatefulWidget {
//  const ActualPosition({
//    Key? key,
//    this.width,
//    this.height,
//    this.customIconUrl, // Nova propriedade para a URL do ícone personalizado
//  }) : super(key: key);
//
//  final double? width;
//  final double? height;
//  final String? customIconUrl; // URL do ícone personalizado
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
//        markers: Set<google_maps.Marker>.of(
//          <google_maps.Marker>[
//            google_maps.Marker(
//              markerId: google_maps.MarkerId('user_location'),
//              position: google_maps.LatLng(
//                currentLocation?.latitude ?? 0.0,
//                currentLocation?.longitude ?? 0.0,
//              ),
//              icon: customIconBytes != null
//                  ? google_maps.BitmapDescriptor.fromBytes(customIconBytes!)
//                  : google_maps.BitmapDescriptor.defaultMarkerWithHue(
//                      google_maps.BitmapDescriptor.hueBlue,
//                    ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}

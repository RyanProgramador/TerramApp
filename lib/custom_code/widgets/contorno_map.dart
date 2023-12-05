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

// Import necessary packages and libraries
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;

class ContornoMap extends StatefulWidget {
  const ContornoMap({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _ContornoMapState createState() => _ContornoMapState();
}

class _ContornoMapState extends State<ContornoMap> {
  Position? position;
  google_maps.GoogleMapController? _googleMapController;

  void _onMapCreated(google_maps.GoogleMapController controller) {
    _googleMapController = controller;
  }

  void _getCurrentLocation() async {
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 0,
      ),
    ).listen((Position newLoc) {
      if (_googleMapController != null) {
        _googleMapController!.animateCamera(
          google_maps.CameraUpdate.newCameraPosition(
            google_maps.CameraPosition(
              target: google_maps.LatLng(
                newLoc.latitude,
                newLoc.longitude,
              ),
              zoom: 19,
            ),
          ),
        );
      }

      setState(() {
        position = newLoc;
      });
    });
  }

  void _onMapTap(google_maps.LatLng tappedPoint) {
    // Handle the tapped point as needed
    print("Tapped Point: $tappedPoint");
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 400.0,
      height: widget.height ?? 400.0,
      child: google_maps.GoogleMap(
        initialCameraPosition: google_maps.CameraPosition(
          target: google_maps.LatLng(
            position?.latitude ?? 0.0,
            position?.longitude ?? 0.0,
          ),
          zoom: 19,
        ),
        onMapCreated: _onMapCreated,
        onTap: _onMapTap,
        markers: position != null
            ? {
                google_maps.Marker(
                  markerId: google_maps.MarkerId('UserMarkerID'),
                  position: google_maps.LatLng(
                    position!.latitude,
                    position!.longitude,
                  ),
                  icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
                    google_maps.BitmapDescriptor.hueBlue,
                  ),
                ),
              }
            : {},
      ),
    );
  }
}

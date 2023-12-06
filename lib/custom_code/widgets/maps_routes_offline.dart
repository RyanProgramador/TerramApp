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

class MapsRoutesOffline extends StatefulWidget {
  const MapsRoutesOffline({
    Key? key,
    this.width,
    this.height,
    this.coordenadasIniciais,
    this.coordenadasFinais,
  }) : super(key: key);

  final double? width;
  final double? height;
  final LatLng? coordenadasIniciais;
  final LatLng? coordenadasFinais;

  @override
  _MapsRoutesOfflineState createState() => _MapsRoutesOfflineState();
}

class _MapsRoutesOfflineState extends State<MapsRoutesOffline> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

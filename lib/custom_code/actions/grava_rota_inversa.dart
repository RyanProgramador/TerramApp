// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future gravaRotaInversa(
  String? idDoServico,
  String? retornoStringRotaInvertida,
) async {
  Map<String, dynamic> rota = {
    "osserv_id": idDoServico,
    "rota_inversa": retornoStringRotaInvertida,
  };
  if (rota != null && rota.isNotEmpty) {
    FFAppState().rotainversa.add(rota);
  }
}

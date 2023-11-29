// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:geolocator/geolocator.dart' as geo;

Future<bool> checkGps() async {
  bool serviceEnabled;

  // Verifica se o serviço de localização está habilitado
  serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // O usuário não habilitou o serviço de localização, você pode tratar isso conforme necessário
    print('Serviço de localização desabilitado pelo usuário.');
    return false;
  }

  // Se chegou aqui, o GPS está ligado
  return true;
}

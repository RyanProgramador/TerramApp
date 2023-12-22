// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:background_location/background_location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

Future<void> mainAction2(
    String? servicoId,
    String? tecnicoId,
    String? entradaOuSaida,
    bool? pausado,
    String? osdesId,
    int? tempoEmSegundosDeAtualizacao) async {
  // Solicita permissões necessárias
  await requestPermissions();

  // Inicializa o serviço de localização em segundo plano
  BackgroundLocation.setAndroidNotification(
    title: "Localização em segundo plano ativada",
    message: "Rastreando sua localização",
    icon: "@mipmap/ic_launcher",
  );
  BackgroundLocation.startLocationService();

  // Loop de rastreamento
  BackgroundLocation.getLocationUpdates((location) {
    if (!pausado!) {
      DateTime now = DateTime.now();
      Map<String, dynamic> locationData = {
        'latitude': location.latitude,
        'longitude': location.longitude,
        'timestamp': now.toIso8601String(),
        // Outros dados relevantes...
      };

      // Lógica para tratar a localização recebida
      handleLocationUpdate(locationData, osdesId);
    }
  });

  // Configura um timer para atualizar a localização em intervalos regulares
  Timer.periodic(Duration(seconds: tempoEmSegundosDeAtualizacao ?? 10),
      (Timer t) {
    BackgroundLocation.getCurrentLocation().then((location) {
      if (!pausado!) {
        Map<String, dynamic> locationData = {
          'latitude': location.latitude,
          'longitude': location.longitude,
          'timestamp': DateTime.now().toIso8601String(),
          // Outros dados relevantes...
        };

        // Lógica para tratar a localização recebida
        handleLocationUpdate(locationData, osdesId);
      }
    });
  });
}

// Função para solicitar as permissões necessárias
Future<void> requestPermissions() async {
  await Permission.locationAlways.request();
}

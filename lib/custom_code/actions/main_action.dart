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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

Future mainAction(
  String? servicoId,
  String? tecnicoId,
  String? entradaOuSaida,
  bool? pausado,
  String? osdesId,
) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Configuração inicial do plugin de notificações
  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await BackgroundLocation.setAndroidNotification(
    title: 'Terram - by Conceitto',
    message: 'Sua localização está sendo compartilhada conosco',
    icon: '@mipmap/ic_launcher',
  );

  await BackgroundLocation.startLocationService(distanceFilter: 2);

  Timer? timer;

  // Função para atualizar a notificação com o tempo restante
  void updateNotificationWithTimer(int timeRemaining) {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'my_foreground',
      'Background Location',
      playSound: false,
      enableVibration: false,
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
      0,
      'Localização sendo capturada',
      'Sinta-se livre para abrir outros aplicativos sem fechar a sessão da Terram',
      platformChannelSpecifics,
    );
  }

  Future<void> captureLocation(bool? pausado) async {
    // Reinicie o timer a cada 5 segundos
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      if (!pausado!) {
        // Correção: Adicione o ponto de exclamação para indicar que _pausado não pode ser nulo
        updateNotificationWithTimer(5);

        BackgroundLocation.getLocationUpdates((location) async {
          final latitude = location.latitude.toString();
          final longitude = location.longitude.toString();

          // Create a Map to represent the data
          Map<String, dynamic> data = {
            "osdes_id": 0,
            "osdes_id_oserv": servicoId,
            "osdes_id_tec": tecnicoId,
            "osdes_ponto_informacao": entradaOuSaida,
            "osdes_latitude": "$latitude",
            "osdes_longitude": "$longitude",
            "osdes_dthr_cad": "",
            "osdes_usu_cad": null,
            "osdes_dthr_alt": null,
            "osdes_usu_alt": null,
            "osdes_tide_id": 1,
          };

          Map<String, dynamic> data2 = {
            "osdes_id": osdesId,
            "osdes_latitude": "$latitude",
            "osdes_longitude": "$longitude",
          };

          // Add the Map to the list
          if (data != null && data.isNotEmpty) {
            // Correção: Adicione a verificação de que o mapa não está vazio
            //FFAppState().trOsDeslocamentos.add(data);
            //FFAppState().trOsDeslocamentoLatLng.add(data2);
            FFAppState().trDeslocamentoGeo.add(data2);
            FFAppState().trDeslocGeo2.add(data2);
          }
        });
      }
    });
  }

  // Inicie a captura de localização
  await captureLocation(pausado);
}

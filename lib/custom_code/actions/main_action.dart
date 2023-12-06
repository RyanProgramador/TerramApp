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

Future mainAction(String? servicoId, String? tecnicoId, String? entradaOuSaida,
    bool? pausado, String? osdesId, int? tempoEmSegundosDeAtualizacao) async {
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

  await BackgroundLocation.startLocationService(distanceFilter: 0);

  // Guarda o timestamp inicial
  final DateTime initialTimestamp = DateTime.now();
  // Calcula o timestamp que indica 8 segundos após o início
  final DateTime eightSecondsLaterTimestamp = initialTimestamp
      .add(Duration(seconds: tempoEmSegundosDeAtualizacao ?? 4));

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
    if (!pausado!) {
      updateNotificationWithTimer((tempoEmSegundosDeAtualizacao ?? 4));

      DateTime? previousTimestamp;
      String? previousLocationLat;

      BackgroundLocation.getLocationUpdates((location) async {
        final latitude = location.latitude.toString();
        final longitude = location.longitude.toString();

        DateTime currentTimestamp = getCurrentTimestamp;

        if (previousLocationLat != latitude) {
          if (previousTimestamp == null ||
              currentTimestamp.difference(previousTimestamp!).inSeconds >=
                  (tempoEmSegundosDeAtualizacao ?? 4)) {
            Map<String, dynamic> data2 = {
              "osdes_id": osdesId,
              "des_latitude": "$latitude",
              "des_longitude": "$longitude",
            };

            if (data2 != null && data2.isNotEmpty) {
              FFAppState().trDeslocGeo2.add(data2);
            }

            previousTimestamp = currentTimestamp;
            previousLocationLat =
                latitude; // Atualize a variável para evitar duplicatas
          }
        }
      });
    }
  }

  await captureLocation(pausado);
}

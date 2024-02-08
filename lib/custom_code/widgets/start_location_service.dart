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

import 'package:background_location/background_location.dart';

class StartLocationService extends StatefulWidget {
  const StartLocationService({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _StartLocationServiceState createState() => _StartLocationServiceState();
}

class _StartLocationServiceState extends State<StartLocationService> {
  void startLocationService() {
    BackgroundLocation.startLocationService(distanceFilter: 20);
    BackgroundLocation.getLocationUpdates((location) {
      print('Latitude: ${location.latitude}');
      print('Longitude: ${location.longitude}');
      // Aqui você pode adicionar a lógica para salvar as coordenadas ou o que precisar fazer com a localização
    });
  }

  void stopLocationService() {
    BackgroundLocation.stopLocationService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App rodando em segundo plano'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                startLocationService();
              },
              child: Text('Iniciar Serviço de Localização'),
            ),
            ElevatedButton(
              onPressed: () {
                stopLocationService();
              },
              child: Text('Parar Serviço de Localização'),
            ),
          ],
        ),
      ),
    );
  }
}

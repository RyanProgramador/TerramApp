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

@override
Widget build(BuildContext context) {
  return WillPopScope(
    onWillPop: () async {
      final shouldPop = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Tem certeza?'),
          content: Text('Você quer sair desta tela?'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(false), // Não permite sair da tela
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(true), // Permite sair da tela
              child: Text('Sim'),
            ),
          ],
        ),
      );

      return shouldPop ??
          false; // Retorna true se o usuário escolheu 'Sim', caso contrário, false
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text("Tela com WillPopScope"),
      ),
      // O restante da estrutura da sua tela aqui
    ),
  );
}

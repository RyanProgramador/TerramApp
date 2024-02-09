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

class Voltar extends StatefulWidget {
  const Voltar({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<Voltar> createState() => _VoltarState();
}

class _VoltarState extends State<Voltar> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Substitua 'blankRedirecona' pelo nome da rota para a qual você deseja navegar.
        Navigator.of(context).pushReplacementNamed('blankRedirecona');
        // Retorna false porque você está manipulando a navegação manualmente.
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tela com WillPopScope"),
        ),
        // O restante da estrutura da sua tela aqui.
        body: Center(
          child: Text('Conteúdo da Tela Voltar'),
        ),
      ),
    );
  }
}

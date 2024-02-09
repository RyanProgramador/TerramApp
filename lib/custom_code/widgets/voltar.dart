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
  const Voltar({Key? key, this.width, this.height}) : super(key: key);
  final double? width;
  final double? height;
  @override
  _VoltarState createState() => _VoltarState();
}

class _VoltarState extends State<Voltar> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Redireciona diretamente sem mostrar um AlertDialog.
        context.pushNamed(
          'blankRedirecona',
          extra: <String, dynamic>{
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: const Duration(milliseconds: 0),
            ),
          },
        );
        // Retorna false para indicar que a ação de voltar foi manipulada manualmente.
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tela com WillPopScope"),
        ),
        // O restante da estrutura da sua tela aqui.
        body: Center(
          child: Text('Conteúdo da Tela Voltar'),
        ),
      ),
    );
  }
}

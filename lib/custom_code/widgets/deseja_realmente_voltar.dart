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

class DesejaRealmenteVoltar extends StatefulWidget {
  const DesejaRealmenteVoltar({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<DesejaRealmenteVoltar> createState() => _DesejaRealmenteVoltarState();
}

class _DesejaRealmenteVoltarState extends State<DesejaRealmenteVoltar> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Você quer sair do serviço e voltar à tela inicial?'),
            content: Text(''),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pop(false), // Não permite sair da tela
                child: Text('Não'),
              ),
              TextButton(
                onPressed: () {
                  // Permite sair da tela e redireciona
                  //Navigator.of(context).pop(true); // Primeiro, fecha o diálogo
                  // Substitua 'blankRedirecona' pelo nome da rota para a qual você deseja navegar
                  context.goNamed(
                    'blankRedirecona',
                    extra: <String, dynamic>{
                      kTransitionInfoKey: TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 0),
                      ),
                    },
                  );
                },
                child: const Text('Sim'),
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
}

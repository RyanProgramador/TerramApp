import '/components/iniciar_deslocamento_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'iniciar_deslocamento_tela_widget.dart'
    show IniciarDeslocamentoTelaWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IniciarDeslocamentoTelaModel
    extends FlutterFlowModel<IniciarDeslocamentoTelaWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for IniciarDeslocamento component.
  late IniciarDeslocamentoModel iniciarDeslocamentoModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    iniciarDeslocamentoModel =
        createModel(context, () => IniciarDeslocamentoModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    iniciarDeslocamentoModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

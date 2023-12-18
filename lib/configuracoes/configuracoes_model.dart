import '/backend/api_requests/api_calls.dart';
import '/components/carregando_os_widget.dart';
import '/components/conexao_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'configuracoes_widget.dart' show ConfiguracoesWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ConfiguracoesModel extends FlutterFlowModel<ConfiguracoesWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (TrSincronizaCelularComBD)] action in materialList_Item_2 widget.
  ApiCallResponse? apiResultxxd;
  // Stores action output result for [Backend Call - API (trSincronizaTalhaoContorno)] action in materialList_Item_2 widget.
  ApiCallResponse? trSincTalhao;
  // State field(s) for Switch widget.
  bool? switchValue;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

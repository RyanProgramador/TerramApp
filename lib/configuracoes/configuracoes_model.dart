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
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ConfiguracoesModel extends FlutterFlowModel<ConfiguracoesWidget> {
  ///  Local state fields for this page.

  bool estaCarregando = false;

  double? porcentagemDeCarregamento = 0.0;

  String porcentagemString = '0%';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (trSincronizaPontosMedicao)] action in materialList_Item_2 widget.
  ApiCallResponse? sincPontosMedicaoEPerfilEProfundidaAPI;
  // Stores action output result for [Backend Call - API (TrSincronizaCelularComBD)] action in materialList_Item_2 widget.
  ApiCallResponse? sincCelComBD;
  // Stores action output result for [Backend Call - API (trSincronizaTalhaoContorno)] action in materialList_Item_2 widget.
  ApiCallResponse? trSincTalhao;
  // State field(s) for Switch widget.
  bool? switchValue;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

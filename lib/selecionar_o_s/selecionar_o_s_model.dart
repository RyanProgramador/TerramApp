import '/backend/api_requests/api_calls.dart';
import '/components/carregando_os_widget.dart';
import '/components/loading_comp_widget.dart';
import '/components/pesquisa_avanadabtn_widget.dart';
import '/components/vazio_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import 'selecionar_o_s_widget.dart' show SelecionarOSWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelecionarOSModel extends FlutterFlowModel<SelecionarOSWidget> {
  ///  Local state fields for this page.

  bool foiAtualizado = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - checkGps] action in SelecionarOS widget.
  bool? checkgps;
  // Stores action output result for [Custom Action - temInternet] action in SelecionarOS widget.
  bool? temInternetOsLoad;
  // Stores action output result for [Backend Call - API (TrSincronizaCelularComBD)] action in SelecionarOS widget.
  ApiCallResponse? apiResultxxdOnLoadPage;
  // Stores action output result for [Backend Call - API (trSincronizaTalhaoContorno)] action in SelecionarOS widget.
  ApiCallResponse? trSincTalhao;
  // Stores action output result for [Backend Call - API (trSincronizaPontosMedicao)] action in SelecionarOS widget.
  ApiCallResponse? sincPontosMedicaoEPerfilEProfundidaAPI;
  // Stores action output result for [Backend Call - API (trSincronizaPontosMedicao)] action in SelecionarOS widget.
  ApiCallResponse? sincPontosMedicaoPontosAPI;
  // Stores action output result for [Backend Call - API (trOsTecnico)] action in SelecionarOS widget.
  ApiCallResponse? trOsTecnicosSincroniza;
  // Stores action output result for [Backend Call - API (ordemDeServico)] action in SelecionarOS widget.
  ApiCallResponse? sincOsRet;
  // Stores action output result for [Backend Call - API (trFazendas)] action in SelecionarOS widget.
  ApiCallResponse? trFazendasSinc;
  // Stores action output result for [Backend Call - API (trSincronizaPontosMedicao)] action in SelecionarOS widget.
  ApiCallResponse? sincPontosMedicaoEPerfilEProfundida2;
  // Stores action output result for [Backend Call - API (trServicos)] action in SelecionarOS widget.
  ApiCallResponse? trServicosSinc;
  // Stores action output result for [Backend Call - API (trOsServicos)] action in SelecionarOS widget.
  ApiCallResponse? trOsServicosSinc;
  // Stores action output result for [Backend Call - API (trTecnicos)] action in SelecionarOS widget.
  ApiCallResponse? trTecnicosSinc;
  // Stores action output result for [Backend Call - API (trEmpresas)] action in SelecionarOS widget.
  ApiCallResponse? trEmpresas;
  // Stores action output result for [Backend Call - API (trCFG)] action in SelecionarOS widget.
  ApiCallResponse? trCFG;
  // Stores action output result for [Custom Action - temInternet] action in SelecionarOS widget.
  bool? temInternetOsLoad01;
  // Stores action output result for [Backend Call - API (trOsTecnico)] action in SelecionarOS widget.
  ApiCallResponse? trOsTecnicosSincroniza2;
  // Stores action output result for [Backend Call - API (ordemDeServico)] action in SelecionarOS widget.
  ApiCallResponse? sincOsRet2;
  // Stores action output result for [Backend Call - API (trFazendas)] action in SelecionarOS widget.
  ApiCallResponse? trFazendasSinc2;
  // Stores action output result for [Backend Call - API (trServicos)] action in SelecionarOS widget.
  ApiCallResponse? trServicosSinc2;
  // Stores action output result for [Backend Call - API (trOsServicos)] action in SelecionarOS widget.
  ApiCallResponse? trOsServicosSinc2;
  // Stores action output result for [Backend Call - API (trTecnicos)] action in SelecionarOS widget.
  ApiCallResponse? trTecnicosSinc2;
  // Stores action output result for [Backend Call - API (trEmpresas)] action in SelecionarOS widget.
  ApiCallResponse? trEmpresas2;
  // Stores action output result for [Backend Call - API (trCFG)] action in SelecionarOS widget.
  ApiCallResponse? trCFG2;
  // Stores action output result for [Backend Call - API (trSincronizaPontosMedicao)] action in SelecionarOS widget.
  ApiCallResponse? sincPontosMedicaoEPerfilEProfundida;
  // State field(s) for searchBar widget.
  FocusNode? searchBarFocusNode;
  TextEditingController? searchBarController;
  String? Function(BuildContext, String?)? searchBarControllerValidator;
  // Stores action output result for [Custom Action - calendarRangerAction] action in Container widget.
  List<DateTime>? calendarRange;
  // Stores action output result for [Custom Action - temInternet] action in Row widget.
  bool? temNetNoServico;
  // Stores action output result for [Backend Call - API (apiRotasPolylines)] action in Row widget.
  ApiCallResponse? polyline1;
  // Stores action output result for [Custom Action - temInternet] action in Row widget.
  bool? temInternetOsInicia;
  // Stores action output result for [Backend Call - API (apiRotasPolylines)] action in Row widget.
  ApiCallResponse? polyline2;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    searchBarFocusNode?.dispose();
    searchBarController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

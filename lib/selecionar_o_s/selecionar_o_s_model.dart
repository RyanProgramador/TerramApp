import '/backend/api_requests/api_calls.dart';
import '/components/iniciar_deslocamento_widget.dart';
import '/components/loading_comp_widget.dart';
import '/components/pesquisa_avanada_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import 'selecionar_o_s_widget.dart' show SelecionarOSWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelecionarOSModel extends FlutterFlowModel<SelecionarOSWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - checkGps] action in SelecionarOS widget.
  bool? checkgps;
  // Stores action output result for [Custom Action - temInternet] action in SelecionarOS widget.
  bool? temInternetOsLoad;
  // Stores action output result for [Backend Call - API (trOsTecnico)] action in SelecionarOS widget.
  ApiCallResponse? trOsTecnicosSincroniza;
  // Stores action output result for [Backend Call - API (ordemDeServico)] action in SelecionarOS widget.
  ApiCallResponse? sincOsRet;
  // Stores action output result for [Backend Call - API (trFazendas)] action in SelecionarOS widget.
  ApiCallResponse? trFazendasSinc;
  // Stores action output result for [Backend Call - API (trServicos)] action in SelecionarOS widget.
  ApiCallResponse? trServicosSinc;
  // Stores action output result for [Backend Call - API (trOsServicos)] action in SelecionarOS widget.
  ApiCallResponse? trOsServicosSinc;
  // Stores action output result for [Backend Call - API (trTecnicos)] action in SelecionarOS widget.
  ApiCallResponse? trTecnicosSinc;
  // Stores action output result for [Backend Call - API (trEmpresas)] action in SelecionarOS widget.
  ApiCallResponse? trEmpresas;
  // State field(s) for searchBar widget.
  FocusNode? searchBarFocusNode;
  TextEditingController? searchBarController;
  String? Function(BuildContext, String?)? searchBarControllerValidator;
  // Stores action output result for [Backend Call - API (apiRotasPolylines)] action in Row widget.
  ApiCallResponse? polyline1;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    searchBarFocusNode?.dispose();
    searchBarController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

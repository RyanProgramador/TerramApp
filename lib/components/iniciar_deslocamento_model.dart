import '/backend/api_requests/api_calls.dart';
import '/components/motivo_pausa_widget.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'iniciar_deslocamento_widget.dart' show IniciarDeslocamentoWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

class IniciarDeslocamentoModel
    extends FlutterFlowModel<IniciarDeslocamentoWidget> {
  ///  Local state fields for this component.

  bool? temNet = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - temInternet] action in IniciarDeslocamento widget.
  bool? temInternetOnLoadInicioOs;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // Stores action output result for [Custom Action - temInternet] action in Button widget.
  bool? temNetRefrash;
  // Stores action output result for [Custom Action - temInternet] action in Button widget.
  bool? temInternetAntesDoDeslocamento;
  // Stores action output result for [Backend Call - API (apiRotasPolylines)] action in Button widget.
  ApiCallResponse? porfavorFuncioneComRotaInvertida;
  // Stores action output result for [Backend Call - API (apiRotasPolylines)] action in Button widget.
  ApiCallResponse? porfavorFuncioneSemRota;
  // Stores action output result for [Backend Call - API (apiRotasPolylines)] action in Button widget.
  ApiCallResponse? rotaInvertida;
  // Stores action output result for [Backend Call - API (apiRotasPolylines)] action in Button widget.
  ApiCallResponse? porfavorFuncioneTecAteFaz;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

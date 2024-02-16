import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'multiple_places_picker_copy_widget.dart'
    show MultiplePlacesPickerCopyWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MultiplePlacesPickerCopyModel
    extends FlutterFlowModel<MultiplePlacesPickerCopyWidget> {
  ///  Local state fields for this page.

  int? iniciado = 0;

  int? index = 0;

  int? vez = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (trOsTecnico)] action in FloatingActionButton widget.
  ApiCallResponse? trOsTecnicosSincroniza;
  // Stores action output result for [Backend Call - API (ordemDeServico)] action in FloatingActionButton widget.
  ApiCallResponse? sincOsRet;
  // Stores action output result for [Backend Call - API (trFazendas)] action in FloatingActionButton widget.
  ApiCallResponse? trFazendasSinc;
  // State field(s) for Timer1 widget.
  int timer1Milliseconds = 4000;
  String timer1Value = StopWatchTimer.getDisplayTime(
    4000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timer1Controller =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // Stores action output result for [Custom Action - calendarRangerAction] action in Row widget.
  List<DateTime>? retornoCalendar;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (trSincronizaTalhaoContorno)] action in Text widget.
  ApiCallResponse? recortes;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    timer1Controller.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

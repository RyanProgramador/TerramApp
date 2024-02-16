import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'multiple_places_picker_widget.dart' show MultiplePlacesPickerWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MultiplePlacesPickerModel
    extends FlutterFlowModel<MultiplePlacesPickerWidget> {
  ///  Local state fields for this page.

  int? iniciado = 0;

  int? index = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Timer1 widget.
  int timer1Milliseconds = 4000;
  String timer1Value = StopWatchTimer.getDisplayTime(
    4000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timer1Controller =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // State field(s) for Timer widget.
  int timerMilliseconds = 60000;
  String timerValue = StopWatchTimer.getDisplayTime(
    60000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    timer1Controller.dispose();
    timerController.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

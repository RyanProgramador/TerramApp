import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'loading_comp_copy_widget.dart' show LoadingCompCopyWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoadingCompCopyModel extends FlutterFlowModel<LoadingCompCopyWidget> {
  ///  Local state fields for this component.

  bool mostraNaTela = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Timer widget.
  int timerMilliseconds = 100000;
  String timerValue = StopWatchTimer.getDisplayTime(
    100000,
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
    timerController.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

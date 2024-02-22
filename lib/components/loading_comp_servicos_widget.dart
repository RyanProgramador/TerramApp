import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'loading_comp_servicos_model.dart';
export 'loading_comp_servicos_model.dart';

class LoadingCompServicosWidget extends StatefulWidget {
  const LoadingCompServicosWidget({super.key});

  @override
  State<LoadingCompServicosWidget> createState() =>
      _LoadingCompServicosWidgetState();
}

class _LoadingCompServicosWidgetState extends State<LoadingCompServicosWidget> {
  late LoadingCompServicosModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingCompServicosModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      unawaited(
        () async {}(),
      );
      _model.timerController.onStartTimer();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color(0x00F1F4F8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Opacity(
            opacity: 0.9,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.0,
                    child: FlutterFlowTimer(
                      initialTime: _model.timerMilliseconds,
                      getDisplayTime: (value) => StopWatchTimer.getDisplayTime(
                        value,
                        hours: false,
                        milliSecond: false,
                      ),
                      controller: _model.timerController,
                      updateStateInterval: Duration(milliseconds: 1000),
                      onChanged: (value, displayTime, shouldUpdate) {
                        _model.timerMilliseconds = value;
                        _model.timerValue = displayTime;
                        if (shouldUpdate) setState(() {});
                      },
                      onEnded: () async {
                        setState(() {
                          _model.mostraNaTela = true;
                        });
                      },
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).headlineSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

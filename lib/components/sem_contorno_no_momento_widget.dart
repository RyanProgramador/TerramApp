import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sem_contorno_no_momento_model.dart';
export 'sem_contorno_no_momento_model.dart';

class SemContornoNoMomentoWidget extends StatefulWidget {
  const SemContornoNoMomentoWidget({super.key});

  @override
  State<SemContornoNoMomentoWidget> createState() =>
      _SemContornoNoMomentoWidgetState();
}

class _SemContornoNoMomentoWidgetState
    extends State<SemContornoNoMomentoWidget> {
  late SemContornoNoMomentoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SemContornoNoMomentoModel());
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
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                    child: Text(
                      'Sem contornos novos para esta fazenda!',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style:
                          FlutterFlowTheme.of(context).headlineLarge.override(
                                fontFamily: 'Outfit',
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ),
                  Text(
                    'Por favor, Insira-os.',
                    style: FlutterFlowTheme.of(context).headlineLarge.override(
                          fontFamily: 'Readex Pro',
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

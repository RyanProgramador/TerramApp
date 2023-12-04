import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'vazio_model.dart';
export 'vazio_model.dart';

class VazioWidget extends StatefulWidget {
  const VazioWidget({Key? key}) : super(key: key);

  @override
  _VazioWidgetState createState() => _VazioWidgetState();
}

class _VazioWidgetState extends State<VazioWidget> {
  late VazioModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VazioModel());
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
                  Text(
                    'Ops! parece que não ha registros!',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).headlineLarge.override(
                          fontFamily: 'Outfit',
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    'Por favor, tente novamente.',
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

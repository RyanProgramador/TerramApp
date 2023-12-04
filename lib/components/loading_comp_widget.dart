import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'loading_comp_model.dart';
export 'loading_comp_model.dart';

class LoadingCompWidget extends StatefulWidget {
  const LoadingCompWidget({Key? key}) : super(key: key);

  @override
  _LoadingCompWidgetState createState() => _LoadingCompWidgetState();
}

class _LoadingCompWidgetState extends State<LoadingCompWidget> {
  late LoadingCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingCompModel());
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
                    'Carregando...',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).headlineLarge.override(
                          fontFamily: 'Outfit',
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    'Por favor, aguarde.',
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

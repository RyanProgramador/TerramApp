import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'carregando_os_model.dart';
export 'carregando_os_model.dart';

class CarregandoOsWidget extends StatefulWidget {
  const CarregandoOsWidget({Key? key}) : super(key: key);

  @override
  _CarregandoOsWidgetState createState() => _CarregandoOsWidgetState();
}

class _CarregandoOsWidgetState extends State<CarregandoOsWidget> {
  late CarregandoOsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarregandoOsModel());
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
        color: Color(0x20000000),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(),
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: 140.0,
              height: 140.0,
              child: custom_widgets.LoadingCircle(
                width: 140.0,
                height: 140.0,
                color: FlutterFlowTheme.of(context).primary,
                circleRadius: 30.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

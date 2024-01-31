import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'maps_revisao_todos_model.dart';
export 'maps_revisao_todos_model.dart';

class MapsRevisaoTodosWidget extends StatefulWidget {
  const MapsRevisaoTodosWidget({
    super.key,
    this.listagrupoTodos,
    this.listaContornoTodos,
    this.fazlatlng,
    required this.sincOuNovo,
  });

  final List<dynamic>? listagrupoTodos;
  final List<dynamic>? listaContornoTodos;
  final LatLng? fazlatlng;
  final String? sincOuNovo;

  @override
  State<MapsRevisaoTodosWidget> createState() => _MapsRevisaoTodosWidgetState();
}

class _MapsRevisaoTodosWidgetState extends State<MapsRevisaoTodosWidget> {
  late MapsRevisaoTodosModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MapsRevisaoTodosModel());
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
      height: 600.0,
      decoration: BoxDecoration(),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional(0.0, 0.0),
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: custom_widgets.ContornoMapRevisaoTodos(
                  width: double.infinity,
                  height: double.infinity,
                  listaDeGrupos: widget.listagrupoTodos,
                  listaDeContornos: widget.listaContornoTodos,
                  fazlatlng: widget.fazlatlng,
                  sincOuNovo: widget.sincOuNovo,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(1.0, -1.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Material(
                    color: Colors.transparent,
                    elevation: 2.0,
                    shape: const CircleBorder(),
                    child: ClipOval(
                      child: Container(
                        width: 38.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).lineColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 32.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

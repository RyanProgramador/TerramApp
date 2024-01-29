import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'maps_revisao_model.dart';
export 'maps_revisao_model.dart';

class MapsRevisaoWidget extends StatefulWidget {
  const MapsRevisaoWidget({
    super.key,
    required this.listaLatLngEmString,
    this.cor,
    required this.fazendaNome,
    required this.oservID,
    required this.idDoContorno,
    required this.fazid,
    required this.fazlatlng,
  });

  final List<String>? listaLatLngEmString;
  final String? cor;
  final String? fazendaNome;
  final String? oservID;
  final String? idDoContorno;
  final String? fazid;
  final LatLng? fazlatlng;

  @override
  State<MapsRevisaoWidget> createState() => _MapsRevisaoWidgetState();
}

class _MapsRevisaoWidgetState extends State<MapsRevisaoWidget> {
  late MapsRevisaoModel _model;

  LatLng? currentUserLocationValue;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MapsRevisaoModel());

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        ),
      );
    }

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
                child: custom_widgets.ContornoMapRevisao(
                  width: double.infinity,
                  height: double.infinity,
                  listaDeLatLng: widget.listaLatLngEmString,
                  cor: valueOrDefault<String>(
                    widget.cor,
                    '#ffffff',
                  ),
                  fazid: widget.fazid,
                  oservid: widget.oservID,
                  idContorno: widget.idDoContorno,
                  fazNome: widget.fazendaNome,
                  fazLatLng: widget.fazlatlng,
                  localAtual: currentUserLocationValue,
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

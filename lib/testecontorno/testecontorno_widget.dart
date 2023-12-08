import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'testecontorno_model.dart';
export 'testecontorno_model.dart';

class TestecontornoWidget extends StatefulWidget {
  const TestecontornoWidget({Key? key}) : super(key: key);

  @override
  _TestecontornoWidgetState createState() => _TestecontornoWidgetState();
}

class _TestecontornoWidgetState extends State<TestecontornoWidget> {
  late TestecontornoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TestecontornoModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      _model.polyline1 = await ApiRotasPolylinesCall.call(
        latitudeOrigem: functions.separadorLatDeLng(
            true, functions.latLngToStr(currentUserLocationValue)),
        longitudeOrigem: functions.separadorLatDeLng(
            false, functions.latLngToStr(currentUserLocationValue)),
        latitudeDestino: functions.separadorLatDeLng(
            true, functions.latLngToStr(FFAppState().excluirLocal)),
        longitudeDestonp: functions.separadorLatDeLng(
            false, functions.latLngToStr(FFAppState().excluirLocal)),
        key: 'AIzaSyDpk1wIZmA1OTS57D_cB13BD01zqrTiQNI',
      );
      setState(() {
        FFAppState().addToErro(currentUserLocationValue!);
      });
      await Future.delayed(const Duration(milliseconds: 1000));
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

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

    return FutureBuilder<ApiCallResponse>(
      future: ApiRotasDirectionsCall.call(
        origem: functions.latLngToStr(currentUserLocationValue),
        destino: functions.latLngToStr(FFAppState().excluirLocal),
        key: 'AIzaSyDpk1wIZmA1OTS57D_cB13BD01zqrTiQNI',
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
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
        final testecontornoApiRotasDirectionsResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.goNamed(
                              'MultiplePlacesPickerCopy',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType:
                                      PageTransitionType.topToBottom,
                                  duration: Duration(milliseconds: 600),
                                ),
                              },
                            );
                          },
                          child: FaIcon(
                            FontAwesomeIcons.redo,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      width: double.infinity,
                      height: 400.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: custom_widgets.RotaFinal(
                          width: double.infinity,
                          height: double.infinity,
                          stringDoRotas:
                              ApiRotasPolylinesCall.criptografadapolyline(
                            (_model.polyline1?.jsonBody ?? ''),
                          ).toString(),
                          coordenadasIniciais: currentUserLocationValue!,
                          coordenadasFinais: FFAppState().excluirLocal!,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      width: double.infinity,
                      height: 400.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: custom_widgets.RotaFinalOffline(
                          width: double.infinity,
                          height: double.infinity,
                          coordenadasIniciais: currentUserLocationValue!,
                          coordenadasFinais: FFAppState().excluirLocal!,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

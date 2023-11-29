import '/backend/api_requests/api_calls.dart';
import '/components/motivo_pausa_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'gps_tec_to_fazenda_model.dart';
export 'gps_tec_to_fazenda_model.dart';

class GpsTecToFazendaWidget extends StatefulWidget {
  const GpsTecToFazendaWidget({
    Key? key,
    required this.jsonServico,
    required this.tecnicoId,
    required this.servicoId,
    required this.fazNome,
    required this.latlngFaz,
    required this.retornoAPI,
    required this.retornopolylines,
  }) : super(key: key);

  final dynamic jsonServico;
  final String? tecnicoId;
  final String? servicoId;
  final String? fazNome;
  final LatLng? latlngFaz;
  final String? retornoAPI;
  final String? retornopolylines;

  @override
  _GpsTecToFazendaWidgetState createState() => _GpsTecToFazendaWidgetState();
}

class _GpsTecToFazendaWidgetState extends State<GpsTecToFazendaWidget> {
  late GpsTecToFazendaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GpsTecToFazendaModel());

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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primary,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    FutureBuilder<ApiCallResponse>(
                      future: ApiRotasDirectionsCall.call(
                        origem: functions.latLngToStr(currentUserLocationValue),
                        destino: functions.latLngToStr(widget.latlngFaz),
                        key: 'AIzaSyDpk1wIZmA1OTS57D_cB13BD01zqrTiQNI',
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        final containerApiRotasDirectionsResponse =
                            snapshot.data!;
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: custom_widgets.RotaFinal(
                              width: double.infinity,
                              height: double.infinity,
                              json2: functions
                                  .jsonToStr(ApiRotasDirectionsCall.tudo(
                                containerApiRotasDirectionsResponse.jsonBody,
                              ))!,
                              coordenadasIniciais: currentUserLocationValue!,
                              coordenadasFinais: widget.latlngFaz!,
                              stringDoRotas: widget.retornopolylines,
                            ),
                          ),
                        );
                      },
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60.0),
                        bottomRight: Radius.circular(60.0),
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 150.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF00736D),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(60.0),
                            bottomRight: Radius.circular(60.0),
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(0.0),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.00, 0.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.safePop();
                                  },
                                  child: Icon(
                                    Icons.keyboard_backspace_rounded,
                                    color: Colors.white,
                                    size: 50.0,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              widget.fazNome!,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFFF8F8F8),
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            if ((FFAppState().trDesloacamentoIniciado ==
                                    true) &&
                                (FFAppState().DeslocamentoPausado == true) &&
                                (FFAppState().trDeslocamentoFinalizado ==
                                    false))
                              Text(
                                'Deslocamento pausado',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFF8F8F8),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            if ((FFAppState().trDesloacamentoIniciado ==
                                    true) &&
                                (FFAppState().DeslocamentoPausado == false) &&
                                (FFAppState().trDeslocamentoFinalizado ==
                                    false))
                              Text(
                                'Deslocamento em andamento',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFF8F8F8),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            if ((FFAppState().trDesloacamentoIniciado ==
                                    false) &&
                                (FFAppState().DeslocamentoPausado == false) &&
                                (FFAppState().trDeslocamentoFinalizado == true))
                              Text(
                                'Inicie seu deslocamento',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFF8F8F8),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            if ((FFAppState().trDesloacamentoIniciado ==
                                    false) &&
                                (FFAppState().DeslocamentoPausado == false) &&
                                (FFAppState().trDeslocamentoFinalizado ==
                                    false))
                              Text(
                                'Aguardando início de deslocamento',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFF8F8F8),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1.00, 1.00),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                        child: Container(
                          width: 100.0,
                          height: 220.0,
                          decoration: BoxDecoration(
                            color: Color(0x00BC1818),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if ((getJsonField(
                                          widget.jsonServico,
                                          r'''$.oserv_id''',
                                        ) ==
                                        FFAppState().trOsServicoEmAndamento) &&
                                    (FFAppState().DeslocamentoPausado == false))
                                  Align(
                                    alignment: AlignmentDirectional(0.94, 0.58),
                                    child: ClipOval(
                                      child: Container(
                                        width: 88.0,
                                        height: 88.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          shape: BoxShape.circle,
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            currentUserLocationValue =
                                                await getCurrentUserLocation(
                                                    defaultLocation:
                                                        LatLng(0.0, 0.0));
                                            await actions.stopMainAction(
                                              widget.servicoId,
                                              widget.tecnicoId,
                                              '1',
                                            );
                                            FFAppState().update(() {
                                              FFAppState().DeslocamentoPausado =
                                                  false;
                                              FFAppState()
                                                      .trDesloacamentoIniciado =
                                                  false;
                                              FFAppState()
                                                      .trDeslocamentoFinalizado =
                                                  true;
                                              FFAppState()
                                                      .trOsServicoEmAndamento =
                                                  null;
                                              FFAppState()
                                                  .addToServicosFinalizadosComSucesso(
                                                      getJsonField(
                                                widget.jsonServico,
                                                r'''$.oserv_id''',
                                              ).toString());
                                              FFAppState().trOsDeslocamentoJsonAtual = functions
                                                  .editaJsonDeslocamento(
                                                      functions.separadorLatDeLng(
                                                          true,
                                                          functions.latLngToStr(
                                                              currentUserLocationValue)),
                                                      functions.separadorLatDeLng(
                                                          false,
                                                          functions.latLngToStr(
                                                              currentUserLocationValue)),
                                                      getCurrentTimestamp
                                                          .toString(),
                                                      FFAppState()
                                                          .trOsDeslocamentoJsonAtual,
                                                      getJsonField(
                                                        FFAppState()
                                                            .trOsDeslocamentoJsonAtual,
                                                        r'''$.osdes_id''',
                                                      ).toString())!;
                                            });
                                            FFAppState().update(() {
                                              FFAppState()
                                                  .addToTrOsDeslocamentosJsonFinalizados(
                                                      FFAppState()
                                                          .trOsDeslocamentoJsonAtual);
                                              FFAppState().trDeslocGeo2 =
                                                  FFAppState()
                                                      .trDeslocamentoGeo
                                                      .toList()
                                                      .cast<dynamic>();
                                            });
                                            await Future.delayed(const Duration(
                                                milliseconds: 1000));
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Finalizado com sucesso!'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.stop,
                                            color: Colors.white,
                                            size: 44.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if ((getJsonField(
                                          widget.jsonServico,
                                          r'''$.oserv_id''',
                                        ) ==
                                        FFAppState().trOsServicoEmAndamento) &&
                                    (FFAppState().DeslocamentoPausado == false))
                                  Align(
                                    alignment: AlignmentDirectional(0.94, 0.58),
                                    child: ClipOval(
                                      child: Container(
                                        width: 88.0,
                                        height: 88.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .customColor1,
                                          shape: BoxShape.circle,
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            setState(() {
                                              FFAppState().DeslocamentoPausado =
                                                  true;
                                              FFAppState()
                                                      .trDesloacamentoIniciado =
                                                  true;
                                            });
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              enableDrag: false,
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child: Container(
                                                      height: 370.0,
                                                      child:
                                                          MotivoPausaWidget(),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));

                                            await Future.delayed(const Duration(
                                                milliseconds: 1000));
                                            await actions.stopMainAction(
                                              widget.servicoId,
                                              widget.tecnicoId,
                                              '1',
                                            );
                                          },
                                          child: Icon(
                                            Icons.pause,
                                            color: Colors.white,
                                            size: 50.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if ((FFAppState().trDesloacamentoIniciado ==
                                        false) ||
                                    (FFAppState().DeslocamentoPausado == true))
                                  Align(
                                    alignment: AlignmentDirectional(0.91, 0.94),
                                    child: ClipOval(
                                      child: Container(
                                        width: 88.0,
                                        height: 88.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF00736D),
                                          shape: BoxShape.circle,
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            currentUserLocationValue =
                                                await getCurrentUserLocation(
                                                    defaultLocation:
                                                        LatLng(0.0, 0.0));
                                            setState(() {
                                              FFAppState().AtualLocalizcao =
                                                  currentUserLocationValue!
                                                      .toString();
                                              FFAppState()
                                                      .trDeslocamentoFinalizado =
                                                  false;
                                              FFAppState().trOsDeslocamentoJsonAtual = functions
                                                  .montaJsonDeslocamento(
                                                      getJsonField(
                                                        FFAppState()
                                                            .trOsDeslocamentoJsonAtual,
                                                        r'''$.osdes_id''',
                                                      ).toString(),
                                                      widget.servicoId,
                                                      widget.tecnicoId,
                                                      '0',
                                                      functions.separadorLatDeLng(
                                                          true,
                                                          functions.latLngToStr(
                                                              currentUserLocationValue)),
                                                      functions.separadorLatDeLng(
                                                          false,
                                                          functions.latLngToStr(
                                                              currentUserLocationValue)),
                                                      '1',
                                                      getCurrentTimestamp
                                                          .toString(),
                                                      '0',
                                                      '0')!;
                                            });
                                            if (FFAppState().AtualLocalizcao ==
                                                FFAppState().localizacaoZero) {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Ative sua localização!'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext),
                                                        child: Text('Ok'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              return;
                                            }
                                            setState(() {
                                              FFAppState()
                                                      .trOsServicoEmAndamento =
                                                  getJsonField(
                                                widget.jsonServico,
                                                r'''$.oserv_id''',
                                              );
                                              FFAppState().DeslocamentoPausado =
                                                  false;
                                              FFAppState()
                                                      .trDesloacamentoIniciado =
                                                  true;
                                            });
                                            await actions.mainAction(
                                              widget.servicoId,
                                              widget.tecnicoId,
                                              '1',
                                              false,
                                              functions.umMaisUm(getJsonField(
                                                FFAppState()
                                                    .trOsDeslocamentoJsonAtual,
                                                r'''$.osdes_id''',
                                              ).toString()),
                                            );
                                          },
                                          child: Icon(
                                            Icons.play_arrow_rounded,
                                            color: Colors.white,
                                            size: 60.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

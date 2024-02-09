import '/components/motivo_pausa_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'gps_tec_to_fazenda_model.dart';
export 'gps_tec_to_fazenda_model.dart';

class GpsTecToFazendaWidget extends StatefulWidget {
  const GpsTecToFazendaWidget({
    super.key,
    required this.jsonServico,
    required this.tecnicoId,
    required this.servicoId,
    required this.fazNome,
    required this.latlngFaz,
    required this.retornoAPI,
    required this.retornopolylines,
    bool? comRota,
    bool? rotaInversa,
    this.rotaInversaString,
    required this.cidadeFaz,
    required this.estadoFaz,
    required this.observacao,
    required this.data,
    required this.horar,
    required this.fazid,
    required this.autoAuditoria,
    required this.autoAuditoriaQuantidadePontos,
    required this.etapaDe,
  })  : this.comRota = comRota ?? false,
        this.rotaInversa = rotaInversa ?? false;

  final dynamic jsonServico;
  final String? tecnicoId;
  final String? servicoId;
  final String? fazNome;
  final LatLng? latlngFaz;
  final String? retornoAPI;
  final String? retornopolylines;
  final bool comRota;
  final bool rotaInversa;
  final String? rotaInversaString;
  final String? cidadeFaz;
  final String? estadoFaz;
  final String? observacao;
  final String? data;
  final String? horar;
  final String? fazid;
  final bool? autoAuditoria;
  final int? autoAuditoriaQuantidadePontos;
  final String? etapaDe;

  @override
  State<GpsTecToFazendaWidget> createState() => _GpsTecToFazendaWidgetState();
}

class _GpsTecToFazendaWidgetState extends State<GpsTecToFazendaWidget> {
  late GpsTecToFazendaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GpsTecToFazendaModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.temInternetOnLoadGPSOs = await actions.temInternet();
      if (_model.temInternetOnLoadGPSOs != true) {
        return;
      }
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
                    if (widget.comRota)
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: custom_widgets.RotaFinal(
                            width: double.infinity,
                            height: double.infinity,
                            coordenadasIniciais: currentUserLocationValue!,
                            coordenadasFinais: widget.latlngFaz!,
                            stringDoRotas: widget.rotaInversa
                                ? widget.rotaInversaString
                                : widget.retornopolylines,
                          ),
                        ),
                      ),
                    if (widget.comRota == false)
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: custom_widgets.RotaFinalOffline(
                            width: double.infinity,
                            height: double.infinity,
                            coordenadasIniciais: currentUserLocationValue!,
                            coordenadasFinais: widget.latlngFaz!,
                          ),
                        ),
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
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Você tem certeza que quer sair do deslocamento?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child: Text('Não'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              true),
                                                      child: Text('Sim'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ) ??
                                            false;
                                    if (!confirmDialogResponse) {
                                      return;
                                    }
                                    FFAppState().update(() {});
                                    context.safePop();
                                    FFAppState().update(() {});
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
                      alignment: AlignmentDirectional(1.0, 1.0),
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
                                            var confirmDialogResponse =
                                                await showDialog<bool>(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Deseja finalizar o deslocamento?'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      false),
                                                              child:
                                                                  Text('Não'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      true),
                                                              child:
                                                                  Text('Sim'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ) ??
                                                    false;
                                            if (!confirmDialogResponse) {
                                              return;
                                            }
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
                                                      .trDeslocGeo2
                                                      .toList()
                                                      .cast<dynamic>();
                                            });
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
                                            FFAppState().update(() {});

                                            context.goNamed(
                                              'IniciarDeslocamentoTela',
                                              queryParameters: {
                                                'etapade': serializeParam(
                                                  widget.etapaDe,
                                                  ParamType.String,
                                                ),
                                                'fazendaNome': serializeParam(
                                                  widget.fazNome,
                                                  ParamType.String,
                                                ),
                                                'latlngFaz': serializeParam(
                                                  widget.latlngFaz,
                                                  ParamType.LatLng,
                                                ),
                                                'cidadeFaz': serializeParam(
                                                  widget.cidadeFaz,
                                                  ParamType.String,
                                                ),
                                                'estadoFaz': serializeParam(
                                                  widget.estadoFaz,
                                                  ParamType.String,
                                                ),
                                                'observacao': serializeParam(
                                                  widget.observacao,
                                                  ParamType.String,
                                                ),
                                                'tecnicoid': serializeParam(
                                                  widget.tecnicoId,
                                                  ParamType.String,
                                                ),
                                                'servicoid': serializeParam(
                                                  widget.servicoId,
                                                  ParamType.String,
                                                ),
                                                'data': serializeParam(
                                                  widget.data,
                                                  ParamType.String,
                                                ),
                                                'hora': serializeParam(
                                                  widget.horar,
                                                  ParamType.String,
                                                ),
                                                'jsonServico': serializeParam(
                                                  widget.jsonServico,
                                                  ParamType.JSON,
                                                ),
                                                'deslocamentoAtualFinalizado':
                                                    serializeParam(
                                                  true,
                                                  ParamType.bool,
                                                ),
                                                'polylinhaQueVemDoMenuInicial':
                                                    serializeParam(
                                                  '',
                                                  ParamType.String,
                                                ),
                                                'fazid': serializeParam(
                                                  widget.fazid,
                                                  ParamType.String,
                                                ),
                                                'autoAuditoria': serializeParam(
                                                  widget.autoAuditoria,
                                                  ParamType.bool,
                                                ),
                                                'autoAuditoriaQuantidadePontos':
                                                    serializeParam(
                                                  widget
                                                      .autoAuditoriaQuantidadePontos,
                                                  ParamType.int,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                  duration:
                                                      Duration(milliseconds: 0),
                                                ),
                                              },
                                            );
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
                                            var confirmDialogResponse =
                                                await showDialog<bool>(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Deseja pausar o deslocamento?'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      false),
                                                              child:
                                                                  Text('Não'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      true),
                                                              child:
                                                                  Text('Sim'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ) ??
                                                    false;
                                            if (!confirmDialogResponse) {
                                              return;
                                            }
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
                                              FFAppState()
                                                  .tempoEmSegundosPadraoDeCapturaDeLocal,
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

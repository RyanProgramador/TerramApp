import '/backend/api_requests/api_calls.dart';
import '/components/carregando_os_widget.dart';
import '/components/conexao_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'configuracoes_model.dart';
export 'configuracoes_model.dart';

class ConfiguracoesWidget extends StatefulWidget {
  const ConfiguracoesWidget({super.key});

  @override
  State<ConfiguracoesWidget> createState() => _ConfiguracoesWidgetState();
}

class _ConfiguracoesWidgetState extends State<ConfiguracoesWidget> {
  late ConfiguracoesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConfiguracoesModel());
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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Configurações',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 0.0, 0.0),
                        child: Text(
                          'configurações do aplicativo',
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    fontWeight: FontWeight.w200,
                                  ),
                        ),
                      ),
                      if (_model.estaCarregando)
                        LinearPercentIndicator(
                          percent: valueOrDefault<double>(
                            _model.porcentagemDeCarregamento,
                            0.0,
                          ),
                          lineHeight: 30.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: FlutterFlowTheme.of(context).primary,
                          backgroundColor:
                              FlutterFlowTheme.of(context).primaryBtnText,
                          center: Text(
                            valueOrDefault<String>(
                              _model.porcentagemString,
                              '0%',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Outfit',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: ConexaoWidget(),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Configurações de Conexão',
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge,
                                        ),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  var _shouldSetState = false;
                                  setState(() {
                                    _model.estaCarregando = true;
                                    _model.porcentagemDeCarregamento = 0.1;
                                    _model.porcentagemString = '12%';
                                  });
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    isDismissible: false,
                                    enableDrag: false,
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: CarregandoOsWidget(),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));

                                  _model.sincPontosMedicaoEPerfilEProfundidaAPI =
                                      await SincronizarGroup
                                          .trSincronizaPontosMedicaoCall
                                          .call(
                                    urlapicall: FFAppState().urlapicall,
                                    pontosColetados: functions.jsonListToStr(
                                        FFAppState().PontosColetados.toList()),
                                  );
                                  _shouldSetState = true;
                                  setState(() {
                                    _model.estaCarregando = true;
                                    _model.porcentagemDeCarregamento = 0.2;
                                    _model.porcentagemString = '20%';
                                  });
                                  _model.sincCelComBD = await SincronizarGroup
                                      .trSincronizaCelularComBDCall
                                      .call(
                                    urlapicall: FFAppState().urlapicall,
                                    lista: functions.jsonListToStr(FFAppState()
                                        .trOsDeslocamentosJsonFinalizados
                                        .toList()),
                                    listaGeo: functions.jsonListToStr(
                                        FFAppState().trDeslocGeo2.toList()),
                                  );
                                  _shouldSetState = true;
                                  setState(() {
                                    _model.porcentagemDeCarregamento = 0.4;
                                    _model.porcentagemString = '40%';
                                  });
                                  _model.trSincTalhao = await SincronizarGroup
                                      .trSincronizaTalhaoContornoCall
                                      .call(
                                    talhao: functions.jsonListToStr(FFAppState()
                                        .grupoContornoFazendas
                                        .toList()),
                                    contorno: functions.jsonListToStr(
                                        FFAppState().contornoFazenda.toList()),
                                    urlapicall: FFAppState().urlapicall,
                                    recorte: functions.jsonListToStr(
                                        FFAppState()
                                            .latlngRecorteTalhao
                                            .toList()),
                                  );
                                  _shouldSetState = true;
                                  setState(() {
                                    _model.porcentagemDeCarregamento = 0.6;
                                    _model.porcentagemString = '62%';
                                  });
                                  setState(() {
                                    _model.porcentagemDeCarregamento = 0.63;
                                    _model.porcentagemString = '66%';
                                  });
                                  if (SincronizarGroup
                                          .trSincronizaCelularComBDCall
                                          .statusSincComCelular(
                                        (_model.sincCelComBD?.jsonBody ?? ''),
                                      )! &&
                                      getJsonField(
                                        (_model.trSincTalhao?.jsonBody ?? ''),
                                        r'''$.status''',
                                      ) &&
                                      (_model.sincPontosMedicaoEPerfilEProfundidaAPI
                                              ?.succeeded ??
                                          true)) {
                                    setState(() {
                                      _model.porcentagemDeCarregamento = 0.7;
                                      _model.porcentagemString = '72%';
                                    });
                                    setState(() {
                                      FFAppState()
                                              .grupoContornoFazendasPosSincronizado =
                                          functions
                                              .juntarDuasListasJsonignoraDuplicados(
                                                  FFAppState()
                                                      .grupoContornoFazendasPosSincronizado
                                                      .toList(),
                                                  SincronizarGroup
                                                      .trSincronizaTalhaoContornoCall
                                                      .dadosGrupoContornoSincDoWeb(
                                                        (_model.trSincTalhao
                                                                ?.jsonBody ??
                                                            ''),
                                                      )
                                                      ?.toList())!
                                              .toList()
                                              .cast<dynamic>();
                                      FFAppState()
                                              .contornoFazendaPosSincronizado =
                                          functions
                                              .juntarDuasListasJsonignoraDuplicados(
                                                  FFAppState()
                                                      .contornoFazendaPosSincronizado
                                                      .toList(),
                                                  SincronizarGroup
                                                      .trSincronizaTalhaoContornoCall
                                                      .dadosContornosSincDaWeb(
                                                        (_model.trSincTalhao
                                                                ?.jsonBody ??
                                                            ''),
                                                      )
                                                      ?.toList())!
                                              .toList()
                                              .cast<dynamic>();
                                      FFAppState()
                                              .latlngRecorteTalhaoPosSincronizado =
                                          functions
                                              .juntarDuasListasJsonignoraDuplicados(
                                                  FFAppState()
                                                      .latlngRecorteTalhao
                                                      .toList(),
                                                  FFAppState()
                                                      .latlngRecorteTalhaoPosSincronizado
                                                      .toList())!
                                              .toList()
                                              .cast<dynamic>();
                                      FFAppState().pontosDeColeta =
                                          getJsonField(
                                        (_model.sincPontosMedicaoEPerfilEProfundidaAPI
                                                ?.jsonBody ??
                                            ''),
                                        r'''$.pontos_de_coleta[:]''',
                                        true,
                                      )!
                                              .toList()
                                              .cast<dynamic>();
                                      FFAppState().perfilprofundidades =
                                          getJsonField(
                                        (_model.sincPontosMedicaoEPerfilEProfundidaAPI
                                                ?.jsonBody ??
                                            ''),
                                        r'''$.perfil_profundidades[:]''',
                                        true,
                                      )!
                                              .toList()
                                              .cast<dynamic>();
                                      FFAppState().profundidades = getJsonField(
                                        (_model.sincPontosMedicaoEPerfilEProfundidaAPI
                                                ?.jsonBody ??
                                            ''),
                                        r'''$.profundidades[:]''',
                                        true,
                                      )!
                                          .toList()
                                          .cast<dynamic>();
                                      FFAppState().perfis = getJsonField(
                                        (_model.sincPontosMedicaoEPerfilEProfundidaAPI
                                                ?.jsonBody ??
                                            ''),
                                        r'''$.perfis[:]''',
                                        true,
                                      )!
                                          .toList()
                                          .cast<dynamic>();
                                      FFAppState().listaContornoColeta =
                                          getJsonField(
                                        (_model.sincPontosMedicaoEPerfilEProfundidaAPI
                                                ?.jsonBody ??
                                            ''),
                                        r'''$.contornos[:]''',
                                        true,
                                      )!
                                              .toList()
                                              .cast<dynamic>();
                                      FFAppState().profundidadesPonto =
                                          getJsonField(
                                        (_model.sincPontosMedicaoEPerfilEProfundidaAPI
                                                ?.jsonBody ??
                                            ''),
                                        r'''$.pontos_profundidades[:]''',
                                        true,
                                      )!
                                              .toList()
                                              .cast<dynamic>();
                                    });
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text(SincronizarGroup
                                              .trSincronizaCelularComBDCall
                                              .retornoSincComCelular(
                                            (_model.sincCelComBD?.jsonBody ??
                                                ''),
                                          )!),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    setState(() {
                                      _model.estaCarregando = true;
                                      _model.porcentagemDeCarregamento = 0.78;
                                      _model.porcentagemString = '78%';
                                    });
                                    FFAppState().update(() {
                                      FFAppState()
                                          .trOsDeslocamentosJsonFinalizados = [];
                                      FFAppState().trDeslocamentoGeo = [];
                                      FFAppState().trDeslocGeo2 = [];
                                      FFAppState().contornoFazenda = [];
                                      FFAppState().grupoContornoFazendas = [];
                                      FFAppState().latlngRecorteTalhao = [];
                                      FFAppState().PontosColetados = [];
                                    });
                                    setState(() {
                                      _model.porcentagemDeCarregamento = 0.82;
                                      _model.porcentagemString = '82%';
                                    });
                                    Navigator.pop(context);
                                    setState(() {
                                      _model.porcentagemDeCarregamento = 0.99;
                                      _model.porcentagemString = '99%';
                                    });
                                    setState(() {
                                      _model.estaCarregando = false;
                                    });
                                  } else if (!SincronizarGroup
                                          .trSincronizaCelularComBDCall
                                          .statusSincComCelular(
                                        (_model.sincCelComBD?.jsonBody ?? ''),
                                      )! &&
                                      !getJsonField(
                                        (_model.trSincTalhao?.jsonBody ?? ''),
                                        r'''$.status''',
                                      ) &&
                                      !(_model.sincPontosMedicaoEPerfilEProfundidaAPI
                                              ?.succeeded ??
                                          true)) {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text(
                                              'Ops! Um erro inesperado aconteceu!'),
                                          content: Text('Codigo: #001'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    Navigator.pop(context);
                                    setState(() {
                                      _model.estaCarregando = false;
                                    });
                                    if (_shouldSetState) setState(() {});
                                    return;
                                  } else if (!SincronizarGroup
                                          .trSincronizaCelularComBDCall
                                          .statusSincComCelular(
                                        (_model.sincCelComBD?.jsonBody ?? ''),
                                      )! &&
                                      getJsonField(
                                        (_model.trSincTalhao?.jsonBody ?? ''),
                                        r'''$.status''',
                                      )) {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text(
                                              'Ops! Um erro inesperado aconteceu!'),
                                          content: Text('Codigo: #002'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    Navigator.pop(context);
                                    setState(() {
                                      _model.estaCarregando = false;
                                    });
                                    if (_shouldSetState) setState(() {});
                                    return;
                                  } else if (SincronizarGroup
                                          .trSincronizaCelularComBDCall
                                          .statusSincComCelular(
                                        (_model.sincCelComBD?.jsonBody ?? ''),
                                      )! &&
                                      !getJsonField(
                                        (_model.trSincTalhao?.jsonBody ?? ''),
                                        r'''$.status''',
                                      )) {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text(
                                              'Ops! Um erro inesperado aconteceu!'),
                                          content: Text('Codigo: #003'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    Navigator.pop(context);
                                    setState(() {
                                      _model.estaCarregando = false;
                                    });
                                    if (_shouldSetState) setState(() {});
                                    return;
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text(
                                              'Ops! Um erro inesperado aconteceu!'),
                                          content: Text('Codigo: #004'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    Navigator.pop(context);
                                    setState(() {
                                      _model.estaCarregando = false;
                                    });
                                    if (_shouldSetState) setState(() {});
                                    return;
                                  }

                                  if (_shouldSetState) setState(() {});
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sincronizar',
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge,
                                        ),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 1.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Sincronizar automaticamente',
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge,
                                      ),
                                      Switch.adaptive(
                                        value: _model.switchValue ??=
                                            FFAppState().sincronizcaoAutomatica,
                                        onChanged: (newValue) async {
                                          setState(() =>
                                              _model.switchValue = newValue!);
                                          if (newValue!) {
                                            var confirmDialogResponse =
                                                await showDialog<bool>(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title:
                                                              Text('Atenção!'),
                                                          content: Text(
                                                              'Ao ativar a sincronização automática você estará enviando os dados recem coletados para a empresa'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      false),
                                                              child: Text(
                                                                  'Cancelar'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      true),
                                                              child: Text(
                                                                  'Prosseguir'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ) ??
                                                    false;
                                            if (confirmDialogResponse) {
                                              setState(() {
                                                FFAppState()
                                                        .sincronizcaoAutomatica =
                                                    true;
                                              });
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Sincronização automatica ativada'),
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
                                            } else {
                                              setState(() {
                                                _model.switchValue = false;
                                              });
                                              return;
                                            }
                                          } else {
                                            setState(() {
                                              FFAppState()
                                                      .sincronizcaoAutomatica =
                                                  false;
                                            });
                                          }
                                        },
                                        activeColor: Color(0xFF005E59),
                                        activeTrackColor:
                                            FlutterFlowTheme.of(context)
                                                .success,
                                        inactiveTrackColor:
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                        inactiveThumbColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (FFAppState().Desenvolvimento)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 1.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                            'MultiplePlacesPickerCopy');
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Desenvolvedores',
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge,
                                          ),
                                          Icon(
                                            Icons.chevron_right_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
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
                      Align(
                        alignment: AlignmentDirectional(-1.0, 1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              22.0, 0.0, 0.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            alignment: AlignmentDirectional(-1.0, 1.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Terram',
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'Outfit',
                                        fontSize: 18.0,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 4.0, 0.0, 0.0),
                                  child: Text(
                                    'v1.9.528',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w200,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ].addToEnd(SizedBox(height: 64.0)),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            FFAppState().update(() {
                              FFAppState().tecID = '';
                              FFAppState().tecNome = '';
                              FFAppState().userLogin = '';
                              FFAppState().psdwLogin = '';
                            });

                            context.pushNamed('Login');

                            setState(() {
                              FFAppState().trOrdemServicos = [];
                              FFAppState().trFazendas = [];
                              FFAppState().trOsTecnicos = [];
                              FFAppState().trOsServicos = [];
                              FFAppState().trServicos = [];
                              FFAppState().trTecnicos = [];
                              FFAppState().trOsDeslocamentos = [];
                              FFAppState().trOsServicoEmAndamento = null;
                              FFAppState().trDesloacamentoIniciado = false;
                              FFAppState().DeslocamentoPausado = false;
                              FFAppState().trDeslocamentoFinalizado = false;
                              FFAppState().servicosFinalizadosComSucesso = [];
                              FFAppState().MotivoPausaDeslocamento = [];
                              FFAppState().strDeslocamentosJson = '';
                              FFAppState().trOsDeslocamentoListaFinalizados =
                                  [];
                            });
                          },
                          text: 'Deslogar',
                          icon: Icon(
                            Icons.logout,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            width: 160.0,
                            height: 52.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).error,
                            textStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBtnText,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
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
    );
  }
}

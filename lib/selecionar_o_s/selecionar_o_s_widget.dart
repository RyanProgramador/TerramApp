import '/backend/api_requests/api_calls.dart';
import '/components/iniciar_deslocamento_widget.dart';
import '/components/loading_comp_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'selecionar_o_s_model.dart';
export 'selecionar_o_s_model.dart';

class SelecionarOSWidget extends StatefulWidget {
  const SelecionarOSWidget({Key? key}) : super(key: key);

  @override
  _SelecionarOSWidgetState createState() => _SelecionarOSWidgetState();
}

class _SelecionarOSWidgetState extends State<SelecionarOSWidget>
    with TickerProviderStateMixin {
  late SelecionarOSModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  final animationsMap = {
    'columnOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelecionarOSModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      _model.checkgps = await actions.checkGps();
      if (!_model.checkgps!) {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Por favor, ative sua localização.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
        return;
      }
      setState(() {
        FFAppState().AtualLocalizcao = currentUserLocationValue!.toString();
      });
      await requestPermission(locationPermission);
      await requestPermission(notificationsPermission);
      setState(() {
        FFAppState().AtualLocalizcao = currentUserLocationValue!.toString();
      });
      if (FFAppState().trOsServicos.length != 0) {
        return;
      }
      _model.trOsTecnicosSincroniza =
          await SincronizarGroup.trOsTecnicoCall.call(
        urlapicall: FFAppState().urlapicall,
      );
      _model.sincOsRet = await SincronizarGroup.ordemDeServicoCall.call(
        urlapicall: FFAppState().urlapicall,
      );
      _model.trFazendasSinc = await SincronizarGroup.trFazendasCall.call(
        urlapicall: FFAppState().urlapicall,
      );
      _model.trServicosSinc = await SincronizarGroup.trServicosCall.call(
        urlapicall: FFAppState().urlapicall,
      );
      _model.trOsServicosSinc = await SincronizarGroup.trOsServicosCall.call(
        urlapicall: FFAppState().urlapicall,
        tecId: FFAppState().tecID,
      );
      _model.trTecnicosSinc = await SincronizarGroup.trTecnicosCall.call(
        urlapicall: FFAppState().urlapicall,
      );
      if ((_model.trTecnicosSinc?.succeeded ?? true) &&
          (_model.trOsServicosSinc?.succeeded ?? true) &&
          (_model.trServicosSinc?.succeeded ?? true) &&
          (_model.trFazendasSinc?.succeeded ?? true) &&
          (_model.sincOsRet?.succeeded ?? true) &&
          (_model.trOsTecnicosSincroniza?.succeeded ?? true)) {
        setState(() {
          FFAppState().trOrdemServicos = SincronizarGroup.ordemDeServicoCall
              .ordemServicoDados(
                (_model.sincOsRet?.jsonBody ?? ''),
              )!
              .toList()
              .cast<dynamic>();
          FFAppState().trFazendas = SincronizarGroup.trFazendasCall
              .dadosTrFazendas(
                (_model.trFazendasSinc?.jsonBody ?? ''),
              )!
              .toList()
              .cast<dynamic>();
          FFAppState().trOsTecnicos = SincronizarGroup.trOsTecnicoCall
              .dadosTrOsTecnico(
                (_model.trOsTecnicosSincroniza?.jsonBody ?? ''),
              )!
              .toList()
              .cast<dynamic>();
          FFAppState().trOsServicos = SincronizarGroup.trOsServicosCall
              .dadosTrOsServicos(
                (_model.trOsServicosSinc?.jsonBody ?? ''),
              )!
              .toList()
              .cast<dynamic>();
          FFAppState().trServicos = SincronizarGroup.trServicosCall
              .dadosTrServicos(
                (_model.trServicosSinc?.jsonBody ?? ''),
              )!
              .toList()
              .cast<dynamic>();
          FFAppState().trTecnicos = SincronizarGroup.trTecnicosCall
              .dadosTrTecnicos(
                (_model.trTecnicosSinc?.jsonBody ?? ''),
              )!
              .toList()
              .cast<dynamic>();
        });
      } else {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Ops!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
        return;
      }
    });

    _model.searchBarController ??= TextEditingController();
    _model.searchBarFocusNode ??= FocusNode();
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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primary,
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0),
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(0.0),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/terram-branco.png',
                              width: 350.0,
                              height: 66.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 10,
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                    child: ClipRRect(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 0.0, 0.0),
                                    child: Text(
                                      'Ordens de serviço:',
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional(0.00, 0.00),
                                      child: Container(
                                        decoration: BoxDecoration(),
                                        alignment:
                                            AlignmentDirectional(0.00, 0.00),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.00, 0.00),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.00, 0.00),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 12.0,
                                                          16.0, 0.0),
                                                  child: TextFormField(
                                                    controller: _model
                                                        .searchBarController,
                                                    focusNode: _model
                                                        .searchBarFocusNode,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .words,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Pesquisar',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium,
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  24.0,
                                                                  24.0,
                                                                  20.0,
                                                                  24.0),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium,
                                                    validator: _model
                                                        .searchBarControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.95, 0.01),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 12.0, 12.0, 0.0),
                                                  child: FlutterFlowIconButton(
                                                    borderColor:
                                                        Color(0x0080B9B6),
                                                    borderRadius: 30.0,
                                                    borderWidth: 1.0,
                                                    buttonSize: 50.0,
                                                    fillColor:
                                                        Color(0x0080B9B6),
                                                    icon: Icon(
                                                      Icons.search_sharp,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .lineColor,
                                                      size: 30.0,
                                                    ),
                                                    onPressed: () {
                                                      print(
                                                          'IconButton pressed ...');
                                                    },
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
                              Builder(
                                builder: (context) {
                                  final trOsServicos =
                                      FFAppState().trOsServicos.toList();
                                  if (trOsServicos.isEmpty) {
                                    return Center(
                                      child: Container(
                                        width: double.infinity,
                                        height: 150.0,
                                        child: LoadingCompWidget(),
                                      ),
                                    );
                                  }
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(trOsServicos.length,
                                        (trOsServicosIndex) {
                                      final trOsServicosItem =
                                          trOsServicos[trOsServicosIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 8.0, 16.0, 0.0),
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 100),
                                          curve: Curves.easeInOut,
                                          width: double.infinity,
                                          height: 78.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            border: Border.all(
                                              color: trOsServicosItem ==
                                                      FFAppState()
                                                          .trOsServicoEmAndamento
                                                  ? FlutterFlowTheme.of(context)
                                                      .customColor1
                                                  : FlutterFlowTheme.of(context)
                                                      .lineColor,
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 8.0, 12.0, 8.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
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
                                                          ? FocusScope.of(
                                                                  context)
                                                              .requestFocus(_model
                                                                  .unfocusNode)
                                                          : FocusScope.of(
                                                                  context)
                                                              .unfocus(),
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child: Container(
                                                          height:
                                                              double.infinity,
                                                          child:
                                                              IniciarDeslocamentoWidget(
                                                            etapade: functions
                                                                .ligaoDeNome(
                                                                    FFAppState()
                                                                        .trServicos
                                                                        .toList(),
                                                                    'serv_id',
                                                                    'serv_nome',
                                                                    getJsonField(
                                                                      trOsServicosItem,
                                                                      r'''$.oserv_id_serv''',
                                                                    ).toString())!,
                                                            fazendaNome: functions
                                                                .ligaoDeNome(
                                                                    FFAppState()
                                                                        .trFazendas
                                                                        .toList(),
                                                                    'faz_id',
                                                                    'faz_nome',
                                                                    valueOrDefault<
                                                                        String>(
                                                                      functions.ligacaoEntreListas(
                                                                          getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$''',
                                                                            true,
                                                                          ),
                                                                          FFAppState().trOrdemServicos.toList(),
                                                                          'oserv_id_os',
                                                                          'os_id',
                                                                          'os_id_faz'),
                                                                      '404',
                                                                    ))!,
                                                            latlngFaz: functions.strToLatLng(
                                                                functions.ligaoDeNome(
                                                                    FFAppState().trFazendas.toList(),
                                                                    'faz_id',
                                                                    'faz_latitude',
                                                                    valueOrDefault<String>(
                                                                      functions.ligacaoEntreListas(
                                                                          getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$''',
                                                                            true,
                                                                          ),
                                                                          FFAppState().trOrdemServicos.toList(),
                                                                          'oserv_id_os',
                                                                          'os_id',
                                                                          'os_id_faz'),
                                                                      '404',
                                                                    )),
                                                                functions.ligaoDeNome(
                                                                    FFAppState().trFazendas.toList(),
                                                                    'faz_id',
                                                                    'faz_longitude',
                                                                    valueOrDefault<String>(
                                                                      functions.ligacaoEntreListas(
                                                                          getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$''',
                                                                            true,
                                                                          ),
                                                                          FFAppState().trOrdemServicos.toList(),
                                                                          'oserv_id_os',
                                                                          'os_id',
                                                                          'os_id_faz'),
                                                                      '404',
                                                                    )))!,
                                                            cidadeFaz: functions
                                                                .ligaoDeNome(
                                                                    FFAppState()
                                                                        .trFazendas
                                                                        .toList(),
                                                                    'faz_id',
                                                                    'faz_cidade',
                                                                    valueOrDefault<
                                                                        String>(
                                                                      functions.ligacaoEntreListas(
                                                                          getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$''',
                                                                            true,
                                                                          ),
                                                                          FFAppState().trOrdemServicos.toList(),
                                                                          'oserv_id_os',
                                                                          'os_id',
                                                                          'os_id_faz'),
                                                                      '404',
                                                                    ))!,
                                                            estadoFaz: functions
                                                                .ligaoDeNome(
                                                                    FFAppState()
                                                                        .trFazendas
                                                                        .toList(),
                                                                    'faz_id',
                                                                    'faz_estado',
                                                                    valueOrDefault<
                                                                        String>(
                                                                      functions.ligacaoEntreListas(
                                                                          getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$''',
                                                                            true,
                                                                          ),
                                                                          FFAppState().trOrdemServicos.toList(),
                                                                          'oserv_id_os',
                                                                          'os_id',
                                                                          'os_id_faz'),
                                                                      '404',
                                                                    ))!,
                                                            observacao:
                                                                getJsonField(
                                                              trOsServicosItem,
                                                              r'''$.oserv_observacao''',
                                                            ).toString(),
                                                            tecnicoId:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions
                                                                  .ligacaoEntreListas(
                                                                      getJsonField(
                                                                        trOsServicosItem,
                                                                        r'''$''',
                                                                        true,
                                                                      ),
                                                                      FFAppState()
                                                                          .trOsTecnicos
                                                                          .toList(),
                                                                      'oserv_id',
                                                                      'ostec_id_serv',
                                                                      'ostec_id_tec'),
                                                              '404',
                                                            ),
                                                            servicoId:
                                                                getJsonField(
                                                              trOsServicosItem,
                                                              r'''$.oserv_id_os''',
                                                            ).toString(),
                                                            data: functions
                                                                .strToData(
                                                                    valueOrDefault<
                                                                        String>(
                                                              getJsonField(
                                                                trOsServicosItem,
                                                                r'''$.oserv_dthr_agendamento''',
                                                              ).toString(),
                                                              '2099-01-01 00:00:00',
                                                            ))!,
                                                            hora: functions
                                                                .strToHORA(
                                                                    valueOrDefault<
                                                                        String>(
                                                              getJsonField(
                                                                trOsServicosItem,
                                                                r'''$.oserv_dthr_agendamento''',
                                                              ).toString(),
                                                              '2099-01-01 00:00:00',
                                                            ))!,
                                                            jsonServico:
                                                                trOsServicosItem,
                                                            deslocamentoAtualFinzalizado:
                                                                FFAppState()
                                                                    .servicosFinalizadosComSucesso
                                                                    .contains(
                                                                        getJsonField(
                                                                      trOsServicosItem,
                                                                      r'''$.oserv_id''',
                                                                    ).toString()),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          if (functions
                                                                  .ligaoDeNome(
                                                                      FFAppState()
                                                                          .trServicos
                                                                          .toList(),
                                                                      'serv_id',
                                                                      'serv_nome',
                                                                      getJsonField(
                                                                        trOsServicosItem,
                                                                        r'''$.oserv_id_serv''',
                                                                      ).toString()) ==
                                                              'Coleta')
                                                            FaIcon(
                                                              FontAwesomeIcons
                                                                  .vials,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 24.0,
                                                            ),
                                                          if (() {
                                                            if (functions.ligaoDeNome(
                                                                    FFAppState().trServicos.toList(),
                                                                    'serv_id',
                                                                    'serv_nome',
                                                                    getJsonField(
                                                                      trOsServicosItem,
                                                                      r'''$.oserv_id_serv''',
                                                                    ).toString()) ==
                                                                'Contorno') {
                                                              return true;
                                                            } else if (functions.ligaoDeNome(
                                                                    FFAppState().trServicos.toList(),
                                                                    'serv_id',
                                                                    'serv_nome',
                                                                    getJsonField(
                                                                      trOsServicosItem,
                                                                      r'''$.oserv_id_serv''',
                                                                    ).toString()) ==
                                                                'Atualização de contorno') {
                                                              return false;
                                                            } else {
                                                              return false;
                                                            }
                                                          }())
                                                            FaIcon(
                                                              FontAwesomeIcons
                                                                  .motorcycle,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 24.0,
                                                            ),
                                                          if (() {
                                                            if (functions.ligaoDeNome(
                                                                    FFAppState().trServicos.toList(),
                                                                    'serv_id',
                                                                    'serv_nome',
                                                                    getJsonField(
                                                                      trOsServicosItem,
                                                                      r'''$.oserv_id_serv''',
                                                                    ).toString()) ==
                                                                'Contorno') {
                                                              return false;
                                                            } else if (functions.ligaoDeNome(
                                                                    FFAppState().trServicos.toList(),
                                                                    'serv_id',
                                                                    'serv_nome',
                                                                    getJsonField(
                                                                      trOsServicosItem,
                                                                      r'''$.oserv_id_serv''',
                                                                    ).toString()) ==
                                                                'Atualização de contorno') {
                                                              return true;
                                                            } else {
                                                              return false;
                                                            }
                                                          }())
                                                            FaIcon(
                                                              FontAwesomeIcons
                                                                  .route,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 24.0,
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 7,
                                                    child: ClipRRect(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '#${getJsonField(
                                                                trOsServicosItem,
                                                                r'''$.oserv_id''',
                                                              ).toString()}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                            ),
                                                            Text(
                                                              'Fazenda: ${functions.ligaoDeNome(FFAppState().trFazendas.toList(), 'faz_id', 'faz_nome', valueOrDefault<String>(
                                                                        functions.ligacaoEntreListas(
                                                                            getJsonField(
                                                                              trOsServicosItem,
                                                                              r'''$''',
                                                                              true,
                                                                            ),
                                                                            FFAppState().trOrdemServicos.toList(),
                                                                            'oserv_id_os',
                                                                            'os_id',
                                                                            'os_id_faz'),
                                                                        '404',
                                                                      ))}'
                                                                  .maybeHandleOverflow(
                                                                maxChars: 20,
                                                                replacement:
                                                                    '…',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                            Text(
                                                              '${functions.ligaoDeNome(FFAppState().trFazendas.toList(), 'faz_id', 'faz_cidade', valueOrDefault<String>(
                                                                    functions.ligacaoEntreListas(
                                                                        getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$''',
                                                                          true,
                                                                        ),
                                                                        FFAppState().trOrdemServicos.toList(),
                                                                        'oserv_id_os',
                                                                        'os_id',
                                                                        'os_id_faz'),
                                                                    '404',
                                                                  ))}, ${functions.ligaoDeNome(FFAppState().trFazendas.toList(), 'faz_id', 'faz_estado', valueOrDefault<String>(
                                                                    functions.ligacaoEntreListas(
                                                                        getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$''',
                                                                          true,
                                                                        ),
                                                                        FFAppState().trOrdemServicos.toList(),
                                                                        'oserv_id_os',
                                                                        'os_id',
                                                                        'os_id_faz'),
                                                                    '404',
                                                                  ))}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  if (!FFAppState()
                                                      .servicosFinalizadosComSucesso
                                                      .contains(getJsonField(
                                                        trOsServicosItem,
                                                        r'''$.oserv_id''',
                                                      ).toString()))
                                                    Expanded(
                                                      flex: 1,
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                1.00, 0.00),
                                                        child: Icon(
                                                          Icons.arrow_forward,
                                                          color: () {
                                                            if ((getJsonField(
                                                                      trOsServicosItem,
                                                                      r'''$.oserv_id''',
                                                                    ) ==
                                                                    FFAppState()
                                                                        .trOsServicoEmAndamento) &&
                                                                (FFAppState()
                                                                        .trDesloacamentoIniciado ==
                                                                    true) &&
                                                                (FFAppState()
                                                                        .DeslocamentoPausado ==
                                                                    false)) {
                                                              return FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary;
                                                            } else if ((getJsonField(
                                                                      trOsServicosItem,
                                                                      r'''$.oserv_id''',
                                                                    ) ==
                                                                    FFAppState()
                                                                        .trOsServicoEmAndamento) &&
                                                                (FFAppState()
                                                                        .DeslocamentoPausado ==
                                                                    true)) {
                                                              return FlutterFlowTheme
                                                                      .of(context)
                                                                  .error;
                                                            } else {
                                                              return FlutterFlowTheme
                                                                      .of(context)
                                                                  .lineColor;
                                                            }
                                                          }(),
                                                          size: 34.0,
                                                        ),
                                                      ),
                                                    ),
                                                  if (FFAppState()
                                                      .servicosFinalizadosComSucesso
                                                      .contains(getJsonField(
                                                        trOsServicosItem,
                                                        r'''$.oserv_id''',
                                                      ).toString()))
                                                    Expanded(
                                                      flex: 1,
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                1.00, 0.00),
                                                        child: Icon(
                                                          Icons.task_alt,
                                                          color:
                                                              Color(0xFF00AD75),
                                                          size: 34.0,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),
                            ],
                          ),
                        ).animateOnPageLoad(
                            animationsMap['columnOnPageLoadAnimation']!),
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

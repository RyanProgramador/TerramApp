import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'multiple_places_picker_copy_model.dart';
export 'multiple_places_picker_copy_model.dart';

class MultiplePlacesPickerCopyWidget extends StatefulWidget {
  const MultiplePlacesPickerCopyWidget({Key? key}) : super(key: key);

  @override
  _MultiplePlacesPickerCopyWidgetState createState() =>
      _MultiplePlacesPickerCopyWidgetState();
}

class _MultiplePlacesPickerCopyWidgetState
    extends State<MultiplePlacesPickerCopyWidget>
    with TickerProviderStateMixin {
  late MultiplePlacesPickerCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'buttonOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        MoveEffect(
          curve: Curves.easeIn,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 100.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MultiplePlacesPickerCopyModel());

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var _shouldSetState = false;
            _model.trOsTecnicosSincroniza =
                await SincronizarGroup.trOsTecnicoCall.call(
              urlapicall: FFAppState().urlapicall,
            );
            _shouldSetState = true;
            _model.sincOsRet = await SincronizarGroup.ordemDeServicoCall.call(
              urlapicall: FFAppState().urlapicall,
            );
            _shouldSetState = true;
            _model.trFazendasSinc = await SincronizarGroup.trFazendasCall.call(
              urlapicall: FFAppState().urlapicall,
            );
            _shouldSetState = true;
            if ((_model.trOsTecnicosSincroniza?.succeeded ?? true)) {
              setState(() {
                FFAppState().trOrdemServicos =
                    SincronizarGroup.ordemDeServicoCall
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
              });
              await showDialog(
                context: context,
                builder: (alertDialogContext) {
                  return AlertDialog(
                    title: Text('sucess!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(alertDialogContext),
                        child: Text('Ok'),
                      ),
                    ],
                  );
                },
              );
              if (animationsMap['buttonOnActionTriggerAnimation'] != null) {
                await animationsMap['buttonOnActionTriggerAnimation']!
                    .controller
                    .forward(from: 0.0);
              }
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
              if (_shouldSetState) setState(() {});
              return;
            }

            setState(() {});
            if (_shouldSetState) setState(() {});
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 8.0,
          child: Icon(
            Icons.cloud_sync_outlined,
            color: FlutterFlowTheme.of(context).info,
            size: 32.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              SingleChildScrollView(
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
                              context.goNamed('MultiplePlacesPicker');
                            },
                            child: Icon(
                              Icons.transfer_within_a_station,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.goNamed('SelecionarOS');
                            },
                            child: Icon(
                              Icons.transfer_within_a_station,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              setState(() {
                                FFAppState().trOrdemServicos = [];
                                FFAppState().trFazendas = [];
                                FFAppState().trOsTecnicos = [];
                                FFAppState().trOsServicos = [];
                                FFAppState().trServicos = [];
                                FFAppState().trTecnicos = [];
                              });
                            },
                            child: FaIcon(
                              FontAwesomeIcons.trash,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                          ),
                          Opacity(
                            opacity: 0.0,
                            child: FlutterFlowTimer(
                              initialTime: _model.timer1Milliseconds,
                              getDisplayTime: (value) =>
                                  StopWatchTimer.getDisplayTime(
                                value,
                                hours: false,
                                milliSecond: false,
                              ),
                              controller: _model.timer1Controller,
                              updateStateInterval: Duration(milliseconds: 1000),
                              onChanged: (value, displayTime, shouldUpdate) {
                                _model.timer1Milliseconds = value;
                                _model.timer1Value = displayTime;
                                if (shouldUpdate) setState(() {});
                              },
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context).headlineSmall,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 16.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
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
                                  FFAppState().servicosFinalizadosComSucesso =
                                      [];
                                  FFAppState().MotivoPausaDeslocamento = [];
                                });
                              },
                              text: 'Limpar tudo',
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).secondary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.white,
                                    ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 10.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Os',
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 10.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0.00, 0.63),
                                  child: ClipRRect(
                                    child: Container(
                                      width: double.infinity,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Builder(
                                        builder: (context) {
                                          final ordemServicos = FFAppState()
                                              .trOrdemServicos
                                              .toList();
                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  ordemServicos.length,
                                                  (ordemServicosIndex) {
                                                final ordemServicosItem =
                                                    ordemServicos[
                                                        ordemServicosIndex];
                                                return Text(
                                                  ordemServicosItem.toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 10.0,
                                                      ),
                                                );
                                              }),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 10.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fazendas',
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 10.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0.00, 0.63),
                                  child: ClipRRect(
                                    child: Container(
                                      width: double.infinity,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Builder(
                                        builder: (context) {
                                          final fazendas =
                                              FFAppState().trFazendas.toList();
                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children:
                                                  List.generate(fazendas.length,
                                                      (fazendasIndex) {
                                                final fazendasItem =
                                                    fazendas[fazendasIndex];
                                                return Text(
                                                  fazendasItem.toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 10.0,
                                                      ),
                                                );
                                              }),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 10.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Técnicos',
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.00, 0.63),
                              child: ClipRRect(
                                child: Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Builder(
                                    builder: (context) {
                                      final trOsTecnicos =
                                          FFAppState().trOsTecnicos.toList();
                                      return SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children:
                                              List.generate(trOsTecnicos.length,
                                                  (trOsTecnicosIndex) {
                                            final trOsTecnicosItem =
                                                trOsTecnicos[trOsTecnicosIndex];
                                            return Text(
                                              trOsTecnicosItem.toString(),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 10.0,
                                                      ),
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'DESLOCAMENTO',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.00, 0.63),
                              child: ClipRRect(
                                child: Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Builder(
                                          builder: (context) {
                                            final trOsDeslocamentosGo =
                                                FFAppState()
                                                    .trDeslocamentoGeo
                                                    .toList();
                                            return SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    trOsDeslocamentosGo.length,
                                                    (trOsDeslocamentosGoIndex) {
                                                  final trOsDeslocamentosGoItem =
                                                      trOsDeslocamentosGo[
                                                          trOsDeslocamentosGoIndex];
                                                  return Text(
                                                    trOsDeslocamentosGoItem
                                                        .toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 10.0,
                                                        ),
                                                  );
                                                }),
                                              ),
                                            );
                                          },
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final trDeslocGo = FFAppState()
                                                .trDeslocGeo2
                                                .toList();
                                            return SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    trDeslocGo.length,
                                                    (trDeslocGoIndex) {
                                                  final trDeslocGoItem =
                                                      trDeslocGo[
                                                          trDeslocGoIndex];
                                                  return Text(
                                                    trDeslocGoItem.toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 10.0,
                                                        ),
                                                  );
                                                }),
                                              ),
                                            );
                                          },
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final trDeslocGo = FFAppState()
                                                .trDeslocamentoGeoDataType
                                                .toList();
                                            return SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    trDeslocGo.length,
                                                    (trDeslocGoIndex) {
                                                  final trDeslocGoItem =
                                                      trDeslocGo[
                                                          trDeslocGoIndex];
                                                  return Text(
                                                    (trDeslocGoItem.toMap())
                                                        .toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 10.0,
                                                        ),
                                                  );
                                                }),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.00, 0.63),
                              child: ClipRRect(
                                child: Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            functions.jsonToStr(FFAppState()
                                                .trOsDeslocamentoJsonAtual),
                                            'a',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10.0,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'DESLOCAMENTO Finalizados',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.00, 0.63),
                              child: ClipRRect(
                                child: Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Builder(
                                    builder: (context) {
                                      final deslocamentosFinalizados =
                                          FFAppState()
                                              .trOsDeslocamentosJsonFinalizados
                                              .toList();
                                      return SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(
                                              deslocamentosFinalizados.length,
                                              (deslocamentosFinalizadosIndex) {
                                            final deslocamentosFinalizadosItem =
                                                deslocamentosFinalizados[
                                                    deslocamentosFinalizadosIndex];
                                            return Text(
                                              deslocamentosFinalizadosItem
                                                  .toString(),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 10.0,
                                                      ),
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'DESLOCAMENTO list Finalizados',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.00, 0.63),
                              child: ClipRRect(
                                child: Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Builder(
                                    builder: (context) {
                                      final deslocamentosFinalizados =
                                          FFAppState()
                                              .trOsDeslocamentoListaFinalizados
                                              .toList();
                                      return SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(
                                              deslocamentosFinalizados.length,
                                              (deslocamentosFinalizadosIndex) {
                                            final deslocamentosFinalizadosItem =
                                                deslocamentosFinalizados[
                                                    deslocamentosFinalizadosIndex];
                                            return Text(
                                              deslocamentosFinalizadosItem,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 10.0,
                                                      ),
                                            );
                                          }),
                                        ),
                                      );
                                    },
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
              Align(
                alignment: AlignmentDirectional(0.88, 0.88),
                child: FFButtonWidget(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: Text(TrFazendasStruct.fromMap(
                                  (_model.trFazendasSinc?.jsonBody ?? ''))
                              .fazNome),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext),
                              child: Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  text: '',
                  icon: Icon(
                    Icons.search,
                    size: 15.0,
                  ),
                  options: FFButtonOptions(
                    width: 50.0,
                    height: 50.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  showLoadingIndicator: false,
                ).animateOnActionTrigger(
                  animationsMap['buttonOnActionTriggerAnimation']!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

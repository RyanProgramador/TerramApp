import '/components/maps_revisao_todos_widget.dart';
import '/components/maps_revisao_widget.dart';
import '/components/sem_contorno_no_momento_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'lista_contornos_model.dart';
export 'lista_contornos_model.dart';

class ListaContornosWidget extends StatefulWidget {
  const ListaContornosWidget({
    Key? key,
    required this.nomeFazenda,
    required this.oservID,
    String? fazid,
    this.fazlatlng,
  })  : this.fazid = fazid ?? '1',
        super(key: key);

  final String? nomeFazenda;
  final String? oservID;
  final String fazid;
  final LatLng? fazlatlng;

  @override
  _ListaContornosWidgetState createState() => _ListaContornosWidgetState();
}

class _ListaContornosWidgetState extends State<ListaContornosWidget> {
  late ListaContornosModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListaContornosModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().update(() {
        FFAppState().contornoFazenda =
            FFAppState().contornoFazenda.toList().cast<dynamic>();
      });
      setState(() {
        FFAppState().contornoFazenda =
            FFAppState().contornoFazenda.toList().cast<dynamic>();
        FFAppState().grupoContornoFazendas =
            FFAppState().grupoContornoFazendas.toList().cast<dynamic>();
      });
      setState(() {});
    });
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
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
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
                                  context.goNamed(
                                    'SelecionarOS',
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 0),
                                      ),
                                    },
                                  );
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
                            valueOrDefault<String>(
                              widget.nomeFazenda,
                              'Fazenda Sem Nome',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFFF8F8F8),
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () => _model.unfocusNode.canRequestFocus
                                ? FocusScope.of(context)
                                    .requestFocus(_model.unfocusNode)
                                : FocusScope.of(context).unfocus(),
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: Container(
                                height: 600.0,
                                child: MapsRevisaoTodosWidget(
                                  listagrupoTodos: functions.sortListJson(
                                      'oserv_id',
                                      true,
                                      FFAppState()
                                          .grupoContornoFazendas
                                          .toList(),
                                      widget.oservID),
                                  listaContornoTodos:
                                      FFAppState().contornoFazenda,
                                  fazlatlng: widget.fazlatlng,
                                ),
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                    text: 'Ver todos',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
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
                  Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (FFAppState()
                                      .grupoContornoFazendasPosSincronizado
                                      .length ==
                                  0)
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            22.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Contornos novos:',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        ),
                                      ),
                                      Builder(
                                        builder: (context) {
                                          final trGruposContornoFazenda = functions
                                                  .sortListJson(
                                                      'oserv_id',
                                                      true,
                                                      FFAppState()
                                                          .grupoContornoFazendas
                                                          .toList(),
                                                      widget.oservID)
                                                  ?.toList() ??
                                              [];
                                          if (trGruposContornoFazenda.isEmpty) {
                                            return Center(
                                              child: Container(
                                                width: double.infinity,
                                                height: 150.0,
                                                child:
                                                    SemContornoNoMomentoWidget(),
                                              ),
                                            );
                                          }
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                trGruposContornoFazenda.length,
                                                (trGruposContornoFazendaIndex) {
                                              final trGruposContornoFazendaItem =
                                                  trGruposContornoFazenda[
                                                      trGruposContornoFazendaIndex];
                                              return Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 8.0, 16.0, 0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 78.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    border: Border.all(
                                                      color: trGruposContornoFazendaItem ==
                                                              FFAppState()
                                                                  .trOsServicoEmAndamento
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .customColor1
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .lineColor,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 8.0,
                                                                12.0, 8.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          enableDrag: false,
                                                          context: context,
                                                          builder: (context) {
                                                            return GestureDetector(
                                                              onTap: () => _model
                                                                      .unfocusNode
                                                                      .canRequestFocus
                                                                  ? FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          _model
                                                                              .unfocusNode)
                                                                  : FocusScope.of(
                                                                          context)
                                                                      .unfocus(),
                                                              child: Padding(
                                                                padding: MediaQuery
                                                                    .viewInsetsOf(
                                                                        context),
                                                                child:
                                                                    Container(
                                                                  height: 600.0,
                                                                  child:
                                                                      MapsRevisaoWidget(
                                                                    listaLatLngEmString: functions.acessarJsonListaDeterminadoValor(
                                                                        functions
                                                                            .sortListJson(
                                                                                'contorno_grupo',
                                                                                false,
                                                                                FFAppState().contornoFazenda.toList(),
                                                                                getJsonField(
                                                                                  trGruposContornoFazendaItem,
                                                                                  r'''$.contorno_grupo''',
                                                                                ).toString())
                                                                            ?.toList(),
                                                                        'latlng')!,
                                                                    cor:
                                                                        getJsonField(
                                                                      trGruposContornoFazendaItem,
                                                                      r'''$.cor''',
                                                                    ).toString(),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            safeSetState(
                                                                () {}));
                                                      },
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  FaIcon(
                                                                    FontAwesomeIcons
                                                                        .route,
                                                                    color: valueOrDefault<
                                                                        Color>(
                                                                      functions
                                                                          .transformaStringEmCor(
                                                                              getJsonField(
                                                                        trGruposContornoFazendaItem,
                                                                        r'''$.cor''',
                                                                      ).toString()),
                                                                      Colors
                                                                          .black,
                                                                    ),
                                                                    size: 32.0,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 7,
                                                            child: Stack(
                                                              children: [
                                                                ClipRRect(
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              '# ${getJsonField(
                                                                                trGruposContornoFazendaItem,
                                                                                r'''$.contorno_grupo''',
                                                                              ).toString()}',
                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                    fontFamily: 'Readex Pro',
                                                                                    fontSize: 12.0,
                                                                                  ),
                                                                            ),
                                                                            Text(
                                                                              'Contorno'.maybeHandleOverflow(
                                                                                maxChars: 20,
                                                                                replacement: '…',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                    fontFamily: 'Readex Pro',
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                            ),
                                                                            Text(
                                                                              '${functions.strToData(getJsonField(
                                                                                trGruposContornoFazendaItem,
                                                                                r'''$.dthr_fim''',
                                                                              ).toString())} ás ${functions.strToHORA(getJsonField(
                                                                                trGruposContornoFazendaItem,
                                                                                r'''$.dthr_fim''',
                                                                              ).toString())}',
                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                    fontFamily: 'Readex Pro',
                                                                                    fontSize: 12.0,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          1.0,
                                                                          -1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            8.0,
                                                                            0.0),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          FFAppState()
                                                                              .removeAtIndexFromGrupoContornoFazendas(trGruposContornoFazendaIndex);
                                                                        });
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .clear,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        size:
                                                                            24.0,
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
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              if ((FFAppState()
                                          .grupoContornoFazendasPosSincronizado
                                          .length >=
                                      1) &&
                                  (FFAppState().grupoContornoFazendas.length ==
                                      0))
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            22.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Contornos já sincronizados:',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        ),
                                      ),
                                      Builder(
                                        builder: (context) {
                                          final trGruposContornoFazenda2 = functions
                                                  .sortListJson(
                                                      'oserv_id',
                                                      true,
                                                      FFAppState()
                                                          .grupoContornoFazendasPosSincronizado
                                                          .toList(),
                                                      widget.oservID)
                                                  ?.toList() ??
                                              [];
                                          if (trGruposContornoFazenda2
                                              .isEmpty) {
                                            return Center(
                                              child: Container(
                                                width: double.infinity,
                                                height: 150.0,
                                                child:
                                                    SemContornoNoMomentoWidget(),
                                              ),
                                            );
                                          }
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                trGruposContornoFazenda2.length,
                                                (trGruposContornoFazenda2Index) {
                                              final trGruposContornoFazenda2Item =
                                                  trGruposContornoFazenda2[
                                                      trGruposContornoFazenda2Index];
                                              return Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 8.0, 16.0, 0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 78.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    border: Border.all(
                                                      color: trGruposContornoFazenda2Item ==
                                                              FFAppState()
                                                                  .trOsServicoEmAndamento
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .customColor1
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .lineColor,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 8.0,
                                                                12.0, 8.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          enableDrag: false,
                                                          context: context,
                                                          builder: (context) {
                                                            return GestureDetector(
                                                              onTap: () => _model
                                                                      .unfocusNode
                                                                      .canRequestFocus
                                                                  ? FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          _model
                                                                              .unfocusNode)
                                                                  : FocusScope.of(
                                                                          context)
                                                                      .unfocus(),
                                                              child: Padding(
                                                                padding: MediaQuery
                                                                    .viewInsetsOf(
                                                                        context),
                                                                child:
                                                                    Container(
                                                                  height: 600.0,
                                                                  child:
                                                                      MapsRevisaoWidget(
                                                                    listaLatLngEmString: functions.acessarJsonListaDeterminadoValor(
                                                                        functions
                                                                            .sortListJson(
                                                                                'contorno_grupo',
                                                                                false,
                                                                                FFAppState().contornoFazendaPosSincronizado.toList(),
                                                                                getJsonField(
                                                                                  trGruposContornoFazenda2Item,
                                                                                  r'''$.contorno_grupo''',
                                                                                ).toString())
                                                                            ?.toList(),
                                                                        'latlng')!,
                                                                    cor:
                                                                        getJsonField(
                                                                      trGruposContornoFazenda2Item,
                                                                      r'''$.cor''',
                                                                    ).toString(),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            safeSetState(
                                                                () {}));
                                                      },
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  FaIcon(
                                                                    FontAwesomeIcons
                                                                        .route,
                                                                    color: valueOrDefault<
                                                                        Color>(
                                                                      functions
                                                                          .transformaStringEmCor(
                                                                              getJsonField(
                                                                        trGruposContornoFazenda2Item,
                                                                        r'''$.cor''',
                                                                      ).toString()),
                                                                      Colors
                                                                          .black,
                                                                    ),
                                                                    size: 32.0,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 7,
                                                            child: Stack(
                                                              children: [
                                                                ClipRRect(
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              '# ${getJsonField(
                                                                                trGruposContornoFazenda2Item,
                                                                                r'''$.contorno_grupo''',
                                                                              ).toString()}',
                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                    fontFamily: 'Readex Pro',
                                                                                    fontSize: 12.0,
                                                                                  ),
                                                                            ),
                                                                            Text(
                                                                              'Contorno'.maybeHandleOverflow(
                                                                                maxChars: 20,
                                                                                replacement: '…',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                    fontFamily: 'Readex Pro',
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                            ),
                                                                            Text(
                                                                              '${functions.strToData(getJsonField(
                                                                                trGruposContornoFazenda2Item,
                                                                                r'''$.dthr_fim''',
                                                                              ).toString())} ás ${functions.strToHORA(getJsonField(
                                                                                trGruposContornoFazenda2Item,
                                                                                r'''$.dthr_fim''',
                                                                              ).toString())}',
                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                    fontFamily: 'Readex Pro',
                                                                                    fontSize: 12.0,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          1.0,
                                                                          -1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            8.0,
                                                                            0.0),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          FFAppState()
                                                                              .removeAtIndexFromGrupoContornoFazendas(trGruposContornoFazenda2Index);
                                                                        });
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .clear,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        size:
                                                                            24.0,
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
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (functions
                                            .sortListJson(
                                                'oserv_id',
                                                true,
                                                FFAppState()
                                                    .grupoContornoFazendasPosSincronizado
                                                    .toList(),
                                                widget.oservID)!
                                            .length >=
                                        1)
                                      FFButtonWidget(
                                        onPressed: () async {
                                          context.goNamed(
                                            'ContornoDaFazenda',
                                            queryParameters: {
                                              'fazendaNome': serializeParam(
                                                widget.nomeFazenda,
                                                ParamType.String,
                                              ),
                                              'oservID': serializeParam(
                                                widget.oservID,
                                                ParamType.String,
                                              ),
                                              'idDoContorno': serializeParam(
                                                valueOrDefault<String>(
                                                  FFAppState().contornoGrupoID !=
                                                              null &&
                                                          FFAppState()
                                                                  .contornoGrupoID !=
                                                              ''
                                                      ? valueOrDefault<String>(
                                                          FFAppState()
                                                              .contornoGrupoID,
                                                          '1',
                                                        )
                                                      : '1',
                                                  '1',
                                                ),
                                                ParamType.String,
                                              ),
                                              'fazid': serializeParam(
                                                widget.fazid,
                                                ParamType.String,
                                              ),
                                              'fazlatlng': serializeParam(
                                                widget.fazlatlng,
                                                ParamType.LatLng,
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
                                        text: 'Iniciar contorno',
                                        options: FFButtonOptions(
                                          width: 200.0,
                                          height: 50.0,
                                          padding: EdgeInsets.all(0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
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
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

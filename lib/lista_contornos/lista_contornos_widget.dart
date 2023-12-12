import '/components/sem_contorno_no_momento_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
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
  }) : super(key: key);

  final String? nomeFazenda;
  final String? oservID;

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
                  Builder(
                    builder: (context) {
                      final trOsServicos =
                          FFAppState().contornoFazenda.toList();
                      if (trOsServicos.isEmpty) {
                        return Center(
                          child: Container(
                            width: double.infinity,
                            height: 150.0,
                            child: SemContornoNoMomentoWidget(),
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
                            child: Container(
                              width: double.infinity,
                              height: 78.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: trOsServicosItem ==
                                          FFAppState().trOsServicoEmAndamento
                                      ? FlutterFlowTheme.of(context)
                                          .customColor1
                                      : FlutterFlowTheme.of(context).lineColor,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 8.0, 12.0, 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        decoration: BoxDecoration(),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (() {
                                              if (functions.ligaoDeNome(
                                                      FFAppState()
                                                          .trServicos
                                                          .toList(),
                                                      'serv_id',
                                                      'serv_nome',
                                                      getJsonField(
                                                        trOsServicosItem,
                                                        r'''$.oserv_id_serv''',
                                                      ).toString()) ==
                                                  'Contorno') {
                                                return false;
                                              } else if (functions.ligaoDeNome(
                                                      FFAppState()
                                                          .trServicos
                                                          .toList(),
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
                                                FontAwesomeIcons.route,
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                          decoration: BoxDecoration(),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '#',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 12.0,
                                                        ),
                                              ),
                                              Text(
                                                'Contorno'.maybeHandleOverflow(
                                                  maxChars: 20,
                                                  replacement: '…',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                              Text(
                                                'Data e hora',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 12.0,
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
                                              AlignmentDirectional(1.00, 0.00),
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
                                                return FlutterFlowTheme.of(
                                                        context)
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
                                                return FlutterFlowTheme.of(
                                                        context)
                                                    .error;
                                              } else {
                                                return FlutterFlowTheme.of(
                                                        context)
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
                                              AlignmentDirectional(1.00, 0.00),
                                          child: Icon(
                                            Icons.task_alt,
                                            color: Color(0xFF249677),
                                            size: 34.0,
                                          ),
                                        ),
                                      ),
                                  ],
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed(
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
                          '1',
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );
                  },
                  text: 'Criar contorno',
                  options: FFButtonOptions(
                    width: 200.0,
                    height: 50.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

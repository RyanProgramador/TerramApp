import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'contorno_da_fazenda_model.dart';
export 'contorno_da_fazenda_model.dart';

class ContornoDaFazendaWidget extends StatefulWidget {
  const ContornoDaFazendaWidget({
    super.key,
    required this.fazendaNome,
    required this.oservID,
    String? idDoContorno,
    required this.fazid,
    this.fazlatlng,
  }) : this.idDoContorno = idDoContorno ?? '1';

  final String? fazendaNome;
  final String? oservID;
  final String idDoContorno;
  final String? fazid;
  final LatLng? fazlatlng;

  @override
  State<ContornoDaFazendaWidget> createState() =>
      _ContornoDaFazendaWidgetState();
}

class _ContornoDaFazendaWidgetState extends State<ContornoDaFazendaWidget> {
  late ContornoDaFazendaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContornoDaFazendaModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.textoInicioEFimDeContorno = 'Inicie o contorno!';
      });
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 90.0, 0.0, 0.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.99,
                            height: MediaQuery.sizeOf(context).height * 0.99,
                            child: custom_widgets.ContornoMap(
                              width: MediaQuery.sizeOf(context).width * 0.99,
                              height: MediaQuery.sizeOf(context).height * 0.99,
                              ativoOuNao: _model.ativo,
                              localAtual: currentUserLocationValue,
                              oservid: valueOrDefault<String>(
                                widget.oservID,
                                '1',
                              ),
                              idContorno: widget.idDoContorno,
                              fazid: widget.fazid!,
                              fazNome: widget.fazendaNome,
                              fazLatLng: widget.fazlatlng,
                              toleranciaEmMetrosEntreUmaCapturaEOutra: FFAppState()
                                          .distanciaEmMetrosDeToleranciaEntreUmaCapturaEOutra !=
                                      null
                                  ? FFAppState()
                                      .distanciaEmMetrosDeToleranciaEntreUmaCapturaEOutra
                                  : 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (true == false)
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 90.0, 0.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 1.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            alignment: AlignmentDirectional(0.0, 1.0),
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
                                                      'Você tem certeza que quer sair do contorno?'),
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
                                    setState(() {
                                      FFAppState().contornoFazenda =
                                          FFAppState()
                                              .contornoFazenda
                                              .toList()
                                              .cast<dynamic>();
                                      FFAppState().grupoContornoFazendas =
                                          FFAppState()
                                              .grupoContornoFazendas
                                              .toList()
                                              .cast<dynamic>();
                                    });
                                    setState(() {});

                                    context.goNamed(
                                      'ListaContornos',
                                      queryParameters: {
                                        'nomeFazenda': serializeParam(
                                          widget.fazendaNome,
                                          ParamType.String,
                                        ),
                                        'oservID': serializeParam(
                                          widget.oservID,
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
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
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
                                widget.fazendaNome,
                                'Fazenda sem nome',
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
                            Text(
                              _model.textoInicioEFimDeContorno,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFFF8F8F8),
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1.0, 1.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 16.0, 16.0),
                        child: ClipOval(
                          child: Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              shape: BoxShape.circle,
                            ),
                            child: FFButtonWidget(
                              onPressed: () async {
                                FFAppState().update(() {});
                                setState(() {
                                  _model.ativo = !_model.ativo;
                                  _model.textoInicioEFimDeContorno =
                                      'Contorno em andamento.';
                                });
                                FFAppState().update(() {});
                              },
                              text: '',
                              icon: Icon(
                                Icons.format_shapes,
                                size: 35.0,
                              ),
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: double.infinity,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsets.all(0.0),
                                color: FlutterFlowTheme.of(context).primary,
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

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pesquisa_avanadabtn_model.dart';
export 'pesquisa_avanadabtn_model.dart';

class PesquisaAvanadabtnWidget extends StatefulWidget {
  const PesquisaAvanadabtnWidget({super.key});

  @override
  State<PesquisaAvanadabtnWidget> createState() =>
      _PesquisaAvanadabtnWidgetState();
}

class _PesquisaAvanadabtnWidgetState extends State<PesquisaAvanadabtnWidget> {
  late PesquisaAvanadabtnModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PesquisaAvanadabtnModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: 370.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Color(0x3B1D2429),
            offset: Offset(0.0, -3.0),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pesquisar por...',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Outfit',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 36.0,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cliente',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Switch.adaptive(
                    value: _model.switch1Value ??=
                        FFAppState().qualSwitchEstaAtivo == 1 ? true : false,
                    onChanged: (newValue) async {
                      setState(() => _model.switch1Value = newValue!);
                      if (newValue!) {
                        setState(() {
                          _model.switch4Value = false;
                        });
                        setState(() {
                          _model.switch3Value = false;
                        });
                        setState(() {
                          _model.switch2Value = false;
                        });
                        setState(() {
                          _model.switch5Value = false;
                        });
                        setState(() {
                          FFAppState().JsonPathPesquisaAvancada = 'oserv_id_os';
                          FFAppState().qualSwitchEstaAtivo = 1;
                        });
                      }
                    },
                    activeColor: FlutterFlowTheme.of(context).primary,
                    activeTrackColor: Color(0x4B00736D),
                    inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
                    inactiveThumbColor:
                        FlutterFlowTheme.of(context).secondaryText,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fazenda',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Switch.adaptive(
                    value: _model.switch2Value ??=
                        FFAppState().qualSwitchEstaAtivo == 2 ? true : false,
                    onChanged: (newValue) async {
                      setState(() => _model.switch2Value = newValue!);
                      if (newValue!) {
                        setState(() {
                          _model.switch4Value = false;
                        });
                        setState(() {
                          _model.switch3Value = false;
                        });
                        setState(() {
                          _model.switch1Value = false;
                        });
                        setState(() {
                          _model.switch5Value = false;
                        });
                        setState(() {
                          FFAppState().qualSwitchEstaAtivo = 2;
                          FFAppState().JsonPathPesquisaAvancada = 'oserv_id_os';
                        });
                      }
                    },
                    activeColor: FlutterFlowTheme.of(context).primary,
                    activeTrackColor: Color(0x4B00736D),
                    inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
                    inactiveThumbColor:
                        FlutterFlowTheme.of(context).secondaryText,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tipo de serviço',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Switch.adaptive(
                    value: _model.switch3Value ??=
                        FFAppState().qualSwitchEstaAtivo == 3 ? true : false,
                    onChanged: (newValue) async {
                      setState(() => _model.switch3Value = newValue!);
                      if (newValue!) {
                        setState(() {
                          _model.switch4Value = false;
                        });
                        setState(() {
                          _model.switch1Value = false;
                        });
                        setState(() {
                          _model.switch2Value = false;
                        });
                        setState(() {
                          _model.switch5Value = false;
                        });
                        setState(() {
                          FFAppState().JsonPathPesquisaAvancada =
                              'oserv_id_serv';
                          FFAppState().qualSwitchEstaAtivo = 3;
                        });
                      }
                    },
                    activeColor: FlutterFlowTheme.of(context).primary,
                    activeTrackColor: Color(0x4B00736D),
                    inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
                    inactiveThumbColor:
                        FlutterFlowTheme.of(context).secondaryText,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'N° OS',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Switch.adaptive(
                    value: _model.switch4Value ??=
                        FFAppState().qualSwitchEstaAtivo == 4 ? true : false,
                    onChanged: (newValue) async {
                      setState(() => _model.switch4Value = newValue!);
                      if (newValue!) {
                        setState(() {
                          _model.switch1Value = false;
                        });
                        setState(() {
                          _model.switch3Value = false;
                        });
                        setState(() {
                          _model.switch2Value = false;
                        });
                        setState(() {
                          _model.switch5Value = false;
                        });
                        setState(() {
                          FFAppState().JsonPathPesquisaAvancada = 'oserv_id_os';
                          FFAppState().qualSwitchEstaAtivo = 4;
                        });
                      }
                    },
                    activeColor: FlutterFlowTheme.of(context).primary,
                    activeTrackColor: Color(0x4B00736D),
                    inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
                    inactiveThumbColor:
                        FlutterFlowTheme.of(context).secondaryText,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Período',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Switch.adaptive(
                    value: _model.switch5Value ??=
                        FFAppState().qualSwitchEstaAtivo == 5 ? true : false,
                    onChanged: (newValue) async {
                      setState(() => _model.switch5Value = newValue!);
                      if (newValue!) {
                        setState(() {
                          _model.switch1Value = false;
                        });
                        setState(() {
                          _model.switch3Value = false;
                        });
                        setState(() {
                          _model.switch2Value = false;
                        });
                        setState(() {
                          _model.switch4Value = false;
                        });
                        setState(() {
                          FFAppState().qualSwitchEstaAtivo = 5;
                        });
                      }
                    },
                    activeColor: FlutterFlowTheme.of(context).primary,
                    activeTrackColor: Color(0x4B00736D),
                    inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
                    inactiveThumbColor:
                        FlutterFlowTheme.of(context).secondaryText,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 60.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

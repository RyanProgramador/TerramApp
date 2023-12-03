import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pesquisa_avanadabtn_model.dart';
export 'pesquisa_avanadabtn_model.dart';

class PesquisaAvanadabtnWidget extends StatefulWidget {
  const PesquisaAvanadabtnWidget({Key? key}) : super(key: key);

  @override
  _PesquisaAvanadabtnWidgetState createState() =>
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
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pesquisar por',
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
                    value: _model.switchValue1 ??= false,
                    onChanged: (newValue) async {
                      setState(() => _model.switchValue1 = newValue!);
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
                    value: _model.switchValue2 ??= false,
                    onChanged: (newValue) async {
                      setState(() => _model.switchValue2 = newValue!);
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
                    value: _model.switchValue3 ??= false,
                    onChanged: (newValue) async {
                      setState(() => _model.switchValue3 = newValue!);
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
                    value: _model.switchValue4 ??= false,
                    onChanged: (newValue) async {
                      setState(() => _model.switchValue4 = newValue!);
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
              height: 100.0,
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

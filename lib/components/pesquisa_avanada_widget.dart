import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pesquisa_avanada_model.dart';
export 'pesquisa_avanada_model.dart';

class PesquisaAvanadaWidget extends StatefulWidget {
  const PesquisaAvanadaWidget({super.key});

  @override
  State<PesquisaAvanadaWidget> createState() => _PesquisaAvanadaWidgetState();
}

class _PesquisaAvanadaWidgetState extends State<PesquisaAvanadaWidget> {
  late PesquisaAvanadaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PesquisaAvanadaModel());
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
                  'Pesquisa avançada',
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
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Cliente',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Color(0x00F3F3F3),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: FlutterFlowDropDown<String>(
                  controller: _model.dropDownValueController ??=
                      FormFieldController<String>(
                    _model.dropDownValue ??= '',
                  ),
                  options: List<String>.from(FFAppState()
                      .trOrdemServicos
                      .map((e) => getJsonField(
                            e,
                            r'''$.os_id''',
                          ))
                      .toList()
                      .map((e) => e.toString())
                      .toList()),
                  optionLabels: FFAppState()
                      .trEmpresas
                      .map((e) => getJsonField(
                            e,
                            r'''$.emp_nome''',
                          ))
                      .toList()
                      .map((e) => e.toString())
                      .toList(),
                  onChanged: (val) =>
                      setState(() => _model.dropDownValue = val),
                  width: 300.0,
                  height: 50.0,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium,
                  hintText: 'Selecione...',
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  elevation: 0.0,
                  borderColor: Color(0x00E0E3E7),
                  borderWidth: 0.0,
                  borderRadius: 0.0,
                  margin: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                  isSearchable: false,
                  isMultiSelect: false,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 32.0,
                    ),
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
              child: Builder(
                builder: (context) {
                  final trOsServiosSortList = functions
                          .sortListJson(
                              'oserv_id_os',
                              true,
                              FFAppState().trOsServicos.toList(),
                              _model.dropDownValue)
                          ?.toList() ??
                      [];
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(trOsServiosSortList.length,
                        (trOsServiosSortListIndex) {
                      final trOsServiosSortListItem =
                          trOsServiosSortList[trOsServiosSortListIndex];
                      return Text(
                        getJsonField(
                          trOsServiosSortListItem,
                          r'''$.oserv_id''',
                        ).toString(),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

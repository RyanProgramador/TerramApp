import '/components/iniciar_deslocamento_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'iniciar_deslocamento_tela_model.dart';
export 'iniciar_deslocamento_tela_model.dart';

class IniciarDeslocamentoTelaWidget extends StatefulWidget {
  const IniciarDeslocamentoTelaWidget({
    super.key,
    required this.etapade,
    required this.fazendaNome,
    required this.latlngFaz,
    required this.cidadeFaz,
    required this.estadoFaz,
    required this.observacao,
    required this.tecnicoid,
    required this.servicoid,
    required this.data,
    required this.hora,
    required this.jsonServico,
    required this.deslocamentoAtualFinalizado,
    required this.polylinhaQueVemDoMenuInicial,
    required this.fazid,
    required this.autoAuditoria,
    required this.autoAuditoriaQuantidadePontos,
  });

  final String? etapade;
  final String? fazendaNome;
  final LatLng? latlngFaz;
  final String? cidadeFaz;
  final String? estadoFaz;
  final String? observacao;
  final String? tecnicoid;
  final String? servicoid;
  final String? data;
  final String? hora;
  final dynamic jsonServico;
  final bool? deslocamentoAtualFinalizado;
  final String? polylinhaQueVemDoMenuInicial;
  final String? fazid;
  final bool? autoAuditoria;
  final int? autoAuditoriaQuantidadePontos;

  @override
  State<IniciarDeslocamentoTelaWidget> createState() =>
      _IniciarDeslocamentoTelaWidgetState();
}

class _IniciarDeslocamentoTelaWidgetState
    extends State<IniciarDeslocamentoTelaWidget> {
  late IniciarDeslocamentoTelaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IniciarDeslocamentoTelaModel());
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
          child: wrapWithModel(
            model: _model.iniciarDeslocamentoModel,
            updateCallback: () => setState(() {}),
            child: IniciarDeslocamentoWidget(
              etapade: widget.etapade!,
              fazendaNome: widget.fazendaNome!,
              cidadeFaz: widget.cidadeFaz!,
              estadoFaz: widget.estadoFaz!,
              observacao: widget.observacao!,
              tecnicoId: widget.tecnicoid!,
              servicoId: widget.servicoid!,
              data: widget.data!,
              hora: widget.hora!,
              deslocamentoAtualFinzalizado: widget.deslocamentoAtualFinalizado!,
              polylinhaQueVemDoMenuInicial: widget.polylinhaQueVemDoMenuInicial,
              fazid: widget.fazid!,
              autoAuditoria: widget.autoAuditoria!,
              autoAuditoriaQuantidadePontos:
                  widget.autoAuditoriaQuantidadePontos!,
              latlngFaz: widget.latlngFaz!,
              jsonServico: widget.jsonServico!,
            ),
          ),
        ),
      ),
    );
  }
}

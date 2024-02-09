import '/backend/api_requests/api_calls.dart';
import '/components/motivo_pausa_widget.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';
import 'iniciar_deslocamento_model.dart';
export 'iniciar_deslocamento_model.dart';

class IniciarDeslocamentoWidget extends StatefulWidget {
  const IniciarDeslocamentoWidget({
    super.key,
    required this.etapade,
    required this.fazendaNome,
    required this.latlngFaz,
    required this.cidadeFaz,
    required this.estadoFaz,
    required this.observacao,
    required this.tecnicoId,
    required this.servicoId,
    required this.data,
    required this.hora,
    required this.jsonServico,
    required this.deslocamentoAtualFinzalizado,
    this.polylinhaQueVemDoMenuInicial,
    String? fazid,
    bool? autoAuditoria,
    required this.autoAuditoriaQuantidadePontos,
  })  : this.fazid = fazid ?? '1',
        this.autoAuditoria = autoAuditoria ?? false;

  final String? etapade;
  final String? fazendaNome;
  final LatLng? latlngFaz;
  final String? cidadeFaz;
  final String? estadoFaz;
  final String? observacao;
  final String? tecnicoId;
  final String? servicoId;
  final String? data;
  final String? hora;
  final dynamic jsonServico;
  final bool? deslocamentoAtualFinzalizado;
  final String? polylinhaQueVemDoMenuInicial;
  final String fazid;
  final bool autoAuditoria;
  final int? autoAuditoriaQuantidadePontos;

  @override
  State<IniciarDeslocamentoWidget> createState() =>
      _IniciarDeslocamentoWidgetState();
}

class _IniciarDeslocamentoWidgetState extends State<IniciarDeslocamentoWidget> {
  late IniciarDeslocamentoModel _model;

  LatLng? currentUserLocationValue;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IniciarDeslocamentoModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.temInternetOnLoadInicioOs = await actions.temInternet();
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        _model.temNet = _model.temInternetOnLoadInicioOs;
      });
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: FutureBuilder<ApiCallResponse>(
        future: ApiRotasDirectionsCall.call(
          origem: functions.latLngToStr(currentUserLocationValue),
          destino: functions.latLngToStr(widget.latlngFaz),
          key: 'AIzaSyDpk1wIZmA1OTS57D_cB13BD01zqrTiQNI',
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            );
          }
          final cardActionsApiRotasDirectionsResponse = snapshot.data!;
          return InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              currentUserLocationValue = await getCurrentUserLocation(
                  defaultLocation: LatLng(0.0, 0.0));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: 770.0,
                ),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7.0,
                      color: FlutterFlowTheme.of(context).primary,
                      offset: Offset(3.0, 3.0),
                      spreadRadius: 1.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0),
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(0.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0),
                                topLeft: Radius.circular(0.0),
                                topRight: Radius.circular(0.0),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Builder(builder: (context) {
                                  final _googleMapMarker = widget.latlngFaz;
                                  return FlutterFlowGoogleMap(
                                    controller: _model.googleMapsController,
                                    onCameraIdle: (latLng) =>
                                        _model.googleMapsCenter = latLng,
                                    initialLocation: _model.googleMapsCenter ??=
                                        widget.latlngFaz!,
                                    markers: [
                                      if (_googleMapMarker != null)
                                        FlutterFlowMarker(
                                          _googleMapMarker.serialize(),
                                          _googleMapMarker,
                                        ),
                                    ],
                                    markerColor: GoogleMarkerColor.red,
                                    mapType: MapType.hybrid,
                                    style: GoogleMapStyle.standard,
                                    initialZoom: 14.0,
                                    allowInteraction: false,
                                    allowZoom: false,
                                    showZoomControls: false,
                                    showLocation: false,
                                    showCompass: false,
                                    showMapToolbar: false,
                                    showTraffic: false,
                                    centerMapOnMarkerTap: false,
                                  );
                                }),
                                Align(
                                  alignment: AlignmentDirectional(-0.89, -0.26),
                                  child: PointerInterceptor(
                                    intercepting: isWeb,
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        var confirmDialogResponse =
                                            await showDialog<bool>(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Você quer sair do serviço e voltar à tela inicial?'),
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

                                        context.goNamed(
                                          'blankRedirecona',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 0),
                                            ),
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.arrow_back_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        size: 50.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    widget.fazendaNome,
                                    'erro404',
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 3,
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      widget.estadoFaz!,
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        widget.cidadeFaz!,
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 8.0, 16.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Data',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                      ),
                                      Text(
                                        widget.data!,
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hora',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                      ),
                                      Text(
                                        widget.hora!,
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Serviço',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                      ),
                                      Text(
                                        widget.etapade!,
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
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
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Observação',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            widget.observacao!,
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Stack(
                          children: [
                            if ((_model.temInternetOnLoadInicioOs == true) ||
                                _model.temNet!)
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: custom_widgets.MapsRoutes(
                                    width: double.infinity,
                                    height: double.infinity,
                                    json2: functions
                                        .jsonToStr(ApiRotasDirectionsCall.tudo(
                                      cardActionsApiRotasDirectionsResponse
                                          .jsonBody,
                                    )),
                                    coordenadasIniciais:
                                        currentUserLocationValue,
                                    coordenadasFinais: widget.latlngFaz!,
                                    stringDoRotas:
                                        widget.polylinhaQueVemDoMenuInicial,
                                  ),
                                ),
                              ),
                            if ((_model.temInternetOnLoadInicioOs == false) ||
                                !_model.temNet!)
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: custom_widgets.MapsOffline(
                                    width: double.infinity,
                                    height: double.infinity,
                                    coordenadasIniciais:
                                        currentUserLocationValue,
                                    coordenadasFinais: widget.latlngFaz!,
                                  ),
                                ),
                              ),
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    _model.temNetRefrash =
                                        await actions.temInternet();
                                    setState(() {
                                      _model.temNet = _model.temNetRefrash;
                                    });
                                    _model.updatePage(() {});
                                    setState(() {});

                                    setState(() {});
                                  },
                                  text: '',
                                  icon: Icon(
                                    Icons.refresh_sharp,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                  options: FFButtonOptions(
                                    width: 50.0,
                                    height: 50.0,
                                    padding: EdgeInsets.all(0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                          fontSize: 1.0,
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
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 4.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if ((widget.jsonServico ==
                                        FFAppState().trOsServicoEmAndamento) &&
                                    (FFAppState().DeslocamentoPausado == false))
                                  Opacity(
                                    opacity: 0.0,
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        setState(() {
                                          FFAppState().DeslocamentoPausado =
                                              true;
                                          FFAppState().trDesloacamentoIniciado =
                                              true;
                                        });
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
                                                height: 370.0,
                                                child: MotivoPausaWidget(),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                      text: 'Pausar',
                                      icon: Icon(
                                        Icons.edit_location_alt_sharp,
                                        size: 15.0,
                                      ),
                                      options: FFButtonOptions(
                                        width: 5.0,
                                        height: 52.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                  ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    currentUserLocationValue =
                                        await getCurrentUserLocation(
                                            defaultLocation: LatLng(0.0, 0.0));
                                    var _shouldSetState = false;
                                    _model.temInternetAntesDoDeslocamento =
                                        await actions.temInternet();
                                    _shouldSetState = true;
                                    if (_model
                                        .temInternetAntesDoDeslocamento!) {
                                      if (widget
                                          .deslocamentoAtualFinzalizado!) {
                                        var confirmDialogResponse =
                                            await showDialog<bool>(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          'Você deseja retornar ao ponto de origem?'),
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
                                        if (confirmDialogResponse) {
                                          _model.porfavorFuncioneComRotaInvertida =
                                              await ApiRotasPolylinesCall.call(
                                            latitudeOrigem:
                                                functions.separadorLatDeLng(
                                                    true,
                                                    functions.latLngToStr(
                                                        widget.latlngFaz)),
                                            longitudeOrigem:
                                                functions.separadorLatDeLng(
                                                    false,
                                                    functions.latLngToStr(
                                                        widget.latlngFaz)),
                                            latitudeDestino:
                                                functions.separadorLatDeLng(
                                                    true,
                                                    functions.latLngToStr(
                                                        currentUserLocationValue)),
                                            longitudeDestonp:
                                                functions.separadorLatDeLng(
                                                    false,
                                                    functions.latLngToStr(
                                                        currentUserLocationValue)),
                                            key:
                                                'AIzaSyDpk1wIZmA1OTS57D_cB13BD01zqrTiQNI',
                                          );
                                          _shouldSetState = true;

                                          context.pushNamed(
                                            'GpsTecToFazenda',
                                            queryParameters: {
                                              'jsonServico': serializeParam(
                                                widget.jsonServico,
                                                ParamType.JSON,
                                              ),
                                              'tecnicoId': serializeParam(
                                                widget.tecnicoId,
                                                ParamType.String,
                                              ),
                                              'servicoId': serializeParam(
                                                widget.servicoId,
                                                ParamType.String,
                                              ),
                                              'fazNome': serializeParam(
                                                widget.fazendaNome,
                                                ParamType.String,
                                              ),
                                              'latlngFaz': serializeParam(
                                                widget.latlngFaz,
                                                ParamType.LatLng,
                                              ),
                                              'retornoAPI': serializeParam(
                                                functions.jsonToStr(
                                                    ApiRotasDirectionsCall.tudo(
                                                  cardActionsApiRotasDirectionsResponse
                                                      .jsonBody,
                                                )),
                                                ParamType.String,
                                              ),
                                              'retornopolylines':
                                                  serializeParam(
                                                functions.ligaoDeNome(
                                                    FFAppState()
                                                        .rotainversa
                                                        .toList(),
                                                    'osserv_id',
                                                    'rota_inversa',
                                                    widget.servicoId),
                                                ParamType.String,
                                              ),
                                              'comRota': serializeParam(
                                                true,
                                                ParamType.bool,
                                              ),
                                              'rotaInversa': serializeParam(
                                                true,
                                                ParamType.bool,
                                              ),
                                              'rotaInversaString':
                                                  serializeParam(
                                                functions.ligaoDeNome(
                                                    FFAppState()
                                                        .rotainversa
                                                        .toList(),
                                                    'osserv_id',
                                                    'rota_inversa',
                                                    widget.servicoId),
                                                ParamType.String,
                                              ),
                                              'cidadeFaz': serializeParam(
                                                widget.cidadeFaz,
                                                ParamType.String,
                                              ),
                                              'estadoFaz': serializeParam(
                                                widget.estadoFaz,
                                                ParamType.String,
                                              ),
                                              'observacao': serializeParam(
                                                widget.observacao,
                                                ParamType.String,
                                              ),
                                              'data': serializeParam(
                                                widget.data,
                                                ParamType.String,
                                              ),
                                              'horar': serializeParam(
                                                widget.hora,
                                                ParamType.String,
                                              ),
                                              'fazid': serializeParam(
                                                widget.fazid,
                                                ParamType.String,
                                              ),
                                              'autoAuditoria': serializeParam(
                                                widget.autoAuditoria,
                                                ParamType.bool,
                                              ),
                                              'autoAuditoriaQuantidadePontos':
                                                  serializeParam(
                                                widget
                                                    .autoAuditoriaQuantidadePontos,
                                                ParamType.int,
                                              ),
                                              'etapaDe': serializeParam(
                                                widget.etapade,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );

                                          FFAppState().update(() {});
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        } else {
                                          _model.porfavorFuncioneSemRota =
                                              await ApiRotasPolylinesCall.call(
                                            latitudeOrigem:
                                                functions.separadorLatDeLng(
                                                    true,
                                                    functions.latLngToStr(
                                                        currentUserLocationValue)),
                                            longitudeOrigem:
                                                functions.separadorLatDeLng(
                                                    false,
                                                    functions.latLngToStr(
                                                        currentUserLocationValue)),
                                            latitudeDestino:
                                                functions.separadorLatDeLng(
                                                    true,
                                                    functions.latLngToStr(
                                                        widget.latlngFaz)),
                                            longitudeDestonp:
                                                functions.separadorLatDeLng(
                                                    false,
                                                    functions.latLngToStr(
                                                        widget.latlngFaz)),
                                            key:
                                                'AIzaSyDpk1wIZmA1OTS57D_cB13BD01zqrTiQNI',
                                          );
                                          _shouldSetState = true;

                                          context.pushNamed(
                                            'GpsTecToFazenda',
                                            queryParameters: {
                                              'jsonServico': serializeParam(
                                                widget.jsonServico,
                                                ParamType.JSON,
                                              ),
                                              'tecnicoId': serializeParam(
                                                widget.tecnicoId,
                                                ParamType.String,
                                              ),
                                              'servicoId': serializeParam(
                                                widget.servicoId,
                                                ParamType.String,
                                              ),
                                              'fazNome': serializeParam(
                                                widget.fazendaNome,
                                                ParamType.String,
                                              ),
                                              'latlngFaz': serializeParam(
                                                widget.latlngFaz,
                                                ParamType.LatLng,
                                              ),
                                              'retornoAPI': serializeParam(
                                                functions.jsonToStr(
                                                    ApiRotasDirectionsCall.tudo(
                                                  cardActionsApiRotasDirectionsResponse
                                                      .jsonBody,
                                                )),
                                                ParamType.String,
                                              ),
                                              'retornopolylines':
                                                  serializeParam(
                                                ApiRotasPolylinesCall
                                                    .criptografadapolyline(
                                                  (_model.porfavorFuncioneSemRota
                                                          ?.jsonBody ??
                                                      ''),
                                                ),
                                                ParamType.String,
                                              ),
                                              'comRota': serializeParam(
                                                false,
                                                ParamType.bool,
                                              ),
                                              'rotaInversa': serializeParam(
                                                true,
                                                ParamType.bool,
                                              ),
                                              'rotaInversaString':
                                                  serializeParam(
                                                '',
                                                ParamType.String,
                                              ),
                                              'cidadeFaz': serializeParam(
                                                widget.cidadeFaz,
                                                ParamType.String,
                                              ),
                                              'estadoFaz': serializeParam(
                                                widget.estadoFaz,
                                                ParamType.String,
                                              ),
                                              'observacao': serializeParam(
                                                widget.observacao,
                                                ParamType.String,
                                              ),
                                              'data': serializeParam(
                                                widget.data,
                                                ParamType.String,
                                              ),
                                              'horar': serializeParam(
                                                widget.hora,
                                                ParamType.String,
                                              ),
                                              'fazid': serializeParam(
                                                widget.fazid,
                                                ParamType.String,
                                              ),
                                              'autoAuditoria': serializeParam(
                                                widget.autoAuditoria,
                                                ParamType.bool,
                                              ),
                                              'autoAuditoriaQuantidadePontos':
                                                  serializeParam(
                                                widget
                                                    .autoAuditoriaQuantidadePontos,
                                                ParamType.int,
                                              ),
                                              'etapaDe': serializeParam(
                                                widget.etapade,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );

                                          FFAppState().update(() {});
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        }
                                      } else {
                                        var confirmDialogResponse =
                                            await showDialog<bool>(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          'Você se deslocará direto para a fazenda?'),
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
                                        if (confirmDialogResponse) {
                                          _model.rotaInvertida =
                                              await ApiRotasPolylinesCall.call(
                                            latitudeOrigem:
                                                functions.separadorLatDeLng(
                                                    true,
                                                    functions.latLngToStr(
                                                        widget.latlngFaz)),
                                            longitudeOrigem:
                                                functions.separadorLatDeLng(
                                                    false,
                                                    functions.latLngToStr(
                                                        widget.latlngFaz)),
                                            latitudeDestino:
                                                functions.separadorLatDeLng(
                                                    true,
                                                    functions.latLngToStr(
                                                        currentUserLocationValue)),
                                            longitudeDestonp:
                                                functions.separadorLatDeLng(
                                                    false,
                                                    functions.latLngToStr(
                                                        currentUserLocationValue)),
                                            key:
                                                'AIzaSyDpk1wIZmA1OTS57D_cB13BD01zqrTiQNI',
                                          );
                                          _shouldSetState = true;
                                          await actions.gravaRotaInversa(
                                            widget.servicoId,
                                            ApiRotasPolylinesCall
                                                .criptografadapolyline(
                                              (_model.rotaInvertida?.jsonBody ??
                                                  ''),
                                            ),
                                          );
                                          _model.porfavorFuncioneTecAteFaz =
                                              await ApiRotasPolylinesCall.call(
                                            latitudeOrigem:
                                                functions.separadorLatDeLng(
                                                    true,
                                                    functions.latLngToStr(
                                                        currentUserLocationValue)),
                                            longitudeOrigem:
                                                functions.separadorLatDeLng(
                                                    false,
                                                    functions.latLngToStr(
                                                        currentUserLocationValue)),
                                            latitudeDestino:
                                                functions.separadorLatDeLng(
                                                    true,
                                                    functions.latLngToStr(
                                                        widget.latlngFaz)),
                                            longitudeDestonp:
                                                functions.separadorLatDeLng(
                                                    false,
                                                    functions.latLngToStr(
                                                        widget.latlngFaz)),
                                            key:
                                                'AIzaSyDpk1wIZmA1OTS57D_cB13BD01zqrTiQNI',
                                          );
                                          _shouldSetState = true;
                                          setState(() {
                                            FFAppState().rotainversa =
                                                FFAppState()
                                                    .rotainversa
                                                    .toList()
                                                    .cast<dynamic>();
                                          });

                                          context.pushNamed(
                                            'GpsTecToFazenda',
                                            queryParameters: {
                                              'jsonServico': serializeParam(
                                                widget.jsonServico,
                                                ParamType.JSON,
                                              ),
                                              'tecnicoId': serializeParam(
                                                widget.tecnicoId,
                                                ParamType.String,
                                              ),
                                              'servicoId': serializeParam(
                                                widget.servicoId,
                                                ParamType.String,
                                              ),
                                              'fazNome': serializeParam(
                                                widget.fazendaNome,
                                                ParamType.String,
                                              ),
                                              'latlngFaz': serializeParam(
                                                widget.latlngFaz,
                                                ParamType.LatLng,
                                              ),
                                              'retornoAPI': serializeParam(
                                                functions.jsonToStr(
                                                    ApiRotasDirectionsCall.tudo(
                                                  cardActionsApiRotasDirectionsResponse
                                                      .jsonBody,
                                                )),
                                                ParamType.String,
                                              ),
                                              'retornopolylines':
                                                  serializeParam(
                                                ApiRotasPolylinesCall
                                                    .criptografadapolyline(
                                                  (_model.porfavorFuncioneTecAteFaz
                                                          ?.jsonBody ??
                                                      ''),
                                                ),
                                                ParamType.String,
                                              ),
                                              'comRota': serializeParam(
                                                true,
                                                ParamType.bool,
                                              ),
                                              'rotaInversa': serializeParam(
                                                false,
                                                ParamType.bool,
                                              ),
                                              'rotaInversaString':
                                                  serializeParam(
                                                '',
                                                ParamType.String,
                                              ),
                                              'cidadeFaz': serializeParam(
                                                widget.cidadeFaz,
                                                ParamType.String,
                                              ),
                                              'estadoFaz': serializeParam(
                                                widget.estadoFaz,
                                                ParamType.String,
                                              ),
                                              'observacao': serializeParam(
                                                widget.observacao,
                                                ParamType.String,
                                              ),
                                              'data': serializeParam(
                                                widget.data,
                                                ParamType.String,
                                              ),
                                              'horar': serializeParam(
                                                widget.hora,
                                                ParamType.String,
                                              ),
                                              'fazid': serializeParam(
                                                widget.fazid,
                                                ParamType.String,
                                              ),
                                              'autoAuditoria': serializeParam(
                                                widget.autoAuditoria,
                                                ParamType.bool,
                                              ),
                                              'autoAuditoriaQuantidadePontos':
                                                  serializeParam(
                                                widget
                                                    .autoAuditoriaQuantidadePontos,
                                                ParamType.int,
                                              ),
                                              'etapaDe': serializeParam(
                                                widget.etapade,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );

                                          FFAppState().update(() {});
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        } else {
                                          context.pushNamed(
                                            'GpsTecToFazenda',
                                            queryParameters: {
                                              'jsonServico': serializeParam(
                                                widget.jsonServico,
                                                ParamType.JSON,
                                              ),
                                              'tecnicoId': serializeParam(
                                                widget.tecnicoId,
                                                ParamType.String,
                                              ),
                                              'servicoId': serializeParam(
                                                widget.servicoId,
                                                ParamType.String,
                                              ),
                                              'fazNome': serializeParam(
                                                widget.fazendaNome,
                                                ParamType.String,
                                              ),
                                              'latlngFaz': serializeParam(
                                                widget.latlngFaz,
                                                ParamType.LatLng,
                                              ),
                                              'retornoAPI': serializeParam(
                                                functions.jsonToStr(
                                                    ApiRotasDirectionsCall.tudo(
                                                  cardActionsApiRotasDirectionsResponse
                                                      .jsonBody,
                                                )),
                                                ParamType.String,
                                              ),
                                              'retornopolylines':
                                                  serializeParam(
                                                '',
                                                ParamType.String,
                                              ),
                                              'comRota': serializeParam(
                                                false,
                                                ParamType.bool,
                                              ),
                                              'rotaInversa': serializeParam(
                                                false,
                                                ParamType.bool,
                                              ),
                                              'rotaInversaString':
                                                  serializeParam(
                                                '',
                                                ParamType.String,
                                              ),
                                              'cidadeFaz': serializeParam(
                                                widget.cidadeFaz,
                                                ParamType.String,
                                              ),
                                              'estadoFaz': serializeParam(
                                                widget.estadoFaz,
                                                ParamType.String,
                                              ),
                                              'observacao': serializeParam(
                                                widget.observacao,
                                                ParamType.String,
                                              ),
                                              'data': serializeParam(
                                                widget.data,
                                                ParamType.String,
                                              ),
                                              'horar': serializeParam(
                                                widget.hora,
                                                ParamType.String,
                                              ),
                                              'fazid': serializeParam(
                                                widget.fazid,
                                                ParamType.String,
                                              ),
                                              'autoAuditoria': serializeParam(
                                                widget.autoAuditoria,
                                                ParamType.bool,
                                              ),
                                              'autoAuditoriaQuantidadePontos':
                                                  serializeParam(
                                                widget
                                                    .autoAuditoriaQuantidadePontos,
                                                ParamType.int,
                                              ),
                                              'etapaDe': serializeParam(
                                                widget.etapade,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );

                                          FFAppState().update(() {});
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        }
                                      }
                                    } else {
                                      if (widget
                                          .deslocamentoAtualFinzalizado!) {
                                        var confirmDialogResponse =
                                            await showDialog<bool>(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          'Você deseja retornar ao ponto de origem?'),
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
                                        if (confirmDialogResponse) {
                                          context.pushNamed(
                                            'GpsTecToFazenda',
                                            queryParameters: {
                                              'jsonServico': serializeParam(
                                                widget.jsonServico,
                                                ParamType.JSON,
                                              ),
                                              'tecnicoId': serializeParam(
                                                widget.tecnicoId,
                                                ParamType.String,
                                              ),
                                              'servicoId': serializeParam(
                                                widget.servicoId,
                                                ParamType.String,
                                              ),
                                              'fazNome': serializeParam(
                                                widget.fazendaNome,
                                                ParamType.String,
                                              ),
                                              'latlngFaz': serializeParam(
                                                widget.latlngFaz,
                                                ParamType.LatLng,
                                              ),
                                              'retornoAPI': serializeParam(
                                                functions.jsonToStr(
                                                    ApiRotasDirectionsCall.tudo(
                                                  cardActionsApiRotasDirectionsResponse
                                                      .jsonBody,
                                                )),
                                                ParamType.String,
                                              ),
                                              'retornopolylines':
                                                  serializeParam(
                                                functions.ligaoDeNome(
                                                    FFAppState()
                                                        .rotainversa
                                                        .toList(),
                                                    'osserv_id',
                                                    'rota_inversa',
                                                    widget.servicoId),
                                                ParamType.String,
                                              ),
                                              'comRota': serializeParam(
                                                true,
                                                ParamType.bool,
                                              ),
                                              'rotaInversa': serializeParam(
                                                true,
                                                ParamType.bool,
                                              ),
                                              'rotaInversaString':
                                                  serializeParam(
                                                functions.ligaoDeNome(
                                                    FFAppState()
                                                        .rotainversa
                                                        .toList(),
                                                    'osserv_id',
                                                    'rota_inversa',
                                                    widget.servicoId),
                                                ParamType.String,
                                              ),
                                              'cidadeFaz': serializeParam(
                                                widget.cidadeFaz,
                                                ParamType.String,
                                              ),
                                              'estadoFaz': serializeParam(
                                                widget.estadoFaz,
                                                ParamType.String,
                                              ),
                                              'observacao': serializeParam(
                                                widget.observacao,
                                                ParamType.String,
                                              ),
                                              'data': serializeParam(
                                                widget.data,
                                                ParamType.String,
                                              ),
                                              'horar': serializeParam(
                                                widget.hora,
                                                ParamType.String,
                                              ),
                                              'fazid': serializeParam(
                                                widget.fazid,
                                                ParamType.String,
                                              ),
                                              'autoAuditoria': serializeParam(
                                                widget.autoAuditoria,
                                                ParamType.bool,
                                              ),
                                              'autoAuditoriaQuantidadePontos':
                                                  serializeParam(
                                                widget
                                                    .autoAuditoriaQuantidadePontos,
                                                ParamType.int,
                                              ),
                                              'etapaDe': serializeParam(
                                                widget.etapade,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );

                                          FFAppState().update(() {});
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        } else {
                                          context.pushNamed(
                                            'GpsTecToFazenda',
                                            queryParameters: {
                                              'jsonServico': serializeParam(
                                                widget.jsonServico,
                                                ParamType.JSON,
                                              ),
                                              'tecnicoId': serializeParam(
                                                widget.tecnicoId,
                                                ParamType.String,
                                              ),
                                              'servicoId': serializeParam(
                                                widget.servicoId,
                                                ParamType.String,
                                              ),
                                              'fazNome': serializeParam(
                                                widget.fazendaNome,
                                                ParamType.String,
                                              ),
                                              'latlngFaz': serializeParam(
                                                widget.latlngFaz,
                                                ParamType.LatLng,
                                              ),
                                              'retornoAPI': serializeParam(
                                                functions.jsonToStr(
                                                    ApiRotasDirectionsCall.tudo(
                                                  cardActionsApiRotasDirectionsResponse
                                                      .jsonBody,
                                                )),
                                                ParamType.String,
                                              ),
                                              'retornopolylines':
                                                  serializeParam(
                                                '',
                                                ParamType.String,
                                              ),
                                              'comRota': serializeParam(
                                                false,
                                                ParamType.bool,
                                              ),
                                              'rotaInversa': serializeParam(
                                                true,
                                                ParamType.bool,
                                              ),
                                              'rotaInversaString':
                                                  serializeParam(
                                                '',
                                                ParamType.String,
                                              ),
                                              'cidadeFaz': serializeParam(
                                                widget.cidadeFaz,
                                                ParamType.String,
                                              ),
                                              'estadoFaz': serializeParam(
                                                widget.estadoFaz,
                                                ParamType.String,
                                              ),
                                              'observacao': serializeParam(
                                                widget.observacao,
                                                ParamType.String,
                                              ),
                                              'data': serializeParam(
                                                widget.data,
                                                ParamType.String,
                                              ),
                                              'horar': serializeParam(
                                                widget.hora,
                                                ParamType.String,
                                              ),
                                              'fazid': serializeParam(
                                                widget.fazid,
                                                ParamType.String,
                                              ),
                                              'autoAuditoria': serializeParam(
                                                widget.autoAuditoria,
                                                ParamType.bool,
                                              ),
                                              'autoAuditoriaQuantidadePontos':
                                                  serializeParam(
                                                widget
                                                    .autoAuditoriaQuantidadePontos,
                                                ParamType.int,
                                              ),
                                              'etapaDe': serializeParam(
                                                widget.etapade,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );

                                          FFAppState().update(() {});
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        }
                                      } else {
                                        context.pushNamed(
                                          'GpsTecToFazenda',
                                          queryParameters: {
                                            'jsonServico': serializeParam(
                                              widget.jsonServico,
                                              ParamType.JSON,
                                            ),
                                            'tecnicoId': serializeParam(
                                              widget.tecnicoId,
                                              ParamType.String,
                                            ),
                                            'servicoId': serializeParam(
                                              widget.servicoId,
                                              ParamType.String,
                                            ),
                                            'fazNome': serializeParam(
                                              widget.fazendaNome,
                                              ParamType.String,
                                            ),
                                            'latlngFaz': serializeParam(
                                              widget.latlngFaz,
                                              ParamType.LatLng,
                                            ),
                                            'retornoAPI': serializeParam(
                                              functions.jsonToStr(
                                                  ApiRotasDirectionsCall.tudo(
                                                cardActionsApiRotasDirectionsResponse
                                                    .jsonBody,
                                              )),
                                              ParamType.String,
                                            ),
                                            'retornopolylines': serializeParam(
                                              '',
                                              ParamType.String,
                                            ),
                                            'comRota': serializeParam(
                                              false,
                                              ParamType.bool,
                                            ),
                                            'rotaInversa': serializeParam(
                                              false,
                                              ParamType.bool,
                                            ),
                                            'rotaInversaString': serializeParam(
                                              '',
                                              ParamType.String,
                                            ),
                                            'cidadeFaz': serializeParam(
                                              widget.cidadeFaz,
                                              ParamType.String,
                                            ),
                                            'estadoFaz': serializeParam(
                                              widget.estadoFaz,
                                              ParamType.String,
                                            ),
                                            'observacao': serializeParam(
                                              widget.observacao,
                                              ParamType.String,
                                            ),
                                            'data': serializeParam(
                                              widget.data,
                                              ParamType.String,
                                            ),
                                            'horar': serializeParam(
                                              widget.hora,
                                              ParamType.String,
                                            ),
                                            'fazid': serializeParam(
                                              widget.fazid,
                                              ParamType.String,
                                            ),
                                            'autoAuditoria': serializeParam(
                                              widget.autoAuditoria,
                                              ParamType.bool,
                                            ),
                                            'autoAuditoriaQuantidadePontos':
                                                serializeParam(
                                              widget
                                                  .autoAuditoriaQuantidadePontos,
                                              ParamType.int,
                                            ),
                                            'etapaDe': serializeParam(
                                              widget.etapade,
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                        );

                                        FFAppState().update(() {});
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }
                                    }

                                    if (_shouldSetState) setState(() {});
                                  },
                                  text: FFAppState().DeslocamentoPausado &&
                                          FFAppState()
                                              .trDesloacamentoIniciado &&
                                          (getJsonField(
                                                widget.jsonServico,
                                                r'''$.oserv_id''',
                                              ) ==
                                              FFAppState()
                                                  .trOsServicoEmAndamento)
                                      ? 'Continuar'
                                      : 'Deslocamento',
                                  icon: FaIcon(
                                    FontAwesomeIcons.route,
                                    size: 18.0,
                                  ),
                                  options: FFButtonOptions(
                                    width: 160.0,
                                    height: 52.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        17.0, 0.0, 17.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                if (widget.deslocamentoAtualFinzalizado! &&
                                    (widget.etapade == 'Contorno'))
                                  FFButtonWidget(
                                    onPressed: () async {
                                      context.pushNamed(
                                        'ListaContornos',
                                        queryParameters: {
                                          'nomeFazenda': serializeParam(
                                            widget.fazendaNome,
                                            ParamType.String,
                                          ),
                                          'oservID': serializeParam(
                                            widget.servicoId,
                                            ParamType.String,
                                          ),
                                          'fazid': serializeParam(
                                            widget.fazid,
                                            ParamType.String,
                                          ),
                                          'fazlatlng': serializeParam(
                                            widget.latlngFaz,
                                            ParamType.LatLng,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    text:
                                        widget.deslocamentoAtualFinzalizado! &&
                                                (widget.etapade == 'Contorno')
                                            ? 'Contornar'
                                            : 'Ops!',
                                    icon: FaIcon(
                                      FontAwesomeIcons.route,
                                      size: 18.0,
                                    ),
                                    options: FFButtonOptions(
                                      width: 160.0,
                                      height: 52.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          17.0, 0.0, 17.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                if (widget.deslocamentoAtualFinzalizado! &&
                                    (widget.etapade == 'Coleta'))
                                  FFButtonWidget(
                                    onPressed: () async {
                                      context.pushNamed(
                                        'MedicaoColeta',
                                        queryParameters: {
                                          'fazNome': serializeParam(
                                            widget.fazendaNome,
                                            ParamType.String,
                                          ),
                                          'idContorno': serializeParam(
                                            widget.servicoId,
                                            ParamType.String,
                                          ),
                                          'autoAuditoria': serializeParam(
                                            widget.autoAuditoria,
                                            ParamType.bool,
                                          ),
                                          'quantosPontosAutoAuditoria':
                                              serializeParam(
                                            widget
                                                .autoAuditoriaQuantidadePontos,
                                            ParamType.int,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    text:
                                        widget.deslocamentoAtualFinzalizado! &&
                                                (widget.etapade == 'Coleta')
                                            ? 'Coletar'
                                            : 'Ops!',
                                    icon: FaIcon(
                                      FontAwesomeIcons.vials,
                                      size: 18.0,
                                    ),
                                    options: FFButtonOptions(
                                      width: 160.0,
                                      height: 52.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          17.0, 0.0, 17.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                if (!widget.deslocamentoAtualFinzalizado!)
                                  Opacity(
                                    opacity: 0.0,
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        await Future.delayed(
                                            const Duration(milliseconds: 1000));
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Finalizado com sucesso!'),
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
                                        Navigator.pop(context);
                                      },
                                      text: 'Finalizar',
                                      icon: Icon(
                                        Icons.location_off_sharp,
                                        size: 15.0,
                                      ),
                                      options: FFButtonOptions(
                                        width: 5.0,
                                        height: 52.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.white,
                                            ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1.0,
                        height: 1.0,
                        child: custom_widgets.DesejaRealmenteVoltar(
                          width: 1.0,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

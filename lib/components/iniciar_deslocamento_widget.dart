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
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';
import 'iniciar_deslocamento_model.dart';
export 'iniciar_deslocamento_model.dart';

class IniciarDeslocamentoWidget extends StatefulWidget {
  const IniciarDeslocamentoWidget({
    Key? key,
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
  }) : super(key: key);

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

  @override
  _IniciarDeslocamentoWidgetState createState() =>
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
      alignment: AlignmentDirectional(0.00, 0.00),
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
          return ClipRRect(
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
                                      Navigator.pop(context);
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
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Data',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                    ),
                                    Text(
                                      widget.data!,
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hora',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                    ),
                                    Text(
                                      widget.hora!,
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Serviço',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                    ),
                                    Text(
                                      widget.etapade!,
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
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
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: custom_widgets.MapsRoutes(
                          width: double.infinity,
                          height: double.infinity,
                          json2:
                              functions.jsonToStr(ApiRotasDirectionsCall.tudo(
                            cardActionsApiRotasDirectionsResponse.jsonBody,
                          ))!,
                          coordenadasIniciais: currentUserLocationValue,
                          coordenadasFinais: widget.latlngFaz!,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if ((widget.jsonServico ==
                                      FFAppState().trOsServicoEmAndamento) &&
                                  (FFAppState().DeslocamentoPausado == false))
                                Opacity(
                                  opacity: 0.0,
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      setState(() {
                                        FFAppState().DeslocamentoPausado = true;
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
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                              FFButtonWidget(
                                onPressed: () async {
                                  currentUserLocationValue =
                                      await getCurrentUserLocation(
                                          defaultLocation: LatLng(0.0, 0.0));
                                  _model.porfavorFuncione =
                                      await ApiRotasPolylinesCall.call(
                                    latitudeOrigem: functions.separadorLatDeLng(
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
                                            functions
                                                .latLngToStr(widget.latlngFaz)),
                                    longitudeDestonp:
                                        functions.separadorLatDeLng(
                                            false,
                                            functions
                                                .latLngToStr(widget.latlngFaz)),
                                    key:
                                        'AIzaSyDpk1wIZmA1OTS57D_cB13BD01zqrTiQNI',
                                  );

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
                                        ApiRotasPolylinesCall
                                            .criptografadapolyline(
                                          (_model.porfavorFuncione?.jsonBody ??
                                              ''),
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );

                                  setState(() {});
                                },
                                text: FFAppState().DeslocamentoPausado &&
                                        FFAppState().trDesloacamentoIniciado &&
                                        (getJsonField(
                                              widget.jsonServico,
                                              r'''$.oserv_id''',
                                            ) ==
                                            FFAppState().trOsServicoEmAndamento)
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
                              if (!widget.deslocamentoAtualFinzalizado!)
                                Opacity(
                                  opacity: 0.0,
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      await Future.delayed(
                                          const Duration(milliseconds: 1000));
                                      await actions.mainAction(
                                        widget.servicoId,
                                        widget.tecnicoId,
                                        '1',
                                        true,
                                        functions.umMaisUm(getJsonField(
                                          FFAppState()
                                              .trOsDeslocamentoJsonAtual,
                                          r'''$.osdes_id''',
                                        ).toString()),
                                      );
                                      await actions.stopMainAction(
                                        widget.servicoId,
                                        widget.tecnicoId,
                                        '1',
                                      );
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title:
                                                Text('Finalizado com sucesso!'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
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
                                      color: FlutterFlowTheme.of(context).error,
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
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

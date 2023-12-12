import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';
import 'maps_revisao_model.dart';
export 'maps_revisao_model.dart';

class MapsRevisaoWidget extends StatefulWidget {
  const MapsRevisaoWidget({
    Key? key,
    required this.pontos,
    required this.inicio,
  }) : super(key: key);

  final List<LatLng>? pontos;
  final LatLng? inicio;

  @override
  _MapsRevisaoWidgetState createState() => _MapsRevisaoWidgetState();
}

class _MapsRevisaoWidgetState extends State<MapsRevisaoWidget> {
  late MapsRevisaoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MapsRevisaoModel());
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
      height: 400.0,
      decoration: BoxDecoration(),
      child: Stack(
        children: [
          FlutterFlowGoogleMap(
            controller: _model.googleMapsController,
            onCameraIdle: (latLng) => _model.googleMapsCenter = latLng,
            initialLocation: _model.googleMapsCenter ??= widget.inicio!,
            markers: (widget.pontos ?? [])
                .map(
                  (marker) => FlutterFlowMarker(
                    marker.serialize(),
                    marker,
                  ),
                )
                .toList(),
            markerColor: GoogleMarkerColor.violet,
            mapType: MapType.normal,
            style: GoogleMapStyle.standard,
            initialZoom: 12.0,
            allowInteraction: true,
            allowZoom: true,
            showZoomControls: false,
            showLocation: false,
            showCompass: false,
            showMapToolbar: false,
            showTraffic: false,
            centerMapOnMarkerTap: false,
          ),
          Align(
            alignment: AlignmentDirectional(1.00, -1.00),
            child: PointerInterceptor(
              intercepting: isWeb,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Material(
                    color: Colors.transparent,
                    elevation: 2.0,
                    shape: const CircleBorder(),
                    child: ClipOval(
                      child: Container(
                        width: 38.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).lineColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 32.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

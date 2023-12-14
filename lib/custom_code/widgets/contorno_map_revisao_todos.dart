// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;

class ContornoMapRevisaoTodos extends StatefulWidget {
  const ContornoMapRevisaoTodos({
    Key? key,
    this.width,
    this.height,
    this.listaDeGrupos,
    this.listaDeContornos,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<dynamic>? listaDeGrupos;
  final List<dynamic>? listaDeContornos;

  @override
  _ContornoMapRevisaoTodosState createState() =>
      _ContornoMapRevisaoTodosState();
}

class _ContornoMapRevisaoTodosState extends State<ContornoMapRevisaoTodos> {
  google_maps.GoogleMapController? _googleMapController;
  Set<google_maps.Polygon> polygons = Set();
  List<Map<String, dynamic>> convertedGrupos = [];
  List<Map<String, dynamic>> convertedContornos = [];

  @override
  void initState() {
    super.initState();
    convertedGrupos = convertToMapList(widget.listaDeGrupos);
    convertedContornos = convertToMapList(widget.listaDeContornos);
    _initializePolygons();
  }

  void _initializePolygons() {
    for (var grupo in convertedGrupos) {
      var corGrupo = HexColor(grupo['cor']);
      var grupoId = grupo['contorno_grupo'];

      var pontosGrupo = convertedContornos
          .where((contorno) => contorno['contorno_grupo'] == grupoId)
          .map((contorno) => _toLatLng(contorno['latlng']))
          .toList();

      if (pontosGrupo.isNotEmpty) {
        final polygon = google_maps.Polygon(
          polygonId: google_maps.PolygonId('AreaPolygon$grupoId'),
          points: pontosGrupo,
          fillColor: corGrupo.withOpacity(0.2),
          strokeColor: corGrupo,
          strokeWidth: 3,
        );

        setState(() {
          polygons.add(polygon);
        });
      }
    }
  }

  google_maps.LatLng _toLatLng(String latLngString) {
    final latLngSplit = latLngString.split(',').map((s) => s.trim()).toList();
    final lat = double.parse(latLngSplit[0]);
    final lng = double.parse(latLngSplit[1]);
    return google_maps.LatLng(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    final initialTarget =
        google_maps.LatLng(0.0, 0.0); // Defina um ponto inicial adequado

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: google_maps.GoogleMap(
        initialCameraPosition: google_maps.CameraPosition(
          target: initialTarget,
          zoom: 15,
        ),
        onMapCreated: (controller) => _googleMapController = controller,
        polygons: polygons,
        mapType: google_maps.MapType.satellite,
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse('0x$hexColor');
  }
}

List<Map<String, dynamic>> convertToMapList(List<dynamic>? dynamicList) {
  return dynamicList?.map((item) => item as Map<String, dynamic>).toList() ??
      [];
}

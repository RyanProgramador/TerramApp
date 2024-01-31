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

import 'package:terram_app/flutter_flow/lat_lng.dart'
    as ff_lat_lng; // Importe seu próprio pacote de LatLng

class ContornoMapRevisaoTodos extends StatefulWidget {
  const ContornoMapRevisaoTodos({
    Key? key,
    this.width,
    this.height,
    this.listaDeGrupos,
    this.listaDeContornos,
    this.fazlatlng,
    this.sincOuNovo,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<dynamic>? listaDeGrupos;
  final List<dynamic>? listaDeContornos;
  final String? sincOuNovo;
  //final google_maps.LatLng? fazlatlng;

  final ff_lat_lng.LatLng? fazlatlng;

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

      if (widget.sincOuNovo != 'sinc') {
        var filtradoRecorte = FFAppState().latlngRecorteTalhao.toList();

        // Agrupar por grupoDeRecorte e idContorno
        var gruposDeRecorte = <String, List<dynamic>>{};
        for (var item in filtradoRecorte) {
          int grupoId = item['grupoDeRecorte'];
          String idContorno = item['idContorno'].toString();
          String chave = '$grupoId-$idContorno'; // Combina grupoId e idContorno

          if (!gruposDeRecorte.containsKey(chave)) {
            gruposDeRecorte[chave] = [];
          }
          gruposDeRecorte[chave]!.add(item);
        }

        // Criar um polígono para cada grupo
        gruposDeRecorte.forEach((chave, itens) {
          List<google_maps.LatLng> recorteLatLngList = itens.map((item) {
            var parts = item['listaLatLngRecorte'].split(',');
            return google_maps.LatLng(
                double.parse(parts[0].trim()), double.parse(parts[1].trim()));
          }).toList();

          if (recorteLatLngList.isNotEmpty) {
            var recortePolygon = google_maps.Polygon(
              polygonId: google_maps.PolygonId('Recorte_$chave'),
              points: recorteLatLngList,
              fillColor: Colors.red.withOpacity(0.4),
              strokeColor: Colors.red,
              strokeWidth: 3,
            );

            setState(() {
              polygons.add(recortePolygon);
            });
          }
        });
      }

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
    final initialTarget = _convertToGoogleLatLng(widget.fazlatlng) ??
        google_maps.LatLng(0.0, 0.0);

    return Stack(
      children: [
        Container(
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
        ),
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ElevatedButton(
              //   onPressed: () => _showVariablesAlert(context),
              //   style: ElevatedButton.styleFrom(
              //     shape: CircleBorder(),
              //     backgroundColor: Color(0xFF00736D),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: Icon(
              //       Icons.info_outline,
              //       size: 35.0,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  void _showVariablesAlert(BuildContext context) {
    var filtradoRecorte = FFAppState()
        .latlngRecorteTalhao
        // .where((item) => item['contorno_grupo'] == widget.idContorno)
        // .where(
        //     (item) => item['listaLatLngRecorte'] != null) // Adiciona esta linha
        // .map((item) => item['listaLatLngRecorte'])
        .toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Variáveis e Valores'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                // Text('Lista de LatLng: ${latLngList}'),
                Text(
                    'apenas as latlng do contorno correto: ${widget.listaDeGrupos}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

google_maps.LatLng? _convertToGoogleLatLng(ff_lat_lng.LatLng? latLng) {
  if (latLng == null) {
    return null;
  }
  return google_maps.LatLng(latLng.latitude, latLng.longitude);
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

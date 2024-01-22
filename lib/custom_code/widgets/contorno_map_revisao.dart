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

class ContornoMapRevisao extends StatefulWidget {
  const ContornoMapRevisao({
    Key? key,
    this.width,
    this.height,
    this.listaDeLatLng,
    this.listaDeLatLngRecorte,
    this.cor,
    this.fazid,
    this.oservid,
    this.idContorno,
    this.fazNome,
    this.fazLatLng,
    this.localAtual,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<String>? listaDeLatLng;
  final List<String>? listaDeLatLngRecorte;
  final String? cor;

  final LatLng? localAtual;
  final String? oservid;
  final String? idContorno;
  final String? fazid;
  final String? fazNome;
  final LatLng? fazLatLng;

  @override
  _ContornoMapRevisaoState createState() => _ContornoMapRevisaoState();
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = _extractHexCode(hexColor);
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse('0x$hexColor');
  }

  static String _extractHexCode(String input) {
    RegExp regex = RegExp(r'([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})');
    Match match = regex.firstMatch(input)!;
    return match.group(0)!;
  }
}

class _ContornoMapRevisaoState extends State<ContornoMapRevisao> {
  google_maps.GoogleMapController? _googleMapController;
  Set<google_maps.Polygon> polygons = Set();
  List<google_maps.LatLng> latLngList = [];
  List<google_maps.LatLng> latLngListRecorte = [];

  @override
  void initState() {
    super.initState();
    if (widget.listaDeLatLng != null) {
      latLngList = toLatLng(widget.listaDeLatLng!);
      _initializePolygons();
    }
    var filtradoRecorte = FFAppState()
        .latlngRecorteTalhao
        .where((item) => item['idContorno'] == widget.idContorno)
        .map((item) => item['listaLatLngRecorte'])
        .toList();
    if (filtradoRecorte != null) {
      _createRecortePolygons();
    }
  }

  List<google_maps.LatLng> toLatLng(dynamic latLngData) {
    List<google_maps.LatLng> latLngList = [];
    if (latLngData is List) {
      for (var latLngString in latLngData) {
        if (latLngString is String) {
          final latLngSplit =
              latLngString.split(',').map((s) => s.trim()).toList();
          if (latLngSplit.length == 2) {
            try {
              final lat = double.parse(latLngSplit[0]);
              final lng = double.parse(latLngSplit[1]);
              latLngList.add(google_maps.LatLng(lat, lng));
            } catch (e) {
              // Handle parsing error if any.
            }
          }
        } else if (latLngString is List) {
          // Se for uma lista aninhada, chama a mesma função recursivamente
          latLngList.addAll(toLatLng(latLngString));
        }
      }
    }
    return latLngList;
  }

  void _initializePolygons() {
    var corSTR = widget.cor.toString();
    if (latLngList.isNotEmpty) {
      final polygon = google_maps.Polygon(
        polygonId: const google_maps.PolygonId('AreaPolygon'),
        points: latLngList,
        fillColor: HexColor("$corSTR").withOpacity(0.3) ??
            Colors.blue.withOpacity(0.2),
        strokeColor: HexColor("$corSTR") ?? Colors.blue,
        strokeWidth: 3,
      );

      setState(() {
        polygons.add(polygon);
      });
    }
  }

  void _createRecortePolygons() {
    // Supondo que filtradoRecorte seja uma lista de objetos JSON, onde cada objeto contém uma lista aninhada representando os pontos do polígono
    var filtradoRecorte = FFAppState()
        .latlngRecorteTalhao
        .where((item) => item['idContorno'] == widget.idContorno)
        .toList();

    for (var item in filtradoRecorte) {
      // Aqui, assumimos que `item` é um Map<String, dynamic> e que `item['listaLatLngRecorte']` é uma lista aninhada de strings
      var recorteLatLngList = toLatLng(item['listaLatLngRecorte']);
      var recortePolygon = google_maps.Polygon(
        polygonId: google_maps.PolygonId('Recorte_${item.hashCode}'),
        points: recorteLatLngList,
        fillColor: Colors.red.withOpacity(0.4),
        strokeColor: Colors.red,
        strokeWidth: 3,
      );

      setState(() {
        polygons.add(recortePolygon);
      });
    }
  }

  void tesouraRecorte() {
    //redireciona para a lista de contornos

    final listaLatLngString = widget.listaDeLatLng?.join(",") ?? '';

    context.goNamed(
      'ContornoRecorteDaFazenda',
      queryParameters: {
        'listaLatLngTalhao': serializeParam(
          listaLatLngString,
          ParamType.String,
        ),
        'fazendaNome': serializeParam(
          widget.fazNome,
          ParamType.String,
        ),
        'fazid': serializeParam(
          widget.fazid,
          ParamType.String,
        ),
        'fazlatlng': serializeParam(
          widget.fazLatLng,
          ParamType.LatLng,
        ),
        'idDoContorno': serializeParam(
          widget.idContorno,
          ParamType.String,
        ),
        'localAtual': serializeParam(
          widget.localAtual,
          ParamType.LatLng,
        ),
        'oservID': serializeParam(
          widget.oservid,
          ParamType.String,
        ),
      }.withoutNulls,
      extra: <String, dynamic>{
        kTransitionInfoKey: TransitionInfo(
          hasTransition: true,
          transitionType: PageTransitionType.fade,
          duration: Duration(milliseconds: 0),
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final initialTarget =
        latLngList.isNotEmpty ? latLngList.first : google_maps.LatLng(0.0, 0.0);

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
              ElevatedButton(
                onPressed: tesouraRecorte,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Color(0xFFFFCD00),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.cut,
                    size: 35.0,
                    color: Colors.white,
                  ),
                ),
              ),
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Variáveis e Valores'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Lista de LatLng: ${widget.listaDeLatLng}'),
                Text('Cor: ${widget.cor}'),
                Text('Local Atual: ${widget.localAtual}'),
                Text('OSERVID: ${widget.oservid}'),
                Text('ID do Contorno: ${widget.idContorno}'),
                Text('ID da Fazenda: ${widget.fazid}'),
                Text('Nome da Fazenda: ${widget.fazNome}'),
                Text('LatLng da Fazenda: ${widget.fazLatLng}'),
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

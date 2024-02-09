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
        .where((item) =>
            item['idContorno'].toString() == widget.idContorno.toString())
        .toList();

    if (filtradoRecorte != null) {
      _createRecortePolygons();
    }
  }

  // List<google_maps.LatLng> toLatLng(dynamic latLngData) {
  //   List<google_maps.LatLng> latLngList = [];
  //   if (latLngData is List) {
  //     for (var latLngString in latLngData) {
  //       if (latLngString is String) {
  //         final latLngSplit =
  //             latLngString.split(',').map((s) => s.trim()).toList();
  //         if (latLngSplit.length == 2) {
  //           try {
  //             final lat = double.parse(latLngSplit[0]);
  //             final lng = double.parse(latLngSplit[1]);
  //             latLngList.add(google_maps.LatLng(lat, lng));
  //           } catch (e) {
  //             // Handle parsing error if any.
  //           }
  //         }
  //       } else if (latLngString is List) {
  //         // Se for uma lista aninhada, chama a mesma função recursivamente
  //         latLngList.addAll(toLatLng(latLngString));
  //       }
  //     }
  //   }
  //   return latLngList;
  // }

  // List<google_maps.LatLng> toLatLng(dynamic latLngData) {
  //   List<google_maps.LatLng> latLngList = [];
  //
  //   if (latLngData is String) {
  //     final splits = latLngData.split(',');
  //     if (splits.length == 2) {
  //       try {
  //         final lat = double.parse(splits[0].trim());
  //         final lng = double.parse(splits[1].trim());
  //         latLngList.add(google_maps.LatLng(lat, lng));
  //       } catch (e) {
  //         print("Erro ao converter latLngData: $e");
  //       }
  //     }
  //   } else if (latLngData is List) {
  //     for (var item in latLngData) {
  //       latLngList.addAll(toLatLng(item));
  //     }
  //   }
  //
  //   return latLngList;
  // }

  List<google_maps.LatLng> toLatLng(dynamic latLngData) {
    List<google_maps.LatLng> latLngList = [];

    // Se latLngData é uma string, converte diretamente para LatLng
    if (latLngData is String) {
      final splits = latLngData.split(',');
      if (splits.length == 2) {
        try {
          final lat = double.parse(splits[0].trim());
          final lng = double.parse(splits[1].trim());
          latLngList.add(google_maps.LatLng(lat, lng));
        } catch (e) {
          print("Erro ao converter latLngData: $e");
        }
      }
    }
    // Se latLngData é uma lista, processa cada item individualmente
    else if (latLngData is List) {
      for (var item in latLngData) {
        if (item is String) {
          latLngList.addAll(toLatLng(item));
        }
      }
    }

    return latLngList;
  }

  int? toInt(String? str) {
    if (str == null) {
      // Retorna null se a string for null
      return null;
    }

    // Tenta converter a string para um inteiro
    return int.tryParse(str);
  }

  void _initializePolygons() {
    var corSTR = widget.cor.toString();
    var filtradoRecorte = FFAppState()
        .contornoFazendaPosSincronizado
        .where((item) => item['contorno_grupo'] == toInt(widget.idContorno))
        .map((item) => item['latlng'])
        .toList();

    if (filtradoRecorte.isNotEmpty) {
      final polygon = google_maps.Polygon(
        polygonId: const google_maps.PolygonId('AreaPolygon'),
        points: toLatLng(filtradoRecorte),
        fillColor: HexColor("$corSTR").withOpacity(0.3) ??
            Colors.blue.withOpacity(0.2),
        strokeColor: HexColor("$corSTR") ?? Colors.blue,
        strokeWidth: 3,
      );

      setState(() {
        polygons.add(polygon);
      });
    } else {
      var filtradoRecorte2 = FFAppState()
          .contornoFazenda
          .where((item) => item['contorno_grupo'] == widget.idContorno)
          .map((item) => item['latlng'])
          .toList();

      final polygon = google_maps.Polygon(
        polygonId: const google_maps.PolygonId('AreaPolygon'),
        points: toLatLng(filtradoRecorte2),
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

  // void _createRecortePolygons() {
  //   // Supondo que filtradoRecorte seja uma lista de objetos JSON, onde cada objeto contém uma lista aninhada representando os pontos do polígono
  //   var filtradoRecorte = FFAppState()
  //       .latlngRecorteTalhao
  //       .where((item) => item['idContorno'] == widget.idContorno)
  //       .toList();
  //
  //   for (var item in filtradoRecorte) {
  //     // Aqui, assumimos que `item` é um Map<String, dynamic> e que `item['listaLatLngRecorte']` é uma lista aninhada de strings
  //     var recorteLatLngList = toLatLng(item['listaLatLngRecorte']);
  //     var recortePolygon = google_maps.Polygon(
  //       polygonId: google_maps.PolygonId('Recorte_${item.hashCode}'),
  //       points: recorteLatLngList,
  //       fillColor: Colors.red.withOpacity(0.4),
  //       strokeColor: Colors.red,
  //       strokeWidth: 3,
  //     );
  //
  //     setState(() {
  //       polygons.add(recortePolygon);
  //     });
  //   }
  // }
  void _createRecortePolygons() {
    var filtradoRecorte = FFAppState()
        .latlngRecorteTalhao
        .where((item) => item['idContorno'] == widget.idContorno)
        // .map((item) => item['listaLatLngRecorte'])
        .toList();

    //   List<google_maps.LatLng> recorteLatLngList = [];
    //
    //   // Iterar pela lista filtradoRecorte
    //   for (var latLngString in filtradoRecorte) {
    //     // Supondo que cada item é uma string contendo lat e lng separados por vírgula
    //     var parts = latLngString.split(',');
    //     if (parts.length == 2) {
    //       try {
    //         double lat = double.parse(parts[0].trim());
    //         double lng = double.parse(parts[1].trim());
    //         recorteLatLngList.add(google_maps.LatLng(lat, lng));
    //       } catch (e) {
    //         // Pode lançar uma exceção se a conversão falhar
    //         print("Erro ao converter String para double: $e");
    //       }
    //     }
    //   }
    //
    //   // Verifica se a lista tem elementos suficientes para formar um polígono
    //   if (recorteLatLngList.isNotEmpty) {
    //     // Criar e adicionar o polígono de recorte
    //     var recortePolygon = google_maps.Polygon(
    //       polygonId: google_maps.PolygonId('RecortePolygon'),
    //       points: recorteLatLngList,
    //       fillColor: Colors.red.withOpacity(0.4),
    //       strokeColor: Colors.red,
    //       strokeWidth: 3,
    //     );
    //
    //     setState(() {
    //       polygons.add(recortePolygon);
    //     });
    //   } else {
    //     // Tratar caso onde recorteLatLngList é vazia ou dados não são válidos
    //     print("Lista de coordenadas para recorte está vazia ou contém dados inválidos.");
    //   }
    // }

    // Agrupar por grupoDeRecorte
    var gruposDeRecorte = <int, List<dynamic>>{};
    for (var item in filtradoRecorte) {
      int grupoId = item['grupoDeRecorte'];
      if (!gruposDeRecorte.containsKey(grupoId)) {
        gruposDeRecorte[grupoId] = [];
      }
      gruposDeRecorte[grupoId]!.add(item);
    }

    // Criar um polígono para cada grupo
    gruposDeRecorte.forEach((grupoId, itens) {
      List<google_maps.LatLng> recorteLatLngList = itens.map((item) {
        var parts = item['listaLatLngRecorte'].split(',');
        return google_maps.LatLng(
            double.parse(parts[0].trim()), double.parse(parts[1].trim()));
      }).toList();

      if (recorteLatLngList.isNotEmpty) {
        // Criar e adicionar o polígono de recorte
        var recortePolygon = google_maps.Polygon(
          polygonId: google_maps.PolygonId('Recorte_$grupoId'),
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

  // // Função para converter a lista linear de coordenadas em uma lista de LatLng
  // List<google_maps.LatLng> _convertToLatLngList(List<double> flatList) {
  //   List<google_maps.LatLng> latLngList = [];
  //   for (int i = 0; i < flatList.length; i += 2) {
  //     latLngList.add(google_maps.LatLng(flatList[i], flatList[i + 1]));
  //   }
  //   return latLngList;
  // }

  void tesouraRecorte() {
    //redireciona para a lista de contornos

    final listaLatLngString = widget.listaDeLatLng?.join(",") ?? '';

    context.pushNamed(
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
    // var filtradoRecorte = FFAppState()
    //     .contornoFazendaPosSincronizado
    //     .where((item) => item['contorno_grupo'] == 502)
    //     // .map((item) => item['latlng'])
    //     .toList();

    var filtroTalhId = FFAppState()
        .grupoContornoFazendasPosSincronizado
        .where((item) => item['contorno_grupo'] == toInt(widget.idContorno))
        // .map((item) => item['id'])
        .toList();
    var teste = jsonListToStr(filtroTalhId);
    var filtradoRecorte = FFAppState()
        .contornoFazendaPosSincronizado
        .where((item) => item['contorno_grupo'] == 502)
        // .map((item) => item['latlng'])
        .toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Variáveis e Valores'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Lista de LatLng: ${latLngList}'),
                Text('Cor: ${widget.cor}'),
                Text('Local Atual: ${widget.localAtual}'),
                Text('OSERVID: ${widget.oservid}'),
                Text('ID do Contorno: ${widget.idContorno}'),
                Text('ID da Fazenda: ${widget.fazid}'),
                Text('Nome da Fazenda: ${widget.fazNome}'),
                Text('id de busca: $teste'),
                Text('apenas as latlng do contorno correto: $filtradoRecorte'),
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

List<Map<String, dynamic>> convertToMapList(List<dynamic>? dynamicList) {
  return dynamicList?.map((item) => item as Map<String, dynamic>).toList() ??
      [];
}

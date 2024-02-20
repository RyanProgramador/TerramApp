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

import 'package:flutter/services.dart';
import 'dart:convert';
// import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';

import 'package:background_location/background_location.dart'
    as background_location;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:wakelock/wakelock.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Coleta extends StatefulWidget {
  final double? width;
  final double? height;
  //final List<String>? listaPontosComProfundidadeParaMedicao;
  final int? intervaloDeColetaParaProximaFoto;
  final bool? autoAuditoria;
  final String? idContorno;
  //final List<String>? possiveisProfundidades;
  //final List<String>? listaDeLocaisDeContornoDeArea;
  final List<dynamic>? pontosJaColetados;

  const Coleta({
    Key? key,
    this.width,
    this.height,
    //this.listaPontosComProfundidadeParaMedicao,
    this.intervaloDeColetaParaProximaFoto,
    this.idContorno,
    //this.possiveisProfundidades,
    //this.listaDeLocaisDeContornoDeArea,
    this.pontosJaColetados,
    this.autoAuditoria,
  }) : super(key: key);
  final String customIconUrl =
      'https://cdn-icons-png.flaticon.com/128/3253/3253113.png';

  @override
  _ColetaState createState() => _ColetaState();
}

class _ColetaState extends State<Coleta> {
  google_maps.GoogleMapController? _googleMapController;
  Set<google_maps.Polygon> polygons = Set();
  Set<google_maps.Marker> markers = Set();
  Position? _currentPosition;
  StreamSubscription<Position>? _positionStreamSubscription;
  double? _userZoom;
  double _currentZoom = 18.0; // Inicializa o zoom padrão
// adiciona ponto novo na coleta
  bool isAddingPoint = false;

  //seleciona profundidade

  Set<String> profundidadesSelecionadas = {};
  List<String> possiveisProfundidades = ['0-10', '10-20', '20-30'];

  // Listas para armazenar os dados
  List<Map<String, String>> pontosMovidos = [];
  List<Map<String, String>> pontosColetados = [];
  List<Map<String, String>> pontosExcluidos = [];

  Map<String, Set<String>> coletasPorMarcador = {};

  //

  //tira foto
  bool podeTirarFoto = false;
  int intervaloDeColetaParaProximaFoto = 3000;
  int vezAtualDoIntervaloDeColeta = 0;

//double tap no marcador
  bool focoNoMarcador = false;
  google_maps.LatLng? latlngMarcador;
  Map<String, DateTime> lastTapTimestamps = {};

//
  Map<String, bool> coletados = {};
  Map<String, google_maps.LatLng> markerPositions = {};

// ICONE

  Uint8List? customIconBytes;
//
  //IMPEDIR DE PEGAR NO MESMO LUGAR
  Position? lastPosition;

  Position? position;
  double currentZoom = 20.0;
  google_maps.LatLng? currentTarget;

  //
  // List<Map<String, dynamic>> listaDeLocais = [];

  // Implementação de exemplo
  List<Map<String, dynamic>> latLngListMarcadores = [];

  // List<Map<String, dynamic>> latLngListMarcadores = [
  //   {
  //     "marcador_nome": "A",
  //     "icone": "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",
  //     "latlng_marcadores": "-29.914939224621914, -51.195420011983714",
  //     "profundidades": [
  // {               "nome": "teste",
  //                 "icone": "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",
  //                 "cor": "#FFFFFF" ?? "#FFFFFF",
  //                 "prof_id": 1,
  //               },
  //     ],
  //     "foto_de_cada_profundidade": [],
  //   },
  //   {
  //     "marcador_nome": "B",
  //     "icone": "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",
  //     "latlng_marcadores": "-29.91495486428177, -51.19437347868409",
  //     "profundidades": [
  //       {"nome": "0-10", "icone": "location_dot", "cor": "#FFC0CB"},
  //       {"nome": "0-20", "icone": "flag", "cor": "#FF4500"},
  //       {"nome": "0-25", "icone": "map_pin", "cor": "#0000CD"}
  //     ],
  //     "foto_de_cada_profundidade": [],
  //   },
  //   {
  //     "marcador_nome": "C",
  //     "icone": "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",
  //     "latlng_marcadores": "-29.914305816333297, -51.19483359246237",
  //     "profundidades": [
  //       {"nome": "0-10", "icone": "location_dot", "cor": "#FFC0CB"},
  //       {"nome": "0-20", "icone": "flag", "cor": "#FF4500"},
  //       {"nome": "0-25", "icone": "map_pin", "cor": "#0000CD"},
  //       {"nome": "0-35", "icone": "plane", "cor": "#0000CD"}
  //     ],
  //     "foto_de_cada_profundidade": [],
  //   },
  //   {
  //     "marcador_nome": "D",
  //     "icone": "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",
  //     "latlng_marcadores": "-29.91391738877275, -51.19420634010805",
  //     "profundidades": [
  //       {"nome": "0-10", "icone": "location_dot", "cor": "#FFC0CB"},
  //       {"nome": "0-20", "icone": "flag", "cor": "#FF4500"},
  //       {"nome": "0-25", "icone": "map_pi", "cor": "#0000CD"}
  //     ],
  //     "foto_de_cada_profundidade": [],
  //   },
  // ];

  // void _inicializaDados() {
  //   var latLngListMarcadores = FFAppState().pontosDeColeta
  //       .where((item) => item['oserv_id'] == 38)
  //       .toList();
  // latLngListMarcadores = filtroPontosColeta;
  //
  //
  //   // Transforma os itens filtrados em uma lista de mapas com a estrutura desejada
  //   latLngListMarcadores = filtroPontosColeta.map((item) {
  //     return {
  //       "marcador_nome": "${item['artp_id']}",
  //       "icone" : "${}",
  //       "latlng_marcadores": "${item['artp_latitude_longitude']}",
  //       "profundidades": "${item['artp_id_perfil_prof']}",
  //       "foto_de_cada_profundidade": [],
  //     };
  //   }).toList();
  //
  //   // Se você precisar atualizar a interface do usuário baseada nesses dados,
  //   // chame setState para reconstruir o widget com os novos dados.
  //   setState(() {});
  // }

  @override
  void initState() {
    Wakelock.enable();
    super.initState();

    var pontosJaColetados = FFAppState().PontosColetados.toList();
    if (pontosJaColetados != null && pontosJaColetados!.isNotEmpty) {
      for (var ponto in pontosJaColetados!) {
        if (ponto is String) {
          try {
            Map<String, dynamic> pontoMap = json.decode(ponto);
            // Convertendo para Map<String, String>
            Map<String, String> pontoMapString = pontoMap.map((key, value) {
              return MapEntry(key, value.toString());
            });
            pontosColetados.add(pontoMapString);
          } catch (e) {
            print('Erro ao desserializar ponto: $e');
          }
        } else {
          print('Ponto inválido recebido (não é uma string): $ponto');
        }
      }
    }
    // intervaloDeColetaParaProximaFoto = 1;
    intervaloDeColetaParaProximaFoto =
        widget.intervaloDeColetaParaProximaFoto ?? 0;

    if (intervaloDeColetaParaProximaFoto == 0) {
      podeTirarFoto = false;
    } else {
      intervaloDeColetaParaProximaFoto++;
      if (widget.autoAuditoria == true) {
        podeTirarFoto = true;
      }
    }

    // if (widget.listaDeLocaisDeContornoDeArea != null) {
    //   listaDeLocais = widget.listaDeLocaisDeContornoDeArea!
    //       .map((e) {
    //         try {
    //           return json.decode(e) as Map<String, dynamic>;
    //         } catch (error) {
    //           print('Erro ao desserializar JSON: $error');
    //           return null;
    //         }
    //       })
    //       .where((element) => element != null)
    //       .cast<Map<String, dynamic>>()
    //       .toList();
    // }
//
    // if (widget.listaPontosComProfundidadeParaMedicao != null) {
    //   latLngListMarcadores = widget.listaPontosComProfundidadeParaMedicao!
    //       .map((e) => json.decode(e))
    //       .cast<Map<String, dynamic>>()
    //       .toList();
    // }

// Atribuição condicional, garantindo que o parâmetro é uma lista de strings
    // if (widget.possiveisProfundidades != null) {
    //   possiveisProfundidades =
    //       List<String>.from(widget.possiveisProfundidades!);
    // }
    _inicializaDados();
    _initializePolygons();
    _criaMarcadores();
    _getCurrentLocation();
    // _loadCustomIcon();

    _trackUserLocation();
  }

  void _inicializaDados() {
    // var filtroPontosColeta = FFAppState()
    //     .pontosDeColeta
    //     .where((item) => item['oserv_id'] == int.parse(widget.idContorno!))
    //     .toList();
    var filtroPontosColeta = FFAppState()
        .pontosDeColeta
        .where((item) => item['oserv_id'] == int.parse(widget.idContorno!))
        .map((item) => item as Map<String, dynamic>) // Adiciona esta linha
        .toList();

    List<Map<String, dynamic>> substituirIcone(
        List<Map<String, dynamic>> pontosColeta) {
      return pontosColeta.map((ponto) {
        // Substituir o icone do marcador
        var iconeMarcador = FFAppState().icones.firstWhere(
              (icone) =>
                  icone['ico_id'].toString() == ponto['icone'].toString(),
              orElse: () => {
                'ico_base64': ''
              }, // Fornecer um valor padrão caso não encontre
            )['ico_base64'];

        // Substituir o icone de cada profundidade
        var profundidadesAtualizadas =
            (ponto['profundidades'] as List<dynamic>).map((profundidade) {
          var iconeProfundidade = FFAppState().icones.firstWhere(
                (icone) =>
                    icone['ico_id'].toString() ==
                    profundidade['icone'].toString(),
                orElse: () => {
                  'ico_base64': ''
                }, // Fornecer um valor padrão caso não encontre
              )['ico_base64'];

          return {
            ...profundidade,
            'icone': iconeProfundidade,
          };
        }).toList();

        return {
          ...ponto,
          'icone': iconeMarcador,
          'profundidades': profundidadesAtualizadas,
        };
      }).toList();
    }

    latLngListMarcadores = substituirIcone(filtroPontosColeta);
    //   // Busca por profundidadesPontos relacionadas ao ponto de coleta atual
    //   var profundidadesPontosProfIds = FFAppState()
    //       .profundidadesPonto
    //       .where((coleta) => coleta['trpp_artp_id'] == item['artp_id'])
    //       .map((e) => e['trpp_prof_id']);
    //
    //   // Para cada profundidadePontosProfId, encontra as informações correspondentes em profundidades
    //   var profundidadesLista = profundidadesPontosProfIds
    //       .map((profId) {
    //         var profundidade = FFAppState().profundidades.firstWhere(
    //             (prof) => prof['prof_id'] == profId,
    //             orElse: () => null);
    //
    //         return profundidade != null
    //             ? {
    //                 "nome": profundidade['prof_nome'],
    //                 "icone": profundidade['prof_imagem'],
    //                 "cor": profundidade['prof_cor'] ?? "#FFFFFF",
    //                 "prof_id": profId,
    //               }
    //             : null;
    //       })
    //       .where((element) => element != null)
    //       .toList();
    //
    //   var perfilProfundidade = FFAppState().perfilprofundidades.firstWhere(
    //       (perfil) => perfil['pprof_id'] == item['artp_id_perfil_prof'],
    //       orElse: () => null);
    //
    //   var imagemProfundidade = '';
    //   if (perfilProfundidade != null) {
    //     var profundidade = FFAppState().profundidades.firstWhere(
    //         (prof) => prof['prof_id'] == perfilProfundidade['pprof_prof_id'],
    //         orElse: () => null);
    //
    //     if (profundidade != null) {
    //       imagemProfundidade = profundidade['prof_imagem'];
    //     }
    //   }
    //
    //   // Retorna o mapa com as informações do ponto de coleta e as profundidades associadas
    //   return {
    //     "marcador_nome": "${item['artp_id']}",
    //     "icone": imagemProfundidade, // A imagem de profundidade
    //     "latlng_marcadores": "${item['artp_latitude_longitude']}",
    //     "profundidades": profundidadesLista, // Lista de profundidades
    //     "foto_de_cada_profundidade": [],
    //   };
    // }).toList();

    setState(() {});
  }

  // void _inicializaDados() {
  //
  //
  //   var filtroPontosColeta = FFAppState()
  //       .pontosDeColeta
  //       .where((item) => item['oserv_id'] == int.parse(widget.idContorno!))
  //       .toList();
  //
  //   latLngListMarcadores = filtroPontosColeta.map((item) {
  //     var profundidadesLista = FFAppState()
  //         .perfilprofundidades
  //         .where((perfil) => perfil['pprof_id'] == item['artp_id_perfil_prof'])
  //         .map((perfilProfundidade) {
  //       var profundidade = FFAppState().profundidades.firstWhere(
  //               (prof) =>
  //           prof['prof_id'] == perfilProfundidade['pprof_prof_id'],
  //           orElse: () => null);
  //
  //       return profundidade != null
  //           ? {
  //         "nome": profundidade['prof_nome'],
  //         "icone": profundidade['prof_icone'],
  //         "cor": profundidade['prof_cor'] ?? "#FFFFFF",
  //       }
  //           : null;
  //     })
  //         .whereType<
  //         Map<String, dynamic>>() // Remove nulos e assegura o tipo correto
  //         .toList();
  //
  //     var perfilProfundidade = FFAppState().perfilprofundidades.firstWhere(
  //             (perfil) => perfil['pprof_id'] == item['artp_id_perfil_prof'],
  //         orElse: () => null);
  //
  //     var imagemProfundidade = '';
  //     if (perfilProfundidade != null) {
  //       var profundidade = FFAppState().profundidades.firstWhere(
  //               (prof) => prof['prof_id'] == perfilProfundidade['pprof_prof_id'],
  //           orElse: () => null);
  //
  //       // Se encontrou a profundidade, pega a imagem
  //       if (profundidade != null) {
  //         imagemProfundidade = profundidade['prof_imagem'];
  //       }
  //     }
  //     return {
  //       "marcador_nome": "${item['artp_id']}",
  //       "icone":
  //       imagemProfundidade, // Certifique-se de que 'imagemProfundidade' é definida corretamente
  //       "latlng_marcadores": "${item['artp_latitude_longitude']}",
  //       "profundidades": profundidadesLista,
  //       "foto_de_cada_profundidade": [],
  //     };
  //   }).toList();
  //
  //   setState(() {});
  // }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    _googleMapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(google_maps.GoogleMapController controller) {
    _googleMapController = controller;
    _getCurrentLocation(); // Inicializar a posição atual ao criar o mapa
  }

  void _getCurrentLocation() async {
    Position newLoc = await Geolocator.getCurrentPosition();
    // Se for a primeira vez ou se a distância entre a última posição e a nova for >= 1m
    // if (lastPosition == null ||
    //     Geolocator.distanceBetween(
    //           lastPosition!.latitude,
    //           lastPosition!.longitude,
    //           newLoc.latitude,
    //           newLoc.longitude,
    //         ) >=
    //         1) {
    // Atualiza a última posição conhecida
    lastPosition = newLoc;
    double currentZoomLevel = await _googleMapController!.getZoomLevel();
    if (_googleMapController != null) {
      _googleMapController!.animateCamera(
        google_maps.CameraUpdate.newCameraPosition(
          google_maps.CameraPosition(
            target: google_maps.LatLng(
              newLoc.latitude,
              newLoc.longitude,
            ),
            zoom: currentZoomLevel,
          ),
        ),
      );
    }
    currentTarget = google_maps.LatLng(newLoc.latitude, newLoc.longitude);
    currentZoom = 20;

    setState(() {
      position = newLoc;
      _addUserMarker(google_maps.LatLng(newLoc.latitude, newLoc.longitude));
    });
    // }
  }

  void _onCameraMove(google_maps.CameraPosition position) {
    _currentZoom = position.zoom; // Atualiza o zoom atual
  }

  //trnasforme json em um formato elegivel pelo sistema
  List<google_maps.LatLng> _transformaJsonEmLatLng(List<dynamic> jsonList) {
    return jsonList.map((jsonItem) {
      List<String> latLng = jsonItem["latlng"].split(', ');
      return google_maps.LatLng(
          double.parse(latLng[0]), double.parse(latLng[1]));
    }).toList();
  }

  void _initializePolygons() {
    var pontosDeContorno = FFAppState()
        .listaContornoColeta
        .where((item) => item['oserv_id'] == int.parse(widget.idContorno!))
        .toList();

    var gruposDeContorno = <String, List<dynamic>>{};

    for (var item in pontosDeContorno) {
      String talcotTalhId = item['talcot_talh_id'].toString();
      String oservId = item['oserv_id'].toString();
      String chave =
          '$talcotTalhId-$oservId'; // Combina talcot_talh_id e oserv_id para criar uma chave única
      String cor = item['talh_cor'].toString();

      gruposDeContorno.putIfAbsent(chave, () => []);
      gruposDeContorno[chave]!.add(item);
    }

    // Itera sobre os grupos para criar polígonos
    gruposDeContorno.forEach((chave, grupo) {
      // Assumindo que `toLatLng` é uma função que converte uma string ou um objeto
      // no formato 'latitude,longitude' para um objeto LatLng.
      List<google_maps.LatLng> pontosLatLng =
          grupo.map<google_maps.LatLng>((item) {
        return toLatLng(item['talcot_latitude_longitude']);
      }).toList();

      // Cria um polígono para cada grupo
      final polygon = google_maps.Polygon(
        polygonId: google_maps.PolygonId(
            'AreaPolygon_$chave'), // Usa a chave para criar um ID único
        points: pontosLatLng,
        fillColor: Colors.black.withOpacity(0.2),
        strokeColor: Colors.black,
        strokeWidth: 3,
      );

      setState(() {
        polygons.add(polygon);
      });
    });
  }

  google_maps.LatLng toLatLng(String latLngStr) {
    var parts = latLngStr.split(',');
    if (parts.length != 2) {
      throw FormatException(
          "Input does not contain a valid latitude,longitude format");
    }
    var latitude = double.parse(parts[0].trim());
    var longitude = double.parse(parts[1].trim());
    return google_maps.LatLng(latitude, longitude);
  }

  Uint8List resizeImage(String base64Str, int width, int height) {
    // Decodifica a string base64 para uma imagem
    Uint8List decodedBytes = base64Decode(base64Str);
    // Decodifica a imagem para um objeto de imagem
    img.Image? image = img.decodeImage(decodedBytes);

    // Redimensiona a imagem
    img.Image resized = img.copyResize(image!, width: width, height: height);

    // Codifica a imagem redimensionada de volta para Uint8List
    return Uint8List.fromList(img.encodePng(resized));
  }

  // List<google_maps.LatLng> toLatLng(dynamic latLngData) {
  //   List<google_maps.LatLng> latLngList = [];
  //
  //   // Se latLngData é uma string, converte diretamente para LatLng
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
  //   }
  //   // Se latLngData é uma lista, processa cada item individualmente
  //   else if (latLngData is List) {
  //     for (var item in latLngData) {
  //       if (item is String) {
  //         latLngList.addAll(toLatLng(item));
  //       }
  //     }
  //   }
  //
  //   return latLngList;
  // }
  void _criaMarcadores() async {
    for (var marcador in latLngListMarcadores) {
      var latlng = marcador["latlng_marcadores"]!.split(",");
      var markerId = google_maps.MarkerId(marcador["marcador_nome"]!);
      var position =
          google_maps.LatLng(double.parse(latlng[0]), double.parse(latlng[1]));

      bool verificaTodasProfundidadesColetadas(String marcadorNome) {
        // Obter as profundidades do marcador a partir dos pontos de coleta
        List<dynamic> profundidadesMarcador = latLngListMarcadores.firstWhere(
            (marcador) => marcador["marcador_nome"] == marcadorNome,
            orElse: () => {"profundidades": []})["profundidades"];

        // Obter as profundidades coletadas para este marcador a partir dos pontos coletados
        List<dynamic> profundidadesColetadas = FFAppState()
            .PontosColetados
            .where((ponto) => ponto["marcador_nome"] == marcadorNome)
            .map((ponto) => ponto["profundidade"])
            .toList();

        // Verificar se todas as profundidades do marcador estão presentes nas profundidades coletadas
        for (var profundidade in profundidadesMarcador) {
          if (!profundidadesColetadas.contains(profundidade["nome"])) {
            // Se alguma profundidade do marcador não estiver nas profundidades coletadas, retorna false
            return false;
          }
        }

        // Se todas as profundidades do marcador estiverem nas profundidades coletadas, retorna true
        return true;
      }

      // Verifica se todas as profundidades foram coletadas
      bool todasProfundidadesColetadas =
          verificaTodasProfundidadesColetadas(marcador["marcador_nome"]);

      // Escolhe o ícone com base se todas as profundidades foram coletadas
      String base64Icon = todasProfundidadesColetadas
          ? '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'
          : marcador["icone"];

      // String base64Icon = todasProfundidadesColetadas
      //     ? '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'
      //     : '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';

      var iconBytes = resizeImage(base64Icon, 70, 70);

      google_maps.BitmapDescriptor icon =
          google_maps.BitmapDescriptor.fromBytes(iconBytes);

      // Future<Uint8List> svgToPngBytes(String svgAssetPath, double width, double height) async {
      //   final DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgAssetPath!, 'null');
      //   final ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));
      //   final ui.Image image = await picture.toImage(width.toInt(), height.toInt());
      //   final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      //   return byteData!.buffer.asUint8List();
      // }
      // Future<google_maps.BitmapDescriptor> svgToIcon(String svgString, {int size = 100}) async {
      //   // Usar uma chave de cache vazia para svg.fromSvgString
      //   final DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, "");
      //
      //   // Criar um Picture a partir do SVG
      //   final ui.Picture picture = svgDrawableRoot.toPicture(size: Size(size.toDouble(), size.toDouble()));
      //
      //   // Converter o Picture em uma imagem rasterizada
      //   final ui.Image image = await picture.toImage(size, size);
      //
      //   // Obter os bytes da imagem como PNG
      //   final ByteData? bytesData = await image.toByteData(format: ui.ImageByteFormat.png);
      //
      //   // Garantir que bytesData não é nulo antes de prosseguir
      //   if (bytesData != null) {
      //     final Uint8List bytes = bytesData.buffer.asUint8List();
      //
      //     // Criar um BitmapDescriptor a partir dos bytes para uso como ícone
      //     return google_maps.BitmapDescriptor.fromBytes(bytes);
      //   } else {
      //     // Se bytesData for nulo, retorne um ícone padrão ou lance um erro
      //     throw Exception("Failed to convert SVG to bytes.");
      //   }
      // }

      // Future<google_maps.BitmapDescriptor> svgToIcon(String svgString, {int size = 100}) async {
      //   final svgDrawableRoot = await svg.fromSvgString(svgString, "");
      //   final picture = svgDrawableRoot.toPicture(size: Size(size.toDouble(), size.toDouble()));
      //   final image = await picture.toImage(size, size);
      //   final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      //   final Uint8List bytes = byteData!.buffer.asUint8List();
      //   return google_maps.BitmapDescriptor.fromBytes(bytes);
      // }

      // Future svgToPng(String svgString,
      //     {int? svgWidth, int? svgHeight}) async {
      //   DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, "key");
      //   // Parse the SVG file as XML
      //   XmlDocument document = XmlDocument.parse(svgString);
      //   // Getting size of SVG
      //   final svgElement = document.findElements("svg").first;
      //   final svgWidth = double.parse(svgElement.getAttribute("width")!);
      //   final svgHeight = double.parse(svgElement.getAttribute("height")!);
      //   // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
      //   double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
      //   double width = svgHeight * devicePixelRatio;
      //   double height = svgWidth * devicePixelRatio;
      //   // Convert to ui.Picture
      //   final picture = svgDrawableRoot.toPicture(size: Size(width, height));
      //   // Convert to ui.Image. toImage() takes width and height as parameters
      //   // you need to find the best size to suit your needs and take into account the screen DPI
      //   final image = await picture.toImage(width.toInt(), height.toInt());
      //   ByteData? bytes = await image.toByteData(format: ImageByteFormat.png);
      //   return bytes!.buffer.asUint8List();
      // }

      // // String svgString = '<svg width="512" height="512" viewBox="0 0 512 612 fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M319 160V160.535L319.445 160.832L497.245 279.332L497.247 279.333C505.864 285.046 511 294.73 511 305.1V361.8C511 372.011 500.975 379.238 491.215 376.051C491.214 376.051 491.212 376.05 491.211 376.049L320.316 319.051L319 318.612V320V400V400.5L319.4 400.8L377 444C380.748 446.811 383 451.315 383 456V498C383 505.243 377.152 511 370 511C368.809 511 367.596 510.818 366.35 510.531L256.275 479.039L256 478.96L255.725 479.039L145.625 510.539L145.615 510.541L145.606 510.544C144.44 510.903 143.252 511 142 511C134.757 511 129 505.152 129 498V456C129 451.315 131.252 446.811 135 444L192.6 400.8L193 400.5V400V320V318.612L191.684 319.051L20.7893 376.049C20.788 376.05 20.7868 376.05 20.7856 376.051C11.0261 379.239 1 372.011 1 361.8V305.1C1 294.73 6.13596 285.046 14.7525 279.333L14.7546 279.332L192.555 160.832L193 160.535V160V93.7C193 76.8245 200.176 53.5773 211.73 34.5439C217.501 25.037 224.335 16.6312 231.859 10.6121C239.382 4.59345 247.544 1 256 1C273.443 1 289.183 15.4573 300.643 34.5398C312.07 53.5684 319 76.8173 319 93.7V160Z" fill="#0C5905" stroke="black" stroke-width="2"/><text x="50%" y="90%" dominant-baseline="middle" text-anchor="middle" font-family="Arial" font-size="80" font-weight="bold" fill="white" stroke="black" stroke-width="3">Sua Legenda</text></svg>';
      // String svgString = marcador['nome'];
      // // // svgString = svgString.replaceAll(r'\N', ''); // Remove \N
      // // // svgString = svgString.replaceAll(r'\\', ''); // Remove todas as barras invertidas
      // //
      // //
      //
      //
      // Uint8List imageBytes = await svgToImageBytes(svgString, size: 100);
      //
      // google_maps.BitmapDescriptor icon = google_maps.BitmapDescriptor.fromBytes(imageBytes);

      // google_maps.BitmapDescriptor icon = await svgToIcon(svgString, size: 100);

      // Coletar os nomes das profundidades em uma string
      String nomesProfundidades = marcador["profundidades"]!
          .map((profundidade) => profundidade["nome"]!.toString())
          .join(", "); // Junta os nomes com vírgula e espaço

      // String nomesProfundidades = latLngListMarcadores.firstWhere((element) => element['marcador_nome'] == marcador["marcador_nome"])['profundidades'].map((profundidade) => profundidade["nome"]!).join(", ");
      // Inicializar markerPositions com a posição original
      markerPositions[marcador["marcador_nome"]!] = position;

      var marker = google_maps.Marker(
        markerId: markerId,
        position: position,
        icon: icon,
        onTap: () {
          focoNoMarcador = true;
          latlngMarcador = google_maps.LatLng(
              double.parse(latlng[0]), double.parse(latlng[1]));

          _onMarkerTapped(markerId, marcador["marcador_nome"]!);
        },
        infoWindow: google_maps.InfoWindow(
          title: "PONTO : " + marcador["marcador_nome"]!,
          snippet: "Profundidades de coleta: " + nomesProfundidades,
        ),
        draggable: false,
      );

      setState(() {
        markers.add(marker);
      });
    }
  }

//double tap, ou seja, dois clicks no marker para abrir
  void _onMarkerTapped(google_maps.MarkerId markerId, String markerName) {
    print("Marker tapped: $markerName");
    DateTime now = DateTime.now();
    String markerIdValue = markerId.value;

    // Retrieve the position of the tapped marker
    google_maps.LatLng markerLatLng = markerPositions[markerIdValue]!;
    latlngMarcador = markerPositions[markerIdValue]!;

    // Calculate the distance between the user's current location and the marker
    double distance = Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      markerLatLng.latitude,
      markerLatLng.longitude,
    );

    // Check if the last tap was within 1.8 seconds to consider it a double tap
    // if (lastTapTimestamps.containsKey(markerIdValue) &&
    //     now.difference(lastTapTimestamps[markerIdValue]!).inMilliseconds <
    //         1800) {
    // Check if the distance is greater than 30 meters
    //if (distance > 35000) {
    //metros de distancia para coletar
    // Show alert

    // _showDistanceAlert();
    //} else {
    // Continue with the normal double tap logic
    _showModalOptions(markerName);
    //}
    // }

    // Update the timestamp of the last tap
    lastTapTimestamps[markerIdValue] = now;
  }

  void _showDistanceAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aproxime-se do ponto!'),
          content: Text('Você está a mais de 30 metros do ponto de coleta.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _addUserMarker(google_maps.LatLng position) {
    final userLocationMarker = google_maps.Marker(
      markerId: const google_maps.MarkerId('current_location'),
      position: position,
      onTap: () {
        focoNoMarcador = false;
      },
      alpha: 0.0,
    );

    setState(() {
      markers.add(userLocationMarker);
    });
  }

  void _trackUserLocation() {
    _positionStreamSubscription = Geolocator.getPositionStream().listen(
      (Position position) {
        setState(() {
          _currentPosition = position;
          _updateUserLocationMarker(
              position); // Método para atualizar o marcador
          _updateMapLocation();
        });
      },
    );
  }

  void _updateUserLocationMarker(Position position) {
    final userLocationMarker = google_maps.Marker(
      markerId: const google_maps.MarkerId('current_location'),
      position: google_maps.LatLng(position.latitude, position.longitude),
      alpha: 0.0,
      icon: google_maps.BitmapDescriptor.defaultMarker,
    );

    setState(() {
      markers.removeWhere((marker) =>
          marker.markerId == google_maps.MarkerId('current_location'));
      markers.add(userLocationMarker);
    });
  }

  void _updateMapLocation() {
    if (_currentPosition != null && _googleMapController != null) {
      _googleMapController!.animateCamera(
        google_maps.CameraUpdate.newCameraPosition(
          google_maps.CameraPosition(
            target: focoNoMarcador == false
                ? google_maps.LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude)
                : google_maps.LatLng(
                    latlngMarcador!.latitude, latlngMarcador!.longitude),
            zoom: _currentZoom,
          ),
        ),
      );
    }
  }

  void _showModalOptions(String idMarcador) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: EdgeInsets.all(20),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Ponto: $idMarcador",
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.close,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 36,
                ),
              ),
            ],
          ),
          content: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildElevatedButton(
                    context, "Fazer uma coleta", Color(0xFF00736D), () {
                  Navigator.of(context).pop();
                  _ontapColetar(idMarcador);
                }),
                SizedBox(height: 10),
                _buildElevatedButton(
                    context, "Coleta inacessível", Color(0xFF9D291C), () {
                  Navigator.of(context).pop();
                  _ontapInacessivel(idMarcador);
                }),
                // SizedBox(height: 10),
                // _buildElevatedButton(context, "Criar Ponto", Colors.blue, () {
                //   Navigator.of(context).pop();
                //   // _adicionarNovoPonto();
                //   _showAdicionaProfundidades();
                //   _showTutorialModal();
                // }),
                // SizedBox(height: 10),
                // _buildElevatedButton(context, "Tirar Foto", Colors.orange, () {
                //   Navigator.of(context).pop();
                //   _tiraFoto(idMarcador);
                // }),
              ],
            ),
          ),
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 5,
        );
      },
    );
  }

  void _tiraFoto(String nomeMarcadorAtual, String nomeProfundidade,
      String latlng, String referencialProfundidadePontoId) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      // final bytes = await image.readAsBytes();
      Uint8List bytes = await image.readAsBytes();

      // Utiliza a biblioteca 'image' para decodificar a imagem
      img.Image? originalImage = img.decodeImage(bytes);

      if (originalImage != null) {
        // Redimensiona a imagem para 33% da sua qualidade original
        img.Image resizedImage = img.copyResize(originalImage,
            width: (originalImage.width * 0.23).round(),
            height: (originalImage.height * 0.23).round());

        // Converte a imagem redimensionada de volta para bytes como PNG
        List<int> resizedBytes = img.encodePng(resizedImage);

        // Converte os bytes da imagem redimensionada para uma string base64
        String base64Image = base64Encode(Uint8List.fromList(resizedBytes));

        setState(() {
          // Encontra o marcador pelo nome
          int indexMarcador = latLngListMarcadores.indexWhere(
              (marcador) => marcador['marcador_nome'] == nomeMarcadorAtual);

          if (indexMarcador != -1) {
            latLngListMarcadores[indexMarcador]['foto_de_cada_profundidade']
                .add({
              'nome': nomeProfundidade,
              'foto': 'data:image/png;base64,base64Image',
              // 'foto': 'data:image/png;base64,$base64Image',
            });
            pontosColetados.add({
              "marcador_nome": nomeMarcadorAtual,
              "profundidade": nomeProfundidade,
              "foto": 'base64Image',
              "latlng": '$latlng',
              "id_ref": referencialProfundidadePontoId,
              "obs": ""
            });
            FFAppState().PontosColetados.add({
              "marcador_nome": nomeMarcadorAtual,
              "profundidade": nomeProfundidade,
              "foto": 'base64Image',
              "foto": '$base64Image',
              "latlng": '$latlng',
              "id_ref": referencialProfundidadePontoId,
              "obs": ""
            });

            coletasPorMarcador.putIfAbsent(nomeMarcadorAtual, () => {});
            coletasPorMarcador[nomeMarcadorAtual]!.add(nomeProfundidade);

            // Verifica se todas as profundidades foram coletadas
            var todasProfundidades = latLngListMarcadores
                .firstWhere((m) => m["marcador_nome"] == nomeMarcadorAtual)[
                    "profundidades"]
                .map((p) => p["nome"])
                .toSet();

            if (coletasPorMarcador[nomeMarcadorAtual]!
                .containsAll(todasProfundidades)) {
              // Todas as profundidades coletadas, mude a cor do marcador para verde
              _updateMarkerColor(nomeMarcadorAtual, true);
              setState(() {
                vezAtualDoIntervaloDeColeta += 1;
              });
            }
            ;

            // Navigator.of(context).pop(); // Fecha o modal atual
            // _mostrarModalSucesso(context, nomeMarcadorAtual);
          }
        });
      }
      // setState(() {
      //   pontosColetados.add({
      //     "marcador_nome": nomeMarcadorAtual,
      //     "profundidade": nomeProfundidade,
      //     "foto": 'fotoBase64',
      //   });
      // });
    }
    Navigator.of(context).pop(); // Fecha o modal atual
    _showModalObservacoes(
        nomeMarcadorAtual, referencialProfundidadePontoId, nomeProfundidade);
    // Navigator.of(context).pop(); // Fecha o modal atual
  }

  void _showModalObservacoes(String marcadorNome,
      String referencialProfundidadePontoId, String nomeProfundidade) {
    TextEditingController _observacaoController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Deseja adicionar observação?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: _observacaoController,
            decoration: InputDecoration(
              hintText: "Digite sua observação aqui...",
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Ação para "Não"

                Navigator.of(context).pop();
                _mostrarModalSucesso(context, marcadorNome);
              },
              child: Text("Não"),
            ),
            TextButton(
              onPressed: () {
                var pontoColetado = FFAppState().PontosColetados.firstWhere(
                      (element) =>
                          element['marcador_nome'] == marcadorNome &&
                          element['profundidade'] == nomeProfundidade,
                      orElse: () => null,
                    );

                if (pontoColetado != null) {
                  pontoColetado['obs'] = _observacaoController.text;
                }

                print("Observação adicionada: ${_observacaoController.text}");

                // Fechando o modal
                Navigator.of(context).pop();
                _mostrarModalSucesso(context, marcadorNome);
              },
              child: Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  void _showAdicionaProfundidades() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selecione as Profundidades'),
          content: SingleChildScrollView(
            child: ListBody(
              children: possiveisProfundidades.map((String value) {
                return CheckboxListTile(
                  title: Text(value),
                  value: profundidadesSelecionadas.contains(value),
                  onChanged: (bool? selected) {
                    setState(() {
                      if (selected ?? false) {
                        profundidadesSelecionadas.add(value);
                      } else {
                        profundidadesSelecionadas.remove(value);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                // Aqui você pode chamar um método para adicionar um novo ponto
                // ou fazer outra ação com as profundidades selecionadas.
              },
            ),
          ],
        );
      },
    );
  }

  void _showTutorialModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tutorial'),
          content:
              Text('Clique 1 vez no local onde queira adicionar um novo ponto'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isAddingPoint = true; // Enable map tap for adding a new point
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _onMapTap(google_maps.LatLng position) {
    if (isAddingPoint) {
      _addNewPointAtPosition(position);
      setState(() {
        isAddingPoint = false; // Reset the flag
      });
    }
  }

  void _addNewPointAtPosition(google_maps.LatLng position) {
    String novoNomeMarcador = _gerarNomeNovoMarcador();

    Map<String, dynamic> novoPonto = {
      "marcador_nome": "$novoNomeMarcador",
      "latlng_marcadores": "${position.latitude}, ${position.longitude}",
      "profundidades": profundidadesSelecionadas.map((profundidade) {
        return {
          "nome": profundidade ?? '0-10',
          "icone": "location_dot",
          "cor": "#FFC0CB"
        };
      }).toList(),
    };

    String pontoSerializado =
        json.encode(novoPonto); // Converte o mapa para JSON
    String pontoParaSalvar =
        "$pontoSerializado"; // Adiciona aspas simples ao redor da string JSON
    FFAppState().listaDeLocaisDeAreasParaColeta.add(pontoParaSalvar);

    setState(() {
      latLngListMarcadores.add(novoPonto);
      //converter para entrar no ffappstate
      markerPositions[novoNomeMarcador] = position; // Adicione esta linha

      String nomesProfundidades = novoPonto["profundidades"]!
          .map((profundidade) => profundidade["nome"]!)
          .join(", "); // Junta os nomes com vírgula e espaço

      var newMarker = google_maps.Marker(
        markerId: google_maps.MarkerId(novoNomeMarcador),
        position: position,
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
            google_maps.BitmapDescriptor.hueRed),
        onTap: () {
          focoNoMarcador = true;
          latlngMarcador =
              google_maps.LatLng(position.latitude, position.longitude);

          _onMarkerTapped(google_maps.MarkerId(novoNomeMarcador),
              novoPonto["marcador_nome"]!);
        },
        infoWindow: google_maps.InfoWindow(
          title: "PONTO: $novoNomeMarcador",
          snippet: "Lista de profundidades: " + nomesProfundidades,
        ),
      );

      markers.add(newMarker);
    });
  }

  Widget _buildElevatedButton(
      BuildContext context, String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      child: Text(
        text,
        style: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Readex Pro',
              color: Colors.white,
            ),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 3,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      ),
    );
  }

  void _ontapColetar(String marcadorNome) {
    _showProfundidadesParaColeta(marcadorNome);
  }

  Map<String, IconData> faIcons = {
    "location_dot": FontAwesomeIcons.locationDot,
    "flag": FontAwesomeIcons.flag,
    "map_pin": FontAwesomeIcons.mapPin,
    "plane": FontAwesomeIcons.plane,
    "campground": FontAwesomeIcons.campground,
    "anchor": FontAwesomeIcons.anchor,
    "land_mine_on": FontAwesomeIcons.landMineOn,
  };

  IconData getFontAwesomeIconByName(String iconName) {
    return faIcons[iconName] ?? FontAwesomeIcons.questionCircle; // Ícone padrão
  }

  void _showProfundidadesParaColeta(String marcadorNome) {
    // Encontra o marcador pelo nome
    var marcador = latLngListMarcadores.firstWhere(
      (m) => m["marcador_nome"] == marcadorNome,
      orElse: () =>
          <String, Object>{}, // Correção aqui para alinhar com o tipo esperado
    );

    if (marcador.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          var profundidades = marcador["profundidades"] as List<dynamic>? ?? [];

          // var img =
          // String base64Icon = FFAppState().profundidades.where((element) => element['prof_icone'] == marcador['profundidades']['icone']).map((e) => e['prof_imagem']).toString();
          // String base64Icon = marcador["profundidades"]["icone"].toString();
          // String base64Icon = profundidade["icnone"];

          // marcador["profundidades"]["icone"];
          // Uint8List iconBytes = base64Decode(base64Icon);
          // var iconBytes = resizeImage(base64Icon, 50, 50);
          var latlng = marcador["latlng_marcadores"];

          // google_maps.BitmapDescriptor icon =
          //     google_maps.BitmapDescriptor.fromBytes(iconBytes);

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            titlePadding: EdgeInsets.all(20),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Coletar profundidades para ${marcador["marcador_nome"]}",
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 36,
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: profundidades.map<Widget>((profundidade) {
                  var iconBytes = resizeImage(profundidade["icone"], 50, 50);
                  var referencialProfundidadePontoId = '1';

                  // profundidade["prof_id"].toString();
                  // bool jaColetada = coletasPorMarcador[marcadorNome]
                  //         ?.contains(profundidade["nome"]) ??
                  //     false;

                  bool jaColetada =
                      FFAppState().PontosColetados.any((pontoColetado) {
                    return pontoColetado['marcador_nome'].toString() ==
                            marcadorNome.toString() &&
                        pontoColetado['profundidade'].toString() ==
                            profundidade["nome"];
                  });

                  // Verificação adicional para 'pontosJaColetados'
                  if (!jaColetada && widget.pontosJaColetados != null) {
                    jaColetada = widget.pontosJaColetados!.any((pontoString) {
                      try {
                        var pontoMap =
                            json.decode(pontoString) as Map<dynamic, dynamic>;
                        return pontoMap["marcador_nome"].toString() ==
                            marcadorNome;
                        // &&
                        // pontoMap["profundidade"].toString() ==
                        //     profundidade["nome"].toString();
                      } catch (e) {
                        print("Erro ao decodificar ponto: $e");
                        return false;
                      }
                    });
                  }

                  return Row(
                    children: [
                      Image.memory(iconBytes, width: 20, height: 50),
                      SizedBox(width: 10),
                      Text(profundidade["nome"]),
                      Spacer(),
                      _buildElevatedButton(
                        context,
                        jaColetada ? "Coletada" : "Coletar",
                        jaColetada ? Color(0xFF9D291C) : Color(0xFF00736D),
                        () {
                          if (jaColetada) {
                            _confirmarRecoleta(
                                context,
                                marcadorNome,
                                profundidade["nome"],
                                latlng,
                                referencialProfundidadePontoId);
                          } else {
                            _confirmarColeta(
                                context,
                                marcadorNome,
                                profundidade["nome"],
                                latlng,
                                referencialProfundidadePontoId);
                          }
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 5,
          );
        },
      );
    }
  }

  String _gerarNomeNovoMarcador() {
    if (latLngListMarcadores.isEmpty) {
      return "A";
    }

    // Converte todos os nomes de marcadores em uma lista de listas de inteiros (0-25)
    List<List<int>> marcadoresNumericos =
        latLngListMarcadores.map<List<int>>((marcador) {
      String nomeMarcador = marcador["marcador_nome"]
          as String; // Garante que o nome é uma String
      return nomeMarcador.split('').map<int>((String char) {
        return char.codeUnitAt(0) - 'A'.codeUnitAt(0); // Conversão para int
      }).toList();
    }).toList();

    // Encontra o último nome de marcador e o converte para a representação numérica
    List<int> ultimoMarcadorNumerico = marcadoresNumericos.last;

    // Incrementa o último valor
    int index = ultimoMarcadorNumerico.length - 1;
    while (index >= 0) {
      if (ultimoMarcadorNumerico[index] < 25) {
        // Menor que 'Z'
        ultimoMarcadorNumerico[index]++;
        break;
      } else {
        ultimoMarcadorNumerico[index] =
            0; // Reseta para 'A' e incrementa o próximo caractere
        if (index == 0) {
          ultimoMarcadorNumerico.insert(
              0, 0); // Insere um novo 'A' se todos os caracteres forem 'Z'
          break;
        }
        index--;
      }
    }

    // Converte de volta para string
    return String.fromCharCodes(
      ultimoMarcadorNumerico.map((n) => n + 'A'.codeUnitAt(0)),
    );
  }

  void _confirmarRecoleta(
      BuildContext context,
      String marcadorNome,
      String profundidadeNome,
      String latlng,
      String referencialProfundidadePontoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Recoleta"),
          content: Text("Deseja coletar essa profundidade novamente?"),
          actions: <Widget>[
            TextButton(
              child: Text("Não"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              child: Text("Sim"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                _tiraFoto(marcadorNome, profundidadeNome, latlng,
                    referencialProfundidadePontoId);
                _coletarProfundidade(marcadorNome, profundidadeNome, latlng,
                    referencialProfundidadePontoId); // Realiza a coleta
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmarColeta(
      BuildContext context,
      String marcadorNome,
      String profundidadeNome,
      String latlng,
      String referencialProfundidadePontoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Efetuar coleta'),
          content: Text('Deseja realmente efetuar esta coleta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (podeTirarFoto) {
                  if (vezAtualDoIntervaloDeColeta >=
                          intervaloDeColetaParaProximaFoto ||
                      vezAtualDoIntervaloDeColeta == 0) {
                    _tiraFoto(marcadorNome, profundidadeNome, latlng,
                        referencialProfundidadePontoId);
                    setState(() {
                      vezAtualDoIntervaloDeColeta = 0;
                    });
                    // _coletarProfundidade(marcadorNome, profundidadeNome, latlng,
                    //     referencialProfundidadePontoId);
                  } else {
                    _coletarProfundidade(marcadorNome, profundidadeNome, latlng,
                        referencialProfundidadePontoId);
                  }
                } else {
                  _coletarProfundidade(marcadorNome, profundidadeNome, latlng,
                      referencialProfundidadePontoId);
                }
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  void _coletarProfundidade(String marcadorNome, String profundidadeNome,
      String latlng, String referencialProfundidadePontoId) {
    setState(() {
      pontosColetados.add({
        "marcador_nome": marcadorNome,
        "profundidade": profundidadeNome,
        "foto": '',
        "latlng": latlng,
        "id_ref": '$referencialProfundidadePontoId',
        "obs": ""
      });
      FFAppState().PontosColetados.add({
        "marcador_nome": marcadorNome,
        "profundidade": profundidadeNome,
        // "foto": '$base64Image',
        "foto": '',
        "latlng": latlng,
        "id_ref": '$referencialProfundidadePontoId',
        "obs": ""
      });

      coletasPorMarcador.putIfAbsent(marcadorNome, () => {});
      coletasPorMarcador[marcadorNome]!.add(profundidadeNome);

      // Verifica se todas as profundidades foram coletadas
      var todasProfundidades = latLngListMarcadores
          .firstWhere(
              (m) => m["marcador_nome"] == marcadorNome)["profundidades"]
          .map((p) => p["nome"])
          .toSet();

      if (coletasPorMarcador[marcadorNome]!.containsAll(todasProfundidades)) {
        // Todas as profundidades coletadas, mude a cor do marcador para verde
        _updateMarkerColor(marcadorNome, true);
        setState(() {
          vezAtualDoIntervaloDeColeta += 1;
        });
      }
    });
    Navigator.of(context).pop(); // Fecha o modal atual
    _mostrarModalSucesso(context, marcadorNome);
  }

  void _mostrarModalSucesso(BuildContext context, String marcadorNome) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 0, milliseconds: 940), () {
          Navigator.of(context).pop(); // Fecha o modal de sucesso
          _showProfundidadesParaColeta(
              marcadorNome); // Reabre o modal de coletas
        });

        return AlertDialog(
          title: Text('Sucesso'),
          content: Text('Profundidade coletada!'),
        );
      },
    );
  }

  void _updateMarkerColor(String marcadorNome, bool todasColetadas) {
    var iconBytes = resizeImage(
        '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',
        80,
        80);

    var newIcon = todasColetadas
        ? google_maps.BitmapDescriptor.fromBytes(iconBytes)
        : google_maps.BitmapDescriptor.defaultMarkerWithHue(
            google_maps.BitmapDescriptor.hueRed);

    setState(() {
      markers = markers.map((m) {
        if (m.markerId.value == marcadorNome) {
          return m.copyWith(iconParam: newIcon);
        }
        return m;
      }).toSet();
    });
  }

  void _ontapInacessivel(String marcadorNome) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: EdgeInsets.all(20),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Opções para o ponto $marcadorNome",
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.close,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 36,
                ),
              ),
            ],
          ),
          content: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildElevatedButton(context, "Mover", Color(0xFF9D291C), () {
                  Navigator.of(context).pop();
                  _enableMarkerDrag(marcadorNome);
                }),
                SizedBox(height: 10),
                _buildElevatedButton(
                    context, "Excluir Ponto", Color(0xFF9D291C), () {
                  Navigator.of(context).pop();
                  _removeMarker(marcadorNome);
                }),
                // SizedBox(height: 10),
                // _buildElevatedButton(
                //     context, "Criar novo ponto", Color(0xFF9D291C), () {
                //   Navigator.of(context).pop();
                //   // _adicionarNovoPonto();
                //   _showAdicionaProfundidades();
                //   _showTutorialModal();
                // }),
              ],
            ),
          ),
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 5,
        );
      },
    );
  }

  void _enableMarkerDrag(String marcadorNome) {
    setState(() {
      markers = markers.map((m) {
        if (m.markerId.value == marcadorNome) {
          return m.copyWith(
              draggableParam: true,
              onDragEndParam: (newPosition) {
                // Atualiza a posição no markerPositions e atualiza a posição geral
                markerPositions[marcadorNome] = newPosition;
                latlngMarcador = newPosition; // Atualiza latlngMarcador
                // //atualiza geral
                //   FFAppState().pontosDeColeta.where((e) => e['artp_id'] == int.parse(marcadorNome))
                //       .map((e) => e['artp_latitude_longitude'] = '${newPosition.latitude}, ${newPosition.longitude}');
                //   latLngListMarcadores.where((e) => e['marcador_nome'] == marcadorNome)
                //       .map((e) => e['latlng_marcadores'] = '${newPosition.latitude}, ${newPosition.longitude}');

                // Encontra e atualiza o ponto correspondente em FFAppState().pontosDeColeta
                // Atualiza diretamente FFAppState().pontosDeColeta
                for (var ponto in FFAppState().pontosDeColeta) {
                  if (ponto['artp_id'].toString() == marcadorNome) {
                    ponto['artp_latitude_longitude'] =
                        "${newPosition.latitude}, ${newPosition.longitude}";
                    // break; // Assumindo que só há um ponto com esse 'artp_id'
                  }
                }

                // Atualiza a posição do marcador na lista latLngListMarcadores
                int indexLatlng = latLngListMarcadores.indexWhere(
                    (marcador) => marcador["marcador_nome"] == marcadorNome);
                if (indexLatlng != -1) {
                  latLngListMarcadores[indexLatlng]["latlng_marcadores"] =
                      "${newPosition.latitude}, ${newPosition.longitude}";
                }

                // Adiciona à lista de pontos movidos
                var latLngOriginal = latLngListMarcadores.firstWhere((map) =>
                    map["marcador_nome"] == marcadorNome)["latlng_marcadores"];
                if (latLngOriginal != null) {
                  pontosMovidos.add({
                    "marcador_nome": marcadorNome,
                    "latlng_original": latLngOriginal,
                    "latlng_movido_para":
                        "${newPosition.latitude}, ${newPosition.longitude}"
                  });
                }

                // Atualiza a posição da câmera para a nova localização do marcador
                _updateMapLocationAfterMarkerMove(newPosition, marcadorNome);
              });
        }
        return m;
      }).toSet();
    });
  }

  void _updateMapLocationAfterMarkerMove(
      google_maps.LatLng newPosition, String marcadorNome) {
    if (_googleMapController != null) {
      _googleMapController!.animateCamera(
        google_maps.CameraUpdate.newCameraPosition(
          google_maps.CameraPosition(
            target: newPosition,
            zoom: _currentZoom,
          ),
        ),
      );
    }

    // //atualiza geral
    // FFAppState().pontosDeColeta.where((e) => e['artp_id'] == int.parse(marcadorNome))
    //     .map((e) => e['artp_latitude_longitude'] = '${newPosition.latitude}, ${newPosition.longitude}');
    // latLngListMarcadores.where((e) => e['marcador_nome'] == int.parse(marcadorNome))
    //     .map((e) => e['latlng_marcadores'] = '${newPosition.latitude}, ${newPosition.longitude}');
  }

  void _removeMarker(String marcadorNome) {
    var latLng = markerPositions[marcadorNome];

    pontosExcluidos.add({
      "marcador_nome": marcadorNome,
      "latlng": "${latLng?.latitude}, ${latLng?.longitude}"
    });
    setState(() {
      markers.removeWhere((m) => m.markerId.value == marcadorNome);
      markerPositions.remove(marcadorNome);
    });
  }

//muda o foco
  void mudaFoco() {
    focoNoMarcador = false;
  }

  // Widget _exibirDados() {
  //   return Column(
  //     children: [
  //       Text(
  //         "Pontos: ${jsonEncode(latLngListMarcadores)}",
  //         style: TextStyle(
  //           color: Colors.yellow, // Define a cor vermelha
  //           fontSize: 12.0, // Define o tamanho da fonte como 8
  //         ),
  //       ),
  //       Text(
  //         "Pontos Movidos: ${jsonEncode(pontosMovidos)}",
  //         style: TextStyle(
  //           color: Colors.yellow, // Define a cor vermelha
  //           fontSize: 12.0, // Define o tamanho da fonte como 8
  //         ),
  //       ),
  //       Text(
  //         "Pontos Coletados: ${jsonEncode(pontosColetados)}",
  //         style: TextStyle(
  //           color: Colors.yellow, // Define a cor vermelha
  //           fontSize: 12.0, // Define o tamanho da fonte como 8
  //         ),
  //       ),
  //       Text(
  //         "Pontos Excluídos: ${jsonEncode(pontosExcluidos)}",
  //         style: TextStyle(
  //           color: Colors.yellow, // Define a cor vermelha
  //           fontSize: 12.0, // Define o tamanho da fonte como 8
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Aqui você pode implementar qualquer lógica adicional necessária
          // antes de permitir o comportamento padrão de voltar.
          final shouldPop = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Você tem certeza que quer sair da coleta?'),
              content: Text(''),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pop(false), // Não permite sair da tela
                  child: Text('Não'),
                ),
                TextButton(
                  onPressed: () {
                    // Permite sair da tela e redireciona
                    Navigator.of(context)
                        .pop(true); // Primeiro, fecha o diálogo
                    // Substitua 'blankRedirecona' pelo nome da rota para a qual você deseja navegar
                    // return true;
                    // setState(() {
                    //   FFAppState().contornoFazenda =
                    //       FFAppState().contornoFazenda.toList().cast<dynamic>();
                    //   FFAppState().grupoContornoFazendas =
                    //       FFAppState().grupoContornoFazendas.toList().cast<dynamic>();
                    // });
                    setState(() {});
                  },
                  child: const Text('Sim'),
                ),
              ],
            ),
          ); // Permite o comportamento padrão de voltar.
          return shouldPop ?? false;
        },
        child: Scaffold(
            body: Stack(
          children: [
            Container(
              width: widget.width ?? double.infinity,
              height: widget.height ?? double.infinity,
              child: google_maps.GoogleMap(
                initialCameraPosition: google_maps.CameraPosition(
                  target: google_maps.LatLng(
                      position?.latitude ?? 0.0, position?.longitude ?? 0.0),
                  zoom: _currentZoom,
                ),
                onMapCreated: (controller) {
                  _googleMapController = controller;
                  _onMapCreated(controller);
                },
                onTap: _onMapTap,
                onCameraMove: _onCameraMove,
                polygons: polygons,
                markers: markers,
                myLocationEnabled: true,
                mapType: google_maps.MapType.satellite,
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
              ),
            ),
            Positioned(
              top: 202,
              right: 16,
              child: ElevatedButton(
                onPressed: mudaFoco,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Color(0xFF00736D),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.center_focus_strong_sharp,
                      size: 25.0,
                      color: Colors.white,
                    )),
              ),
            ),
            // Positioned(
            //   bottom: 10,
            //   left: 10,
            //   right: 10,
            //   child: ElevatedButton(
            //     onPressed: _exibirDados,
            //     style: ElevatedButton.styleFrom(
            //       shape: CircleBorder(),
            //       backgroundColor: Color(0xFF00736D),
            //     ),
            //     child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Icon(
            //           Icons.info,
            //           size: 25.0,
            //           color: Colors.white,
            //         )),
            //   ),
            // )
          ],
        )));
  }

  void _exibirDados() {
    // var filtroPontosLatLngDeContorno = FFAppState()
    //     .listaContornoColeta
    //     .where((item) => item['oserv_id'] == 38)
    //     .map((item) => item['talcot_latitude_longitude'])
    //     .toList();
    // var filtroPontosColeta = FFAppState()
    //     .pontosDeColeta
    //     .where((item) => item['oserv_id'] == int.parse(widget.idContorno!))
    //     .toList();

    // latLngListMarcadores = filtroPontosColeta.map((item) {
    //   // Busca por profundidadesPontos relacionadas ao ponto de coleta atual
    //   var profundidadesPontosProfIds = FFAppState()
    //       .profundidadesPonto
    //       .where((coleta) => coleta['trpp_artp_id'] == item['artp_id'])
    //       .map((e) => e['trpp_prof_id']);
    //
    //   // Para cada profundidadePontosProfId, encontra as informações correspondentes em profundidades
    //   var profundidadesLista = profundidadesPontosProfIds
    //       .map((profId) {
    //         var profundidade = FFAppState().profundidades.firstWhere(
    //             (prof) => prof['prof_id'] == profId,
    //             orElse: () => null);
    //
    //         return profundidade != null
    //             ? {
    //                 "nome": profundidade['prof_nome'],
    //                 "icone": profundidade['prof_imagem'],
    //                 "cor": profundidade['prof_cor'] ?? "#FFFFFF",
    //                 "prof_id": profId,
    //               }
    //             : null;
    //       })
    //       .where((element) => element != null)
    //       .toList();
    //
    //   var perfilProfundidade = FFAppState().perfilprofundidades.firstWhere(
    //       (perfil) => perfil['pprof_id'] == item['artp_id_perfil_prof'],
    //       orElse: () => null);
    //
    //   var imagemProfundidade = '';
    //   if (perfilProfundidade != null) {
    //     var profundidade = FFAppState().profundidades.firstWhere(
    //         (prof) => prof['prof_id'] == perfilProfundidade['pprof_prof_id'],
    //         orElse: () => null);
    //
    //     if (profundidade != null) {
    //       imagemProfundidade = profundidade['prof_imagem'];
    //     }
    //   }
    //
    //   // Retorna o mapa com as informações do ponto de coleta e as profundidades associadas
    //   return {
    //     "marcador_nome": "${item['artp_id']}",
    //     "icone": imagemProfundidade, // A imagem de profundidade
    //     "latlng_marcadores": "${item['artp_latitude_longitude']}",
    //     "profundidades": profundidadesLista, // Lista de profundidades
    //     "foto_de_cada_profundidade": [],
    //   };
    // }).toList();

    //
    // var lat = latLngListMarcadores.where((e) => e['marcador_nome'] == 4120)
    //     .map((e) => e['latlng_marcadores'] = '-29.91494505823483, -51.19616432043194');
    //     // .toList();
    //   var lng = FFAppState().pontosDeColeta.where((e) => e['artp_id'] == 4120)
    //       .map((e) => e['artp_latitude_longitude'] = '-29.91494505823483, -51.19616432043194');
    //       // .toList();
//     var filtroPontosColeta = FFAppState()
//         .pontosDeColeta
//         .where((item) => item['oserv_id'] == 4)
//         .map((item) => item as Map<String, dynamic>) // Adiciona esta linha
//         .toList();
//
//     // latLngListMarcadores = filtroPontosColeta;
//
//     List<Map<String, dynamic>> substituirIcone(
//         List<Map<String, dynamic>> pontosColeta) {
//       return pontosColeta.map((ponto) {
//         // Substituir o icone do marcador
//         var iconeMarcador = FFAppState().icones.firstWhere(
//               (icone) =>
//                   icone['ico_id'].toString() == ponto['icone'].toString(),
//               orElse: () => {
//                 'ico_base64': ''
//               }, // Fornecer um valor padrão caso não encontre
//             )['ico_base64'];
//
//         // Substituir o icone de cada profundidade
//         var profundidadesAtualizadas =
//             (ponto['profundidades'] as List<dynamic>).map((profundidade) {
//           var iconeProfundidade = FFAppState().icones.firstWhere(
//                 (icone) =>
//                     icone['ico_id'].toString() ==
//                     profundidade['icone'].toString(),
//                 orElse: () => {
//                   'ico_base64': ''
//                 }, // Fornecer um valor padrão caso não encontre
//               )['ico_base64'];
//
//           return {
//             ...profundidade,
//             'icone': iconeProfundidade,
//           };
//         }).toList();
//
//         return {
//           ...ponto,
//           'icone': iconeMarcador,
//           'profundidades': profundidadesAtualizadas,
//         };
//       }).toList();
//     }
//
// // Uso
//     latLngListMarcadores = substituirIcone(filtroPontosColeta);

    //
    // var profundidadesPontos = FFAppState()
    //     .profundidadesPonto
    //     .where((coleta) => coleta['trpp_artp_id'] == 7365)
    //     .map((e) => e['trpp_prof_id']);
    //
    // var perfilProfundidade = FFAppState()
    //     .perfilprofundidades
    //     .where((perfil) => perfil['pprof_id'] == 7);
    //
    // var profundidadesInfo = profundidadesPontos
    //     .map((profId) {
    //       var profundidade = FFAppState().profundidades.firstWhere(
    //           (prof) => prof['prof_id'] == profId,
    //           orElse: () =>
    //               null); // Retorna null se não encontrar correspondência
    //
    //       // Se encontrou a profundidade, retorna um mapa com as informações necessárias
    //       // Caso contrário, retorna null (que será filtrado depois)
    //       return profundidade != null
    //           ? {
    //               "nome": profundidade['prof_nome'],
    //               "icone": profundidade['prof_icone'],
    //               "cor": "#FFFFFF", // Usa get com valor padrão para 'prof_cor'
    //             }
    //           : null;
    //     })
    //     .where((element) => element != null) // Filtra elementos nulos
    //     .toList();
    // var img = FFAppState().PontosColetados.toList().map((e) => e['obs']);
    // var img = FFAppState()
    //     .profundidadesPonto
    //     .where((coleta) => coleta['trpp_artp_id'] != 7377)
    //     .map((e) => e['trpp_prof_id']);

    // var img = FFAppState().profundidadesPonto.where((element) =>
    //     element["trpp_prof_id"] == 79 && element["trpp_artp_id"] == 7407);
    // .map((e) => e['trpp_id']);
    // var img = FFAppState().profundidadesPonto
    //     .where((element) => element["trpp_prof_id"] == 78
    //     && element["trpp_artp_id"] == 7283);
    // .map((e) => e['trpp_id']).toString();
    var pontosDeCoConletados = latLngListMarcadores.firstWhere(
        (marcador) => marcador["marcador_nome"] == '2043',
        orElse: () => {"profundidades": []})["profundidades"];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Dados da Coleta'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                // Text(
                //   "Pontos: ${latLngListMarcadores.map((e) => e['profundidades']).first}",
                //
                //   style: TextStyle(color: Colors.black, fontSize: 12.0),
                // ),
                Text(
                  "Pontos: $pontosDeCoConletados",
                  style: TextStyle(color: Colors.black, fontSize: 12.0),
                ),
                // Text(
                //   "Pontos de Coleta: ${FFAppState().PontosColetados}",
                //   style: TextStyle(color: Colors.black, fontSize: 12.0),
                // ),
                // Text(
                //   "Pontos Coletados: ${jsonEncode(pontosColetados)}",
                //   style: TextStyle(color: Colors.black, fontSize: 12.0),
                // ),
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
    Match? match = regex.firstMatch(input);
    return match?.group(0) ?? "000000";
  }
}

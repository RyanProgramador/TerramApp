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
import 'dart:ui';
import 'package:background_location/background_location.dart'
    as background_location;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:wakelock/wakelock.dart';

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
  List<Map<String, dynamic>> listaDeLocais = [];

  // Implementação de exemplo
  List<Map<String, dynamic>> latLngListMarcadores = [];

  // List<Map<String, dynamic>> latLngListMarcadores = [
  //   {
  //     "marcador_nome": "A",
  //     "icone": "exemplo"
  //     "latlng_marcadores": "-29.914939224621914, -51.195420011983714",
  //     "profundidades": [
  //       {"nome": "0-10", "icone": "location_dot", "cor": "#FFC0CB"},
  //       {"nome": "0-20", "icone": "flag", "cor": "#FF4500"},
  //       {"nome": "0-25", "icone": "map_pin", "cor": "#0000CD"}
  //     ],
  //     "foto_de_cada_profundidade": [],
  //   },
  //   {
  //     "marcador_nome": "B",
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
  //   var filtroPontosColeta = FFAppState().pontosDeColeta
  //       .where((item) => item['oserv_id'] == 38)
  //       .toList();
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
    var filtroPontosColeta = FFAppState()
        .pontosDeColeta
        .where((item) => item['oserv_id'] == int.parse(widget.idContorno!))
        .toList();

    latLngListMarcadores = filtroPontosColeta.map((item) {
      // Busca por profundidadesPontos relacionadas ao ponto de coleta atual
      var profundidadesPontosProfIds = FFAppState()
          .profundidadesPonto
          .where((coleta) => coleta['trpp_artp_id'] == item['artp_id'])
          .map((e) => e['trpp_prof_id']);

      // Para cada profundidadePontosProfId, encontra as informações correspondentes em profundidades
      var profundidadesLista = profundidadesPontosProfIds
          .map((profId) {
            var profundidade = FFAppState().profundidades.firstWhere(
                (prof) => prof['prof_id'] == profId,
                orElse: () => null);

            return profundidade != null
                ? {
                    "nome": profundidade['prof_nome'],
                    "icone": profundidade['prof_imagem'],
                    "cor": profundidade['prof_cor'] ?? "#FFFFFF",
                    "prof_id": profId,
                  }
                : null;
          })
          .where((element) => element != null)
          .toList();

      var perfilProfundidade = FFAppState().perfilprofundidades.firstWhere(
          (perfil) => perfil['pprof_id'] == item['artp_id_perfil_prof'],
          orElse: () => null);

      var imagemProfundidade = '';
      if (perfilProfundidade != null) {
        var profundidade = FFAppState().profundidades.firstWhere(
            (prof) => prof['prof_id'] == perfilProfundidade['pprof_prof_id'],
            orElse: () => null);

        if (profundidade != null) {
          imagemProfundidade = profundidade['prof_imagem'];
        }
      }

      // Retorna o mapa com as informações do ponto de coleta e as profundidades associadas
      return {
        "marcador_nome": "${item['artp_id']}",
        "icone": imagemProfundidade, // A imagem de profundidade
        "latlng_marcadores": "${item['artp_latitude_longitude']}",
        "profundidades": profundidadesLista, // Lista de profundidades
        "foto_de_cada_profundidade": [],
      };
    }).toList();

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
        .where((item) =>
            item['talcot_id_pai'] == null &&
            item['oserv_id'] == int.parse(widget.idContorno!))
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
  void _criaMarcadores() {
    for (var marcador in latLngListMarcadores) {
      var latlng = marcador["latlng_marcadores"]!.split(",");
      var markerId = google_maps.MarkerId(marcador["marcador_nome"]!);
      var position =
          google_maps.LatLng(double.parse(latlng[0]), double.parse(latlng[1]));

      String base64Icon = marcador["icone"];
      // Uint8List iconBytes = base64Decode(base64Icon);
      var iconBytes = resizeImage(base64Icon, 66, 66);

      google_maps.BitmapDescriptor icon =
          google_maps.BitmapDescriptor.fromBytes(iconBytes);

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
    if (distance > 3500) {
      //metros de distancia para coletar
      // Show alert

      _showDistanceAlert();
    } else {
      // Continue with the normal double tap logic
      _showModalOptions(markerName);
    }
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

      // Decodifica a imagem
      img.Image imagem = img.decodeImage(bytes)!;

      // Ajusta a qualidade da imagem (50% neste exemplo)
      img.Image imagemComQualidadeReduzida = img.copyResize(imagem,
          width: (imagem.width ~/ 3), height: (imagem.height ~/ 3));

      // Recodifica a imagem para PNG com qualidade reduzida
      List<int> bytesComQualidadeReduzida =
          img.encodePng(imagemComQualidadeReduzida, level: 6); // level: 0-9

      // Converte os bytes modificados para base64
      String base64Image =
          base64Encode(Uint8List.fromList(bytesComQualidadeReduzida));

      setState(() {
        // Encontra o marcador pelo nome
        int indexMarcador = latLngListMarcadores.indexWhere(
            (marcador) => marcador['marcador_nome'] == nomeMarcadorAtual);

        if (indexMarcador != -1) {
          latLngListMarcadores[indexMarcador]['foto_de_cada_profundidade'].add({
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
            //_updateMarkerColor(marcadorNome, true);
            setState(() {
              vezAtualDoIntervaloDeColeta += 1;
            });
          }
          ;

          // Navigator.of(context).pop(); // Fecha o modal atual
          // _mostrarModalSucesso(context, nomeMarcadorAtual);
        }
      });

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
                          element['profundidade'] == nomeProfundidade &&
                          element['id_ref'] == referencialProfundidadePontoId,
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
                  var referencialProfundidadePontoId = FFAppState()
                      .profundidadesPonto
                      .where((element) =>
                          element["trpp_prof_id"] == profundidade["prof_id"] &&
                          element["trpp_artp_id"] == int.parse(marcadorNome))
                      .map((e) => e['trpp_id'])
                      .toString();

                  // profundidade["prof_id"].toString();
                  bool jaColetada = coletasPorMarcador[marcadorNome]
                          ?.contains(profundidade["nome"]) ??
                      false;

                  // Verificação adicional para 'pontosJaColetados'
                  if (!jaColetada && widget.pontosJaColetados != null) {
                    jaColetada = widget.pontosJaColetados!.any((pontoString) {
                      try {
                        var pontoMap =
                            json.decode(pontoString) as Map<dynamic, dynamic>;
                        return pontoMap["marcador_nome"].toString() ==
                                marcadorNome &&
                            pontoMap["profundidade"].toString() ==
                                profundidade["nome"].toString();
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
        //_updateMarkerColor(marcadorNome, true);
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
    var newIcon = todasColetadas
        ? google_maps.BitmapDescriptor.defaultMarkerWithHue(
            google_maps.BitmapDescriptor.hueGreen)
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
                  target: google_maps.LatLng(-29.913558, -51.195563),
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
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: ElevatedButton(
                onPressed: _exibirDados,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Color(0xFF00736D),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.info,
                      size: 25.0,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        )));
  }

  void _exibirDados() {
    var filtroPontosLatLngDeContorno = FFAppState()
        .listaContornoColeta
        .where((item) => item['oserv_id'] == 38)
        .map((item) => item['talcot_latitude_longitude'])
        .toList();
    var filtroPontosColeta = FFAppState()
        .pontosDeColeta
        .where((item) => item['oserv_id'] == int.parse(widget.idContorno!))
        .toList();

    latLngListMarcadores = filtroPontosColeta.map((item) {
      // Busca por profundidadesPontos relacionadas ao ponto de coleta atual
      var profundidadesPontosProfIds = FFAppState()
          .profundidadesPonto
          .where((coleta) => coleta['trpp_artp_id'] == item['artp_id'])
          .map((e) => e['trpp_prof_id']);

      // Para cada profundidadePontosProfId, encontra as informações correspondentes em profundidades
      var profundidadesLista = profundidadesPontosProfIds
          .map((profId) {
            var profundidade = FFAppState().profundidades.firstWhere(
                (prof) => prof['prof_id'] == profId,
                orElse: () => null);

            return profundidade != null
                ? {
                    "nome": profundidade['prof_nome'],
                    "icone": profundidade['prof_imagem'],
                    "cor": profundidade['prof_cor'] ?? "#FFFFFF",
                    "prof_id": profId,
                  }
                : null;
          })
          .where((element) => element != null)
          .toList();

      var perfilProfundidade = FFAppState().perfilprofundidades.firstWhere(
          (perfil) => perfil['pprof_id'] == item['artp_id_perfil_prof'],
          orElse: () => null);

      var imagemProfundidade = '';
      if (perfilProfundidade != null) {
        var profundidade = FFAppState().profundidades.firstWhere(
            (prof) => prof['prof_id'] == perfilProfundidade['pprof_prof_id'],
            orElse: () => null);

        if (profundidade != null) {
          imagemProfundidade = profundidade['prof_imagem'];
        }
      }

      // Retorna o mapa com as informações do ponto de coleta e as profundidades associadas
      return {
        "marcador_nome": "${item['artp_id']}",
        "icone": imagemProfundidade, // A imagem de profundidade
        "latlng_marcadores": "${item['artp_latitude_longitude']}",
        "profundidades": profundidadesLista, // Lista de profundidades
        "foto_de_cada_profundidade": [],
      };
    }).toList();

    //
    // var lat = latLngListMarcadores.where((e) => e['marcador_nome'] == 4120)
    //     .map((e) => e['latlng_marcadores'] = '-29.91494505823483, -51.19616432043194');
    //     // .toList();
    //   var lng = FFAppState().pontosDeColeta.where((e) => e['artp_id'] == 4120)
    //       .map((e) => e['artp_latitude_longitude'] = '-29.91494505823483, -51.19616432043194');
    //       // .toList();

    var profundidadesPontos = FFAppState()
        .profundidadesPonto
        .where((coleta) => coleta['trpp_artp_id'] == 7365)
        .map((e) => e['trpp_prof_id']);

    var perfilProfundidade = FFAppState()
        .perfilprofundidades
        .where((perfil) => perfil['pprof_id'] == 7);

    var profundidadesInfo = profundidadesPontos
        .map((profId) {
          var profundidade = FFAppState().profundidades.firstWhere(
              (prof) => prof['prof_id'] == profId,
              orElse: () =>
                  null); // Retorna null se não encontrar correspondência

          // Se encontrou a profundidade, retorna um mapa com as informações necessárias
          // Caso contrário, retorna null (que será filtrado depois)
          return profundidade != null
              ? {
                  "nome": profundidade['prof_nome'],
                  "icone": profundidade['prof_icone'],
                  "cor": "#FFFFFF", // Usa get com valor padrão para 'prof_cor'
                }
              : null;
        })
        .where((element) => element != null) // Filtra elementos nulos
        .toList();
    var img = FFAppState().PontosColetados.toList().map((e) => e['obs']);
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
                  "Pontos: $img",
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

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

import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:wakelock/wakelock.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'dart:math';

class RotaFinalOffline extends StatefulWidget {
  const RotaFinalOffline({
    Key? key,
    this.width,
    this.height,
    required this.coordenadasIniciais,
    required this.coordenadasFinais,
  }) : super(key: key);

  final double? width;
  final double? height;
  final LatLng coordenadasIniciais;
  final LatLng coordenadasFinais;

  final String customIconUrl =
      'https://cdn-icons-png.flaticon.com/128/3253/3253113.png';

  @override
  _MapsRoutesState createState() => _MapsRoutesState();
}

class _MapsRoutesState extends State<RotaFinalOffline> {
  //position é a posição atual
  Position? position;
  //position para calclar o bearing
  Position? previousPosition;
  //esse é o formato do icone cara
  Uint8List? customIconBytes;

  //icobe do modo livre
  String icone = "crop_free";
  IconData getIconData() {
    // Convert the string to IconData using Icons class
    switch (icone) {
      case "crop_free":
        return Icons.crop_free;
      case "center_focus_weak":
        return Icons.center_focus_weak;
      // Add more cases as needed for other icon names
      default:
        return Icons.crop_free; // Default icon
    }
  }

  //inporante para o controle do maps
  google_maps.GoogleMapController? _googleMapController;
//modo pausado /modolivre
  bool estalivre = false;
//modo carro
  bool modocarrobool = false;
  double currentBearing = 0.0;

// Função para calcular o bearing entre dois pontos
  double _calculateBearing(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    // Converte as latitudes e longitudes de graus para radianos
    double startLatRad = startLat * pi / 180;
    double startLngRad = startLng * pi / 180;
    double endLatRad = endLat * pi / 180;
    double endLngRad = endLng * pi / 180;

    // Calcula a diferença de longitudes e a diferença de longitudes radianas
    double deltaLng = endLngRad - startLngRad;

    // Calcula o bearing (azimute) usando a fórmula trigonométrica
    double x = sin(deltaLng) * cos(endLatRad);
    double y = cos(startLatRad) * sin(endLatRad) -
        sin(startLatRad) * cos(endLatRad) * cos(deltaLng);
    double bearing = atan2(x, y);

    // Converte o bearing de radianos para graus
    bearing = (bearing * 180 / pi + 360) % 360;

    return bearing;
  }

//adiciona quando o mapa é criado
  void _onMapCreated(google_maps.GoogleMapController controller) {
    _googleMapController = controller;
  }

  //para polylines
  List<google_maps.LatLng> routePoints = [];

//cria a rota para cada etapa
  Set<google_maps.Marker> _createRouteFromSteps(List<dynamic> steps) {
    Set<google_maps.Marker> routeMarkers = Set();
    List<google_maps.LatLng> routeCoordinates = [];

    return routeMarkers;
  }

//carrega o icone custom
  Future<void> _loadCustomIcon() async {
    if (widget.customIconUrl != null && widget.customIconUrl!.isNotEmpty) {
      try {
        final response = await http.get(Uri.parse(widget.customIconUrl!));
        if (response.statusCode == 200) {
          setState(() {
            customIconBytes = response.bodyBytes;
          });
        } else {
          print(
              "Failed to load custom icon. Status code: ${response.statusCode}");
        }
      } catch (e) {
        print("Error loading custom icon: $e");
      }
    }
  }

//adiciona o custom icone no mapa na posição tal
  Set<google_maps.Marker> _createCustomMarker() {
    Set<google_maps.Marker> customMarkers = Set();

    var customMarkerLatLng = google_maps.LatLng(
      position?.latitude ?? 0.0,
      position?.longitude ?? 0.0,
    );
//marcador atual do usuario
    customMarkers.add(
      google_maps.Marker(
        markerId: google_maps.MarkerId('CustomMarkerID'),
        position: customMarkerLatLng,
        flat: true,
        icon: customIconBytes != null
            ? google_maps.BitmapDescriptor.fromBytes(customIconBytes!)
            : google_maps.BitmapDescriptor.defaultMarkerWithHue(
                google_maps.BitmapDescriptor.hueBlue,
              ),
        rotation: -currentBearing,
        // Call a separate function to get the custom icon.
        anchor: Offset(0.5, 0.5),
      ),
    );

    return customMarkers;
  }

//faço a menor ideia, acho que é a parte de posição de cada atualização com a position atual
  void addRoutePoints() {}

  //RECENTRALIZAR COM UM BOTÃO
  void retiraPosicaoAtualDeRodar() async {
    if (!estalivre) {
      estalivre = true;
      icone = "center_focus_weak";
    } else {
      estalivre = false;
      icone = "crop_free";
    }
  }

  //RECENTRALIZAR COM UM BOTÃO
  void voltaPosicaoAtualDeRodar() async {
    estalivre = false;
  } //RECENTRALIZAR COM UM BOTÃO

  void modoCarro() async {
    if (!modocarrobool) {
      modocarrobool = true;
    } else {
      modocarrobool = false;
    }
  }

//atualiza a cada momento a posição atual do user
  void _getCurrentLocation() async {
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 0, // Minimum distance of 0 meters
      ),
    ).listen((Position newLoc) async {
      if (!modocarrobool) {
        //se o modo carro estiver desabilitado
        if (!estalivre) {
          if (_googleMapController != null) {
            double currentZoomLevel =
                await _googleMapController!.getZoomLevel();

            _googleMapController!.animateCamera(
              google_maps.CameraUpdate.newCameraPosition(
                google_maps.CameraPosition(
                  target: google_maps.LatLng(
                    newLoc.latitude,
                    newLoc.longitude,
                  ),
                  zoom: currentZoomLevel ?? 14,
                  bearing: currentBearing,
                ),
              ),
            );
          }

          setState(() {
            position = newLoc;
          });
        }
      } else {
        //modo carro habilitado
        if (!estalivre) {
          if (_googleMapController != null) {
            double currentZoomLevel =
                await _googleMapController!.getZoomLevel();

            // Calcula o bearing (azimute) entre a posição anterior e a posição atual
            double bearing = 0.0;
            if (previousPosition != null) {
              bearing = _calculateBearing(
                previousPosition!.latitude,
                previousPosition!.longitude,
                newLoc.latitude,
                newLoc.longitude,
              );
            }

            _googleMapController!.animateCamera(
              google_maps.CameraUpdate.newCameraPosition(
                google_maps.CameraPosition(
                  target: google_maps.LatLng(
                    newLoc.latitude,
                    newLoc.longitude,
                  ),
                  zoom: currentZoomLevel ?? 20,
                  tilt: 90,
                  bearing: bearing,
                ),
              ),
            );
          }

          setState(() {
            position = newLoc;
          });
        }
// Atualiza a posição anterior
        previousPosition = newLoc;
      }
    });
  }

  @override
  void initState() {
    Wakelock.enable();
    super.initState();
    _getCurrentLocation();
    addRoutePoints();
    retiraPosicaoAtualDeRodar();
    voltaPosicaoAtualDeRodar();
    modoCarro();

    _loadCustomIcon();
  }

  @override
  Widget build(BuildContext context) {
    Set<google_maps.Marker> routeMarkers = _createCustomMarker();
    routeMarkers.add(
      google_maps.Marker(
        markerId: google_maps.MarkerId(
            'MarkerID-Fim-${widget.coordenadasFinais.latitude}-${widget.coordenadasFinais.longitude}'),
        position: google_maps.LatLng(
          widget.coordenadasFinais.latitude,
          widget.coordenadasFinais.longitude,
        ),
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
          google_maps.BitmapDescriptor.hueRed,
        ),
      ),
    );
    Set<google_maps.Marker> allMarkers =
        routeMarkers.union(_createCustomMarker());

    return WillPopScope(
        onWillPop: () async {
          // Aqui você pode implementar qualquer lógica adicional necessária
          // antes de permitir o comportamento padrão de voltar.
          final shouldPop = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Você tem certeza que quer sair do deslocamento?'),
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
                    //setState(() {
                    //  FFAppState().contornoFazenda =
                    //      FFAppState().contornoFazenda.toList().cast<dynamic>();
                    //  FFAppState().grupoContornoFazendas =
                    //      FFAppState().grupoContornoFazendas.toList().cast<dynamic>();
                    //});
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
              width: widget.width ?? 400.0,
              height: widget.height ?? 400.0,
              child: google_maps.GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: google_maps.CameraPosition(
                  target: google_maps.LatLng(
                    position?.latitude ?? widget.coordenadasFinais.latitude,
                    position?.longitude ?? widget.coordenadasFinais.latitude,
                  ),
                  zoom: 19,
                  tilt: 60,
                  bearing: 90,
                ),
                onMapCreated: _onMapCreated,
                onCameraMove: (google_maps.CameraPosition position) {
                  // Atualize o bearing atual com o novo valor durante o movimento da câmera
                  currentBearing = position.bearing;
                },
                markers: allMarkers,
                polylines: {
                  google_maps.Polyline(
                    polylineId: google_maps.PolylineId("RedPolyline"),
                    color: Colors.blue,
                    points: routePoints,
                  ),
                },
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 3.2 -
                  28.0, // Adjust the top position as needed
              right: 5, // Adjust the left position as needed
              child: ElevatedButton(
                onPressed: () {
                  retiraPosicaoAtualDeRodar();

                  setState(() {
                    if (!estalivre) {
                      icone = "center_focus_weak";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Centralizando..."),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } else {
                      icone = "crop_free";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Mapa fixado"),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Color(0xFF00736D),
                ),
                child: Icon(
                  getIconData(), // or any other compass-related icon
                  size: 25.0,
                  color: Colors.white, // Adjust the size as needed
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 4 -
                  28.0, // Adjust the top position as needed
              right: 5, // Adjust the left position as needed
              child: ElevatedButton(
                onPressed: () {
                  modoCarro();
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Color(0xFF00736D),
                ),
                child: Transform.rotate(
                  angle:
                      30, // Your rotation angle here based on compass direction,
                  child: Icon(
                    Icons.explore, // or any other compass-related icon
                    size: 25.0,
                    color: Colors.white, // Adjust the size as needed
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}

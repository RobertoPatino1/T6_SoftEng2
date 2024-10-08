// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;
import 'package:maps_toolkit/maps_toolkit.dart' as mtk;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_your_route_front/core/constants/map_contants.dart';
import 'package:share_your_route_front/modules/route_room/route_preview/presenters/route_preview_page.dart';
import 'package:share_your_route_front/modules/route_room/stop_route/presenters/route_stop.dart';
import 'package:share_your_route_front/modules/shared/services/permission_provider.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MapWidget();
  }
}

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> with WidgetsBindingObserver {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String mapStyle = "";
  StreamSubscription<Position>? _positionStream;
  final CameraPosition _cameraPos = const CameraPosition(
    target: LatLng(-2.173131, -79.854229),
    zoom: 16,
  );
  List<Marker> markerList = [];
  final Marker _destinationMarker = Marker(
    markerId: MarkerId(activeTouristRoute.name),
    position: LatLng(
      activeTouristRoute
          .placesList[activeTouristRoute.currentPlaceIndex].ubication.latitude,
      activeTouristRoute
          .placesList[activeTouristRoute.currentPlaceIndex].ubication.longitude,
    ),
  );
  Position? _currentPosition;
  List<Polyline> myRouteList = [];
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  Marker? myLocationMarker;
  late String _directions;
  late String _duration;
  late String _distance;

  @override
  void initState() {
    super.initState();
    _directions = ""; // Inicializa _directions
    _duration = ""; // Inicializa _duration
    _distance = ""; // Inicializa _distance
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      markerList.add(_destinationMarker);
      setCustomIconForUserLocation();
      _loadMapStyles().then((_) {
        if (mounted) setState(() {});
      });
      checkPermissionAndListenLocation();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !PermissionProvider.isServiceOn ||
              PermissionProvider.locationPermission !=
                  PermissionStatus.granted ||
              mapStyle.isEmpty
          ? Container(
              color: Colors.grey[700],
              child: const Center(child: CircularProgressIndicator()),
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: GoogleMap(
                    polylines: Set<Polyline>.from(myRouteList),
                    initialCameraPosition: _cameraPos,
                    markers: Set<Marker>.from(markerList),
                    onMapCreated: (GoogleMapController controller) {
                      if (!_controller.isCompleted) {
                        _controller.complete(controller);
                      }
                    },
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 16,
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.grey[850],
                    onPressed: () {
                      getNewRouteFromAPI();
                    },
                    label: Text(
                      "Get Route",
                      style: TextStyle(color: Colors.grey[300]),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(191, 141, 48, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      activeTouristRoute.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: ui.FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Proxima parada: ${activeTouristRoute.placesList[activeTouristRoute.currentPlaceIndex].name}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: ui.FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        // Direction arrow and distance
                        Column(
                          children: [
                            const Icon(
                              Icons.arrow_forward,
                              size: 32,
                              color: Colors.black,
                            ),
                            Text(
                              _distance,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        // Directions text
                        Expanded(
                          child: Text(
                            _directions,
                            style: Theme.of(context).textTheme.headlineSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Back button
                Positioned(
                  bottom: 30,
                  left: 16,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ],
            ),
    );
  }

  List<TextSpan> _parseDirectionsToTextSpans(String htmlString) {
    final document = html_parser.parse(htmlString);
    final spans = <TextSpan>[];

    for (final node in document.body!.nodes) {
      if (node.nodeType == html.Node.ELEMENT_NODE) {
        final element = node as html.Element;
        final text = element.text;
        final style = _getTextStyleForElement(element);
        spans.add(TextSpan(text: text, style: style));
      } else if (node.nodeType == html.Node.TEXT_NODE) {
        spans.add(TextSpan(text: node.text));
      }
    }

    return spans;
  }

  TextStyle? _getTextStyleForElement(html.Element element) {
    if (element.localName == 'b' || element.localName == 'strong') {
      return const TextStyle(fontWeight: FontWeight.bold);
    } else if (element.localName == 'i' || element.localName == 'em') {
      return const TextStyle(fontStyle: FontStyle.italic);
    } else if (element.localName == 'div') {
      // Verifica si el div tiene un atributo de estilo en línea
      final String? style = element.attributes['style'];
      if (style != null) {
        // Busca el tamaño de fuente en el estilo
        final RegExp fontSizeRegex = RegExp(r'font-size:\s*([\d.]+)em');
        final Match? match = fontSizeRegex.firstMatch(style);
        if (match != null) {
          final double fontSize = double.parse(match.group(1)!) *
              16.0; // Multiplica el tamaño en "em" por el tamaño de fuente base (16px).
          return TextStyle(fontSize: fontSize);
        }
      }
    }
    return null;
  }

  void setCustomIconForUserLocation() {
    Future<Uint8List> getBytesFromAsset(String path, int width) async {
      final ByteData data = await rootBundle.load(path);
      final ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width,
      );
      final ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();
    }

    getBytesFromAsset('asset/user_location.png', 64).then((onValue) {
      setState(() {
        markerIcon = BitmapDescriptor.bytes(onValue);
      });
    }).catchError((error) {
      log("Error loading marker icon: $error");
    });
  }

  void navigationProcess() {
    final List<mtk.LatLng> myLatLngList = [];
    for (final data in myRouteList.first.points) {
      myLatLngList.add(mtk.LatLng(data.latitude, data.longitude));
    }

    final mtk.LatLng myPosition =
        mtk.LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    final int x = mtk.PolygonUtil.locationIndexOnPath(
      myPosition,
      myLatLngList,
      true,
      tolerance: 12,
    );

    if (x == -1) {
      getNewRouteFromAPI();
    } else {
      myLatLngList[x] = myPosition;
      myLatLngList.removeRange(0, x);
      myRouteList.first.points.clear();
      myRouteList.first.points
          .addAll(myLatLngList.map((e) => LatLng(e.latitude, e.longitude)));

      // Update directions
      updateDirectionsBasedOnLocation(x);
    }

    if (mounted) setState(() {});

    _checkProximityToDestination();
  }

  void updateDirectionsBasedOnLocation(int index) {
    final steps = _directions.split('<br>');
    if (index < steps.length) {
      final String rawHtml = steps[index];
      final String formattedText = _parseHtml(rawHtml);
      setState(() {
        _directions = formattedText;
      });
    }
  }

  String _parseHtml(String htmlString) {
    final document = html_parser.parse(htmlString);
    final String text = document.body?.text ?? "";
    return text;
  }

  Future<void> getNewRouteFromAPI() async {
    if (myRouteList.isNotEmpty) myRouteList.clear();

    log("GETTING NEW ROUTE !!");

    final origin =
        '${_currentPosition!.latitude},${_currentPosition!.longitude}';
    final destination =
        '${_destinationMarker.position.latitude},${_destinationMarker.position.longitude}';
    final apiKey = MapConstants.googleApiKey;

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$apiKey&mode=walking&language=es',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;

      if (data['status'] == 'OK') {
        final routeData = data['routes'][0];
        final legs = routeData['legs'][0];
        final polyline = routeData['overview_polyline']['points'];
        _duration = legs['duration']['text'] as String;
        final distance = legs['distance']['text'];
        final steps = legs['steps']
            .map<String>(
              (step) => _parseHtml(
                step['html_instructions'] as String,
              ),
            ) // Limpia las etiquetas HTML
            .toList();

        setState(() {
          myRouteList.add(
            Polyline(
              polylineId: const PolylineId('route'),
              points: _decodePoly(polyline as String)
                  .map((e) => LatLng(e.latitude, e.longitude))
                  .toList(),
              color: const Color.fromARGB(255, 33, 155, 255),
              width: 5,
            ),
          );
          _directions = steps.join(
            '<br>',
          ) as String; // Guarda todas las instrucciones sin etiquetas HTML
          _distance = distance as String;
        });
      } else {
        log("Error in API response: ${data['status']}");
      }
    } else {
      log("Failed to load route");
    }
  }

  List<mtk.LatLng> _decodePoly(String encoded) {
    final List<mtk.LatLng> poly = [];
    int index = 0;
    final int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;
      do {
        b = encoded.codeUnitAt(index) - 63;
        index++;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      final int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index) - 63;
        index++;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      final int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      poly.add(
        mtk.LatLng(
          lat / 1E5,
          lng / 1E5,
        ),
      );
    }
    return poly;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (PermissionProvider.permissionDialogRoute != null &&
          PermissionProvider.permissionDialogRoute!.isActive) {
        Navigator.of(MapConstants.globalNavigatorKey.currentContext!)
            .removeRoute(PermissionProvider.permissionDialogRoute!);
      }
      Future.delayed(const Duration(milliseconds: 250), () async {
        checkPermissionAndListenLocation();
      });
    }
  }

  Future<void> checkPermissionAndListenLocation() async {
    await PermissionProvider.handleLocationPermission();
    if (_positionStream == null &&
        PermissionProvider.isServiceOn &&
        PermissionProvider.locationPermission == PermissionStatus.granted) {
      startListeningLocation();
    }
    if (mounted) setState(() {});
  }

  void startListeningLocation() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(),
    ).listen((Position position) {
      setState(() {
        _currentPosition = position;
        if (myLocationMarker == null) {
          if (markerIcon != BitmapDescriptor.defaultMarker) {
            myLocationMarker = Marker(
              markerId: const MarkerId('currentLocation'),
              position: LatLng(position.latitude, position.longitude),
              icon: markerIcon,
              rotation: position.heading,
              zIndex: 2,
            );
            markerList.add(myLocationMarker!);
          }
        } else {
          myLocationMarker = myLocationMarker!.copyWith(
            positionParam: LatLng(position.latitude, position.longitude),
            rotationParam: position.heading,
          );
          markerList = markerList.map((marker) {
            if (marker.markerId.value == 'currentLocation') {
              return myLocationMarker!;
            } else {
              return marker;
            }
          }).toList();
        }
      });
      moveCameraToCurrentPosition();
      navigationProcess();
    });
  }

  Future<void> moveCameraToCurrentPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      ),
    );
  }

  Future<void> _loadMapStyles() async {
    final style =
        await rootBundle.loadString('asset/json/light_mode_style.json');
    setState(() {
      mapStyle = style;
    });
  }

  void _checkProximityToDestination() {
    if (_currentPosition == null) return;

    final destinationLatLng = LatLng(
      activeTouristRoute
          .placesList[activeTouristRoute.currentPlaceIndex].ubication.latitude,
      activeTouristRoute
          .placesList[activeTouristRoute.currentPlaceIndex].ubication.longitude,
    );

    final distanceInMeters = Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      destinationLatLng.latitude,
      destinationLatLng.longitude,
    );

    const double proximityThreshold =
        20; // Distancia en metros para considerar "cerca" del destino

    if (distanceInMeters <= proximityThreshold) {
      _updateUIForProximity(); // Cambia la interfaz cuando el usuario esté cerca del destino
    }
  }

  void _updateUIForProximity() {
    activeTouristRoute.currentPlaceIndex += 1;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RouteStop(
          stopName: activeTouristRoute
              .placesList[activeTouristRoute.currentPlaceIndex].name,
        ),
      ),
    );
  }
}

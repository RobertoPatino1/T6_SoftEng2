import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_your_route_front/models/tourist_route.dart';
import 'package:share_your_route_front/modules/shared/providers/location_provider.dart';
import 'package:share_your_route_front/modules/shared/providers/tourist_route_provider.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Map();
  }
}

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
  LatLng? myPosition;

  Future<void> getCurrentLocation() async {
    final Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TouristRoute touristRoute =
        // ignore: cast_nullable_to_non_nullable
        TouristRouteService().getCurrentTouristRoute() as TouristRoute;
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Modular.to.pop();
              Modular.to.pop();
              Modular.to.pop();
            },
          ),
          title: Text(
            touristRoute.name,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: myPosition == null
            ? const Center(child: CircularProgressIndicator())
            : FlutterMap(
                options: MapOptions(
                  center: myPosition,
                  minZoom: 5,
                  maxZoom: 25,
                  zoom: 18,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                    additionalOptions: {
                      'accessToken': dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? "",
                      'id': 'mapbox/streets-v12',
                    },
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: myPosition!,
                        builder: (BuildContext context) {
                          return const Icon(
                            Icons.location_pin,
                            size: 40,
                            color: Color.fromARGB(255, 230, 31, 17),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Salir de la ruta",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  content: const Text(
                    "¿Está seguro de que quieres salir?",
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        "Cancelar",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text(
                        "Aceptar",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      onPressed: () {
                        TouristRouteService().setCurrentTouristRoute(null);
                        Modular.to.pop();
                        Modular.to.pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              100,
            ),
          ),
          child: const Icon(Icons.exit_to_app),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}

// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_your_route_front/models/place.dart';

class ViewStopsMapScreen extends StatelessWidget {
  final List<Place> stops;

  const ViewStopsMapScreen({super.key, required this.stops});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Mapa de Paradas',
          style: TextStyle(
            fontSize: 20.0,
            color: Color.fromRGBO(45, 75, 115, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(45, 75, 115, 1),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: stops.isNotEmpty
              ? stops[0].ubication as LatLng
              : const LatLng(0, 0),
          minZoom: 5,
          maxZoom: 25,
          zoom: 14,
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
            markers: stops
                .map(
                  (stop) => Marker(
                    width: 80.0,
                    height: 80.0,
                    point: stop.ubication as LatLng,
                    builder: (ctx) => const Icon(
                      Icons.location_pin,
                      size: 40,
                      color: Color.fromARGB(255, 230, 31, 17),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

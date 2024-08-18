// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_your_route_front/models/place.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class ViewStopsMapScreen extends StatelessWidget {
  final List<Place> stops;

  const ViewStopsMapScreen({super.key, required this.stops});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Mapa de Paradas",
      ),
      body: FlutterMap(
        options: MapOptions(
          center:
              stops.isNotEmpty ? stops[0].ubication as LatLng : LatLng(0, 0),
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

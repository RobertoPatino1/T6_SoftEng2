import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_your_route_front/models/place.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class ViewStopsMapScreen extends StatefulWidget {
  final List<Place> stops;

  const ViewStopsMapScreen({super.key, required this.stops});

  @override
  _ViewStopsMapScreenState createState() => _ViewStopsMapScreenState();
}

class _ViewStopsMapScreenState extends State<ViewStopsMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late CameraPosition initialCameraPosition;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    // Inicializa la cámara en la primera parada o en un lugar predeterminado
    if (widget.stops.isNotEmpty) {
      initialCameraPosition = CameraPosition(
        target: LatLng(
          widget.stops[0].ubication.latitude,
          widget.stops[0].ubication.longitude,
        ),
        zoom: 14,
      );
    } else {
      initialCameraPosition = const CameraPosition(
        target: LatLng(0, 0),
        zoom: 14,
      );
    }

    // Agrega los marcadores de las paradas
    markers = widget.stops
        .map(
          (stop) => Marker(
            markerId: MarkerId(stop.name),
            position: LatLng(stop.ubication.latitude, stop.ubication.longitude),
            infoWindow: InfoWindow(title: stop.name),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        )
        .toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Mapa de Paradas",
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

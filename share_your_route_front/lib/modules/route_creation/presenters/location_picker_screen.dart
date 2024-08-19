import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:share_your_route_front/core/constants/colors.dart';
import 'package:share_your_route_front/modules/shared/services/location_service.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class LocationPickerScreen extends StatefulWidget {
  final Function(LatLng?) onLocationSelected;

  const LocationPickerScreen({super.key, required this.onLocationSelected});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng? myPosition;
  LatLng? selectedPosition;
  GoogleMapController? _mapController;
  late GoogleMapsPlaces _places;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    _initializePlaces();
  }

  Future<void> _initializePlaces() async {
    final headers = await const GoogleApiHeaders().getHeaders();
    _places = GoogleMapsPlaces(
      apiKey: dotenv.env['GOOGLE_API_KEY']!,
      apiHeaders: headers,
    );
  }

  Future<void> getCurrentLocation() async {
    final LatLng position = await LocationService.determinePosition();
    setState(() {
      myPosition = position;
      selectedPosition = myPosition;
    });
    _mapController?.moveCamera(CameraUpdate.newLatLng(myPosition!));
  }

  Future<void> _handleSearch() async {
    final Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: dotenv.env['GOOGLE_API_KEY'],
      mode: Mode.overlay,
      language: 'es',
      components: [Component(Component.country, 'ec')],
    );

    if (p != null) {
      _onPlaceSelected(p);
    }
  }

  Future<void> _onPlaceSelected(Prediction p) async {
    final PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    setState(() {
      selectedPosition = LatLng(lat, lng);
    });

    _mapController
        ?.animateCamera(CameraUpdate.newLatLngZoom(selectedPosition!, 14.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Punto de Encuentro"),
      body: myPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _handleSearch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: yellowAccentColor,
                    ),
                    child: const Text(
                      'Buscar ubicación',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: selectedPosition ?? myPosition!,
                      zoom: 18,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                    markers: selectedPosition != null
                        ? {
                            Marker(
                              markerId: const MarkerId('selected-location'),
                              position: selectedPosition!,
                            ),
                          }
                        : {},
                    onTap: (LatLng point) {
                      setState(() {
                        selectedPosition = point;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onLocationSelected(selectedPosition);
                    Navigator.pop(context, selectedPosition);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowAccentColor,
                  ),
                  child: const Text(
                    'Confirmar ubicación',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  final TextEditingController _searchController = TextEditingController();
  GoogleMapController? _mapController;

  Future<void> getCurrentLocation() async {
    final LatLng position = await LocationService.determinePosition();
    setState(() {
      myPosition = position;
      selectedPosition = myPosition;
    });
    _mapController?.moveCamera(CameraUpdate.newLatLng(myPosition!));
  }

  Future<void> searchLocation(String query) async {
    try {
      final List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final location = locations.first;
        setState(() {
          selectedPosition = LatLng(location.latitude, location.longitude);
        });
        _mapController
            ?.animateCamera(CameraUpdate.newLatLng(selectedPosition!));
      }
    } catch (e) {
      print('Error searching location: $e');
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
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
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar ubicación',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          searchLocation(_searchController.text);
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onSubmitted: (value) {
                      searchLocation(value);
                    },
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
                              markerId: MarkerId('selected-location'),
                              position: selectedPosition!,
                              icon: BitmapDescriptor.defaultMarker,
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

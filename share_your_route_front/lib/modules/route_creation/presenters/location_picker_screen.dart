import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
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

  Future<void> getCurrentLocation() async {
    final LatLng position = await LocationService.determinePosition();
    setState(() {
      myPosition = position;
      selectedPosition = myPosition;
    });
  }

  Future<void> searchLocation(String query) async {
    try {
      final List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final location = locations.first;
        setState(() {
          selectedPosition = LatLng(location.latitude, location.longitude);
        });
      }
    } catch (e) {
      // ignore: avoid_print
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
      appBar: const CustomAppBar(title: "Seleccionar Ubicación"),
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
                  child: FlutterMap(
                    options: MapOptions(
                      center: selectedPosition ?? myPosition!,
                      minZoom: 5,
                      maxZoom: 25,
                      zoom: 18,
                      onTap: (tapPosition, point) {
                        setState(() {
                          selectedPosition = point;
                        });
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                        additionalOptions: {
                          'accessToken':
                              dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? "",
                          'id': 'mapbox/streets-v12',
                        },
                      ),
                      if (selectedPosition != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 80.0,
                              height: 80.0,
                              point: selectedPosition!,
                              builder: (ctx) => const Icon(
                                Icons.location_pin,
                                size: 40,
                                color: Color.fromARGB(255, 230, 31, 17),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onLocationSelected(selectedPosition);
                    Navigator.pop(context, selectedPosition);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(45, 75, 115, 1),
                  ),
                  child: const Text(
                    'Confirmar ubicación',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

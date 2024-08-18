import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_your_route_front/modules/shared/services/location_service.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class AddStopScreen extends StatefulWidget {
  final Function(String, LatLng, TimeOfDay, TimeOfDay) onStopAdded;

  const AddStopScreen({super.key, required this.onStopAdded});

  @override
  State<AddStopScreen> createState() => _AddStopScreenState();
}

class _AddStopScreenState extends State<AddStopScreen> {
  LatLng? myPosition;
  LatLng? selectedPosition;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _stopNameController = TextEditingController();
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

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

  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: isStartTime
          ? 'Selecciona una hora para llegar a la parada'
          : 'Selecciona una hora para salir de la parada',
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = picked;
        } else {
          selectedEndTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Agregar Parada"),
      body: myPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _stopNameController,
                    decoration: const InputDecoration(
                      hintText: 'Nombre de la parada',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await selectTime(context, true);
                        },
                        child: Text(
                          selectedStartTime == null
                              ? 'Seleccionar Hora de Inicio'
                              : 'Hora de Inicio: ${selectedStartTime!.format(context)}',
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () async {
                          await selectTime(context, false);
                        },
                        child: Text(
                          selectedEndTime == null
                              ? 'Seleccionar Hora de Fin'
                              : 'Hora de Fin: ${selectedEndTime!.format(context)}',
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_stopNameController.text.isNotEmpty &&
                        selectedPosition != null &&
                        selectedStartTime != null &&
                        selectedEndTime != null) {
                      widget.onStopAdded(
                        _stopNameController.text,
                        selectedPosition!,
                        selectedStartTime!,
                        selectedEndTime!,
                      );
                      Navigator.pop(
                        context,
                        {
                          'name': _stopNameController.text,
                          'location': selectedPosition,
                          'startTime': selectedStartTime,
                          'endTime': selectedEndTime,
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, complete todos los campos'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(45, 75, 115, 1),
                  ),
                  child: const Text(
                    'Confirmar parada',
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

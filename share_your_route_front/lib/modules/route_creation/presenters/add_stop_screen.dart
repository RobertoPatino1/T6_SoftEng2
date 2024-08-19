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
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';

class AddStopScreen extends StatefulWidget {
  final Function(String, LatLng, TimeOfDay, TimeOfDay) onStopAdded;

  const AddStopScreen({super.key, required this.onStopAdded});

  @override
  State<AddStopScreen> createState() => _AddStopScreenState();
}

class _AddStopScreenState extends State<AddStopScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng? myPosition;
  LatLng? selectedPosition;
  final TextEditingController _stopNameController = TextEditingController();
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  late GoogleMapsPlaces _places;
  Set<Marker> markersList = {};

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
      markersList.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: myPosition!,
        ),
      );
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(myPosition!));
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
      markersList.clear();
      markersList.add(
        Marker(
          markerId: const MarkerId('selectedPosition'),
          position: selectedPosition!,
          infoWindow: InfoWindow(title: detail.result.name),
        ),
      );
    });

    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(selectedPosition!, 14.0));
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
                      target: myPosition!,
                      zoom: 18,
                    ),
                    onMapCreated: (controller) {
                      _controller.complete(controller);
                    },
                    markers: markersList,
                    onTap: (LatLng position) {
                      setState(() {
                        selectedPosition = position;
                        markersList.add(
                          Marker(
                            markerId: const MarkerId('selectedPosition'),
                            position: selectedPosition!,
                          ),
                        );
                      });
                    },
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
                      showSnackbar(
                        context,
                        "Por favor, complete todos los campos",
                        "error",
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowAccentColor,
                  ),
                  child: const Text(
                    'Confirmar parada',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}

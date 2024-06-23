import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_your_route_front/core/widgets/create_route_widgets.dart';
import 'package:share_your_route_front/modules/route_creation/presenters/add_stop_screen.dart';

class RouteStep2 extends StatefulWidget {
  final List<Map<String, dynamic>> stops;
  final Function(List<Map<String, dynamic>>) onStopsChanged;

  const RouteStep2({
    super.key,
    required this.stops,
    required this.onStopsChanged,
  });

  @override
  State<RouteStep2> createState() => _RouteStep2State();
}

class _RouteStep2State extends State<RouteStep2> {
  List<Map<String, dynamic>> stops = [];

  @override
  void initState() {
    super.initState();
    stops = List.from(widget.stops);
  }

  void _addStop(String name, LatLng location, TimeOfDay time) {
    final newStop = {'name': name, 'location': location, 'time': time};
    setState(() {
      if (!stops.any((stop) =>
          stop['name'] == name &&
          stop['location'] == location &&
          stop['time'] == time)) {
        stops.add(newStop);
      }
    });
    widget.onStopsChanged(stops);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (stops.isEmpty)
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddStopScreen(onStopAdded: _addStop),
                ),
              );

              if (result != null && result is Map<String, dynamic>) {
                _addStop(
                  result['name'] as String,
                  result['location'] as LatLng,
                  result['time'] as TimeOfDay,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(45, 75, 115, 1),
            ),
            child: const Text(
              'Agregar Paradas',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Paradas', style: titlelabelTextStyle),
              ListView.builder(
                shrinkWrap: true,
                itemCount: stops.length,
                itemBuilder: (context, index) {
                  final stop = stops[index];
                  return ListTile(
                    title: Text(
                      '${stop['time'].format(context)} - ${stop['name']}',
                    ),
                    subtitle: Text(
                      'Ubicación: ${stop['location'].latitude}, ${stop['location'].longitude}',
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddStopScreen(onStopAdded: _addStop),
                    ),
                  );

                  if (result != null && result is Map<String, dynamic>) {
                    _addStop(
                      result['name'] as String,
                      result['location'] as LatLng,
                      result['time'] as TimeOfDay,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(45, 75, 115, 1),
                ),
                child: const Text(
                  'Agregar otra Parada',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
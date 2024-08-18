import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_your_route_front/core/constants/colors.dart';
import 'package:share_your_route_front/models/place.dart';
import 'package:share_your_route_front/modules/route_creation/presenters/add_stop_screen.dart';
import 'package:share_your_route_front/modules/route_creation/presenters/view_stops_map_screen.dart';

class RouteStep2 extends StatefulWidget {
  final List<Place> stops;
  final Function(List<Place>) onStopsChanged;

  const RouteStep2({
    super.key,
    required this.stops,
    required this.onStopsChanged,
  });

  @override
  State<RouteStep2> createState() => _RouteStep2State();
}

class _RouteStep2State extends State<RouteStep2> {
  List<Place> stops = [];

  @override
  void initState() {
    super.initState();
    stops = List.from(widget.stops);
  }

  void _addStop(
    String name,
    LatLng ubication,
    TimeOfDay startTime,
    TimeOfDay endTime,
  ) {
    final newStop = Place(
      name: name,
      ubication: ubication,
      startTime: startTime,
      endTime: endTime,
    );
    setState(() {
      if (!stops.any(
        (stop) =>
            stop.name == name &&
            stop.ubication == ubication &&
            stop.startTime == startTime &&
            stop.endTime == endTime,
      )) {
        stops.add(newStop);
      }
    });
    widget.onStopsChanged(stops);
  }

  void _removeStop(int index) {
    setState(() {
      stops.removeAt(index);
    });
    widget.onStopsChanged(stops);
  }

  Future<void> _navigateToAddStopScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddStopScreen(onStopAdded: _addStop),
      ),
    );

    if (result != null && result is Place) {
      _addStop(result.name, result.ubication, result.startTime, result.endTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (stops.isEmpty)
          ElevatedButton(
            onPressed: _navigateToAddStopScreen,
            style: ElevatedButton.styleFrom(
              backgroundColor: yellowAccentColor,
            ),
            child: const Text(
              'Agregar una Parada',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        else
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Paradas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  // color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: stops.length,
                itemBuilder: (context, index) {
                  final stop = stops[index];
                  final startTime = stop.startTime;
                  final endTime = stop.endTime;
                  final name = stop.name;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 2.0),
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: index.isEven ? stopEven : stopOdd,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // ignore: avoid_dynamic_calls
                          '${startTime.format(context)} - ${endTime.format(context)}    $name',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => _removeStop(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: _navigateToAddStopScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: yellowAccentColor,
                ),
                child: const Text(
                  'Agregar otra Parada',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewStopsMapScreen(stops: stops),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowAccentColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Ver todas las paradas en el mapa',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),),
            ],
          ),
      ],
    );
  }
}

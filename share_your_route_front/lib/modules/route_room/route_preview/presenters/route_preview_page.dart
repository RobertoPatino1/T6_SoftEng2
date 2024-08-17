// ignore_for_file: use_super_parameters, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:share_your_route_front/models/place.dart';
import 'package:share_your_route_front/models/tourist_route.dart';
import 'package:share_your_route_front/modules/shared/helpers/dates_comparator.dart';
import 'package:share_your_route_front/modules/shared/helpers/route_type_helper.dart';
import 'package:share_your_route_front/modules/shared/providers/tourist_route_provider.dart';

late TouristRoute activeTouristRoute;

class RouteItineraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    activeTouristRoute =
        // ignore: cast_nullable_to_non_nullable
        TouristRouteService().getCurrentTouristRoute() as TouristRoute;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Modular.to.pop();
            TouristRouteService().unsetCurrentTouristRoute();
          },
        ),
        title: Text(
          activeTouristRoute.name,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage(
                        "asset/images/${activeTouristRoute.image}.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: activeTouristRoute.routeType.map((routeType) {
                    return Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        RouteTypeHelper.getIconData(routeType),
                        size: 30.0,
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Itinerario de rutas',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              // ignore: sized_box_for_whitespace
              Container(
                height: 200,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: activeTouristRoute.placesList.length,
                    itemBuilder: (context, index) {
                      final Place place = activeTouristRoute.placesList[index];
                      final String startTime = activeTouristRoute
                          .placesList[index].startTime
                          .format(context);
                      final String endTime = activeTouristRoute
                          .placesList[index].endTime
                          .format(context);
                      return SizedBox(
                        width: 100,
                        height: 50,
                        child: ItineraryItem(
                          timeStart: startTime,
                          timeEnd: endTime,
                          description: place.name,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  DateFormat("d-MM-yyyy").format(activeTouristRoute.routeDate),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 20),
              if (DateComparator(activeTouristRoute.routeDate) == true) ...[
                Center(
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Ingreso a la ruta",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            content: const Text(
                              "Estás a punto de ingresar a esta ruta",
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  "Cancelar",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "Aceptar",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                onPressed: () {
                                  Modular.to.pushNamed(
                                    '/auth/home/room/active',
                                    arguments: activeTouristRoute,
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Ingresar a la ruta',
                    ),
                  ),
                ),
              ] else ...[
                Center(
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Inscripción a la ruta",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            content: const Text(
                              "Estás a punto de inscribirte a esta ruta",
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  "Cancelar",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "Aceptar",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                onPressed: () {
                                  TouristRouteService()
                                      .unsetCurrentTouristRoute();
                                  Modular.to.pop();
                                  Modular.to.pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Inscribirse a la ruta',
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ItineraryItem extends StatelessWidget {
  final String timeStart;
  final String timeEnd;
  final String description;

  const ItineraryItem({
    required this.timeStart,
    required this.timeEnd,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 37, 60, 89),
        borderRadius: BorderRadius.circular(20), // Aquí redondeas los bordes
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            "$timeStart-$timeEnd",
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

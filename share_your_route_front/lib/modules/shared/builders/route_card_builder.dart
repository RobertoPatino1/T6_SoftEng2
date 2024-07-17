import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:share_your_route_front/core/utils/formats/format_duration.dart';
import 'package:share_your_route_front/models/tourist_route.dart';
import 'package:share_your_route_front/modules/shared/helpers/route_type_helper.dart';
import 'package:share_your_route_front/modules/shared/providers/tourist_route_provider.dart';

class RouteCardBuilder {
  Widget buildRouteCard(BuildContext context, List<TouristRoute> routesList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: routesList.length,
      itemBuilder: (context, index) {
        final TouristRoute touristRoute = routesList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  TouristRouteService().setCurrentTouristRoute(touristRoute);
                  Modular.to
                      .pushNamed('/auth/home/room/', arguments: touristRoute);
                },
                child: Container(
                  width: 160,
                  height: 600,
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 160,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                "asset/images/${touristRoute.image}.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          touristRoute.name,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: touristRoute.routeType.map((routeType) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                RouteTypeHelper.getIconData(routeType),
                                size: 20.0,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 1,
                        ),
                        child: Text(
                          "Fecha: ${DateFormat('dd-MM-2024').format(touristRoute.routeDate)}",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        child: Text(
                          "Hora de Inicio: ${touristRoute.startTime.format(context)}H",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      Container(
                        height: 20,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            touristRoute.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Text(
                          "Duración: ${formatDuration(touristRoute.startTime, touristRoute.endTime)}",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

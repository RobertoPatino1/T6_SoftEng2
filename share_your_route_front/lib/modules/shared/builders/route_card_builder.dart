import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:share_your_route_front/core/constants/colors.dart';
import 'package:share_your_route_front/models/tourist_route.dart';
import 'package:share_your_route_front/modules/shared/helpers/dates_comparator.dart';
import 'package:share_your_route_front/modules/shared/helpers/dates_comparator.dart';
import 'package:share_your_route_front/modules/shared/helpers/route_type_helper.dart';
import 'package:share_your_route_front/modules/shared/providers/tourist_route_provider.dart';

class RouteCardBuilder {
  Widget buildRouteCard(BuildContext context, List<Map<String,dynamic>> routesList) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardBackgroundColor =
        isDarkMode ? darkButtonBackgroundColor : lightButtonBackgroundColor;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final titleColor = isDarkMode ? yellowAccentColor : Colors.black;
    final iconColor = isDarkMode ? yellowAccentColor : lightColorSchemePrimary;

    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: routesList.length,
        itemBuilder: (context, index) {
          final TouristRoute touristRoute = routesList[index]['route'];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    TouristRouteService().setCurrentTouristRoute(routesList[index]);
                    Modular.to.pushNamed(
                      '/auth/home/room/',
                      arguments: touristRoute,
                    );
                  },
                  child: Container(
                    width: 250,
                    height: 600,
                    margin: const EdgeInsets.only(top: 12, bottom: 12),
                    decoration: BoxDecoration(
                      color: cardBackgroundColor,
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
                            width: 250,
                            height: 100,
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
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            touristRoute.name,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: titleColor),
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
                                  color: iconColor,
                                  size: 22.0,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 5),
                        if (DateComparator(touristRoute.routeDate) == true) ...[
                          Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 1,
                              ),
                              child: Text(
                                "Fecha: Hoy",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: textColor),
                              ),
                            ),
                          ),
                        ] else ...[
                          Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 1,
                              ),
                              child: Text(
                                "Fecha: ${DateFormat('dd-MM-2024').format(touristRoute.routeDate)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: textColor),
                              ),
                            ),
                          ),
                        ],
                        Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            child: Text(
                              "${touristRoute.startTime.format(context)} - ${touristRoute.endTime.format(context)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: textColor),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            child: SingleChildScrollView(
                              child: Text(
                                textAlign: TextAlign.center,
                                touristRoute.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: textColor),
                              ),
                            ),
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
      ),
    );
  }
}

// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/constants/route_type.dart';

class RouteTypeHelper {
  static IconData getIconData(RouteType icon) {
    switch (icon) {
      case RouteType.Naturaleza:
        return Icons.nature_people;
      case RouteType.Aventura:
        return Icons.terrain;
      case RouteType.Cultura:
        return Icons.camera_alt;
      case RouteType.Gastronomica:
        return Icons.restaurant_menu;
      case RouteType.Religion:
        return Icons.church;
      case RouteType.Ciudad:
        return Icons.location_city;
    }
  }
}

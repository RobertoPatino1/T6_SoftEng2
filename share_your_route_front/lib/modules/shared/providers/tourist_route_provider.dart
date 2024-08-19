import 'package:flutter/foundation.dart'; // for ValueNotifier
import 'package:share_your_route_front/models/tourist_route.dart';

class TouristRouteService {
  static final TouristRouteService _instance = TouristRouteService._internal();
  factory TouristRouteService() => _instance;

  TouristRouteService._internal();

  ValueNotifier<Map<String,dynamic>?> currentTouristRouteNotifier =
      ValueNotifier<Map<String,dynamic>?>(null);

  // ignore: use_setters_to_change_properties
  void setCurrentTouristRoute(Map<String,dynamic> route) {
    currentTouristRouteNotifier.value = route;
  }

  void unsetCurrentTouristRoute() {
    currentTouristRouteNotifier.value = null;
  }

  Map<String,dynamic>? getCurrentTouristRoute() {
    return currentTouristRouteNotifier.value;
  }
}

import 'package:flutter/foundation.dart'; // for ValueNotifier
import 'package:share_your_route_front/models/tourist_route.dart';

class TouristRouteService {
  static final TouristRouteService _instance = TouristRouteService._internal();
  factory TouristRouteService() => _instance;

  TouristRouteService._internal();

  ValueNotifier<TouristRoute?> currentTouristRouteNotifier =
      ValueNotifier<TouristRoute?>(null);

  // ignore: use_setters_to_change_properties
  void setCurrentTouristRoute(TouristRoute? route) {
    currentTouristRouteNotifier.value = route;
  }

  void unsetCurrentTouristRoute() {
    currentTouristRouteNotifier.value = null;
  }

  TouristRoute? getCurrentTouristRoute() {
    return currentTouristRouteNotifier.value;
  }
}

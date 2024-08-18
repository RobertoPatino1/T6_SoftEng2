import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_your_route_front/core/utils/jsonConverters/data_base_provitional.dart';
import 'package:share_your_route_front/models/place.dart';
import 'package:share_your_route_front/models/tourist_route.dart';

List<Place> places = [
  Place(
    name: "Lugar1",
    ubication: LatLng(2.12414, 79.12314),
    startTime: const TimeOfDay(hour: 3, minute: 30),
    endTime: const TimeOfDay(hour: 3, minute: 40),
  ),
  Place(
    name: "Lugar2",
    ubication: LatLng(2.12414, 79.12314),
    startTime: const TimeOfDay(hour: 3, minute: 40),
    endTime: const TimeOfDay(hour: 3, minute: 50),
  ),
];

void addPrivateRoute(TouristRoute route) {
  privateRoutes.add(route.toJson());
}

List<TouristRoute> listFromJson(List<Map<String, dynamic>> jsonList) {
  final List<TouristRoute> routesList = [];
  for (final json in jsonList) {
    routesList.add(TouristRoute.fromJson(json));
  }
  return routesList;
}

List<Map<String, dynamic>> listToJson(List<TouristRoute> routesList) {
  final List<Map<String, dynamic>> jsonList = [];
  for (final route in routesList) {
    jsonList.add(route.toJson());
  }
  return jsonList;
}

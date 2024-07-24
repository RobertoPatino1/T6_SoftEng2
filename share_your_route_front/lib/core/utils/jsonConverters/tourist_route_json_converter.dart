import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';
import 'package:share_your_route_front/core/utils/jsonConverters/data_base_provitional.dart';
import 'package:share_your_route_front/models/place.dart';
import 'package:share_your_route_front/models/tourist_route.dart';

const apiUrl = "https://shareyourroute-back.onrender.com/api/routes";

List<Place> places = [
  Place(
    name: "Lugar1",
    ubication: const LatLng(2.12414, 79.12314),
    startTime: const TimeOfDay(hour: 3, minute: 30),
    endTime: const TimeOfDay(hour: 3, minute: 40),
  ),
  Place(
    name: "Lugar2",
    ubication: const LatLng(2.12414, 79.12314),
    startTime: const TimeOfDay(hour: 3, minute: 40),
    endTime: const TimeOfDay(hour: 3, minute: 50),
  ),
];

Future<List<Map<String,dynamic>>> fetchAPIData(String url) async {
  final response = await http.get(Uri.parse(apiUrl+url));
  Logger.root.shout(response.body);
  if (response.statusCode == 200) {
    Logger.root.info("Data loaded");
    Logger.root.log(Level.INFO, response.body);
    final List<dynamic> jsonList = json.decode(response.body)as List<dynamic>;
    final List<Map<String,dynamic>> data = List<Map<String,dynamic>>.from(jsonList);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

//obtain data from database
Future<List<Map<String,dynamic>>> getPublicRoutes(){
  const getRoutesUrl = "/all/public";
  return fetchAPIData(apiUrl + getRoutesUrl);
}

void addPublicRoute(TouristRoute route) {
  publicRoutes.add(route.toJson());
}

Future<List<Map<String,dynamic>>> getPrivateRoutes() {
  const getRoutesUrl = "/all/private";
  return fetchAPIData(apiUrl + getRoutesUrl);
}

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

import 'package:share_your_route_front/core/utils/jsonConverters/data_base_provitional.dart';
import 'package:share_your_route_front/models/tourist_route.dart';

//obtain data from database
List<Map<String, dynamic>> getPublicRoutes() {
  return publicRoutes;
}

void addPublicRoute(TouristRoute route) {
  publicRoutes.add(route.toJson());
}

List<Map<String, dynamic>> getPrivateRoutes() {
  return privateRoutes;
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

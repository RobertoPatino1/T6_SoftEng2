import 'package:share_your_route_front/core/utils/jsonConverters/data_base_provitional.dart';
import 'package:share_your_route_front/models/place.dart';
import 'package:share_your_route_front/models/tourist_route.dart';

List<Map<Place, DateTime>> places = [
  {Place(name: "Lugar1", entryPrice: 0.0): DateTime(2023, 6, 9, 10, 30)},
  {Place(name: "Lugar2", entryPrice: 0.0): DateTime(2023, 6, 9, 11)},
  {Place(name: "Lugar3", entryPrice: 0.0): DateTime(2023, 6, 9, 11, 30)},
  {Place(name: "Lugar4", entryPrice: 0.0): DateTime(2023, 6, 9, 12)},
  {Place(name: "Lugar5", entryPrice: 0.0): DateTime(2023, 6, 9, 12, 15)},
];

//obtain data from database
List<Map<String, dynamic>> getPublicRoutes() {
  return publicRoutes;
}

List<Map<String, dynamic>> getPrivateRoutes() {
  return privateRoutes;
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

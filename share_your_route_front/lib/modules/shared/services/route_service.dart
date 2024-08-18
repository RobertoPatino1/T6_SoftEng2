import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_your_route_front/core/utils/jsonConverters/data_base_provitional.dart';
import 'package:share_your_route_front/core/utils/jsonConverters/tourist_route_json_converter.dart';
import 'package:share_your_route_front/models/tourist_route.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;

const apiUrl = "https://shareyourroute-back.onrender.com/api/routes";

Future<List<Map<String, dynamic>>> fetchAPIData(String url) async {
  final response = await http.get(Uri.parse(apiUrl + url));
  Logger.root.shout(response.body);
  if (response.statusCode == 200) {
    Logger.root.info("Data loaded");
    Logger.root.log(Level.INFO, response.body);
    final List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
    final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(jsonList);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<void> addRoute(String url, Map<String, dynamic> routeData) async {
  final response = await http.post(
    Uri.parse(apiUrl + url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(routeData),
  );

  Logger.root.shout(response.body);
  if (response.statusCode == 201) {
    // HTTP status code 201 indicates successful creation
    Logger.root.info("Route added successfully");
    Logger.root.log(Level.INFO, response.body);
  } else {
    throw Exception('Failed to add route');
  }
}

class RouteService {
  List<TouristRoute> touristRouteList = [];

  RouteService._();

  static Future<RouteService> create() async {
    final service = RouteService._();
    await service.loadInitialRouteData();
    return service;
  }

  Future<void> loadInitialRouteData() async {
    try {
      final String contents = await rootBundle
          .loadString('asset/provisional_database/tourist_route.json');

      final dynamic jsonData = jsonDecode(contents);

      if (jsonData is List) {
        final List<Map<String, dynamic>> listOfMaps =
            jsonData.map((item) => item as Map<String, dynamic>).toList();

        touristRouteList = listFromJson(listOfMaps);
      } else {
        // ignore: avoid_print
        print('El contenido JSON no es una lista.');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error al leer o parsear el archivo: $e');
    }
  }

  //obtain data from database
  Future<List<Map<String, dynamic>>> getPublicRoutes() {
    const getRoutesUrl = "/all/public";
    return fetchAPIData(apiUrl + getRoutesUrl);
  }

  void addPublicRoute(TouristRoute route) {
    publicRoutes.add(route.toJson());
  }

  Future<List<Map<String, dynamic>>> getPrivateRoutes() {
    const getRoutesUrl = "/all/private";
    return fetchAPIData(apiUrl + getRoutesUrl);
  }

  Future<void> createData(TouristRoute newData) async {
    touristRouteList.add(newData);
    await _updateLocalData();
  }

  Future<void> updateData(String name, TouristRoute updatedData) async {
    final int index = touristRouteList.indexWhere((item) => item.name == name);
    if (index != -1) {
      touristRouteList[index] = updatedData;
      await _updateLocalData();
    }
  }

  Future<void> deleteData(String name) async {
    touristRouteList.removeWhere((item) => item.name == name);
    await _updateLocalData();
  }

  Future<void> _updateLocalData() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = path.join(directory.path, 'tourist_route.json');
    final List<Map<String, dynamic>> jsonData =
        touristRouteList.map((item) => item.toJson()).toList();
    File(filePath).writeAsStringSync(jsonEncode(jsonData));
  }
}

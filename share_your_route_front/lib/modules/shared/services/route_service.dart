import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:share_your_route_front/core/utils/jsonConverters/tourist_route_json_converter.dart';
import 'package:share_your_route_front/models/tourist_route.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class RouteService {
  List<TouristRoute> touristRouteList = [];

  RouteService._();

  static Future<RouteService> create() async {
    var service = RouteService._();
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
        print(touristRouteList);
      } else {
        print('El contenido JSON no es una lista.');
      }
    } catch (e) {
      print('Error al leer o parsear el archivo: $e');
    }
  }

  Future<List<TouristRoute>> fetchRouteData() async {
    print(touristRouteList);
    return touristRouteList;
  }

  Future<void> createData(TouristRoute newData) async {
    touristRouteList.add(newData);
    await _updateLocalData();
  }

  Future<void> updateData(String name, TouristRoute updatedData) async {
    int index = touristRouteList.indexWhere((item) => item.name == name);
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
    List<Map<String, dynamic>> jsonData =
        touristRouteList.map((item) => item.toJson()).toList();
    File(filePath).writeAsStringSync(jsonEncode(jsonData));
  }
}

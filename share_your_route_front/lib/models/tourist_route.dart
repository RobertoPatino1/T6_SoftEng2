// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_your_route_front/core/constants/route_type.dart';
import 'package:share_your_route_front/models/place.dart';
import 'package:share_your_route_front/modules/shared/providers/api_provider.dart';

class TouristRoute {
  final String name;
  final List<Place> placesList;
  int currentPlaceIndex;
  final int numberPeople;
  final int numberGuides;
  final bool routeIsPublic;
  final DateTime routeDate;
  final LatLng startingPoint;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String image;
  final String description;
  final bool hasStarted;
  final List<RouteType> routeType;

  TouristRoute({
    required this.name,
    required this.placesList,
    required this.currentPlaceIndex,
    required this.numberPeople,
    required this.numberGuides,
    required this.routeIsPublic,
    required this.routeDate,
    required this.startingPoint,
    required this.startTime,
    required this.endTime,
    required this.image,
    required this.description,
    required this.hasStarted,
    required this.routeType,
  });

   Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> encodedPlacesList =
        placesList.map((place) => place.toJson()).toList();

    final List<String> encodedRouteType =
        routeType.map((e) => e.toString().split('.')[1]).toList();

    return {
      'name': name,
      'placesList': encodedPlacesList,
      'currentPlaceIndex': currentPlaceIndex,
      'numberPeople': numberPeople,
      'numberGuides': numberGuides,
      'routeIsPublic': routeIsPublic,
      'routeDate': routeDate.toIso8601String(),
      'startingPoint': {
        'latitude': startingPoint.latitude,
        'longitude': startingPoint.longitude,
      },
      'startTime': {
        'hour': startTime.hour,
        'minute': startTime.minute,
      },
      'endTime': {
        'hour': endTime.hour,
        'minute': endTime.minute,
      },
      'image': image,
      'description': description,
      'hasStarted': hasStarted,
      'routeType': encodedRouteType,
    };
  }

  void save() {
    saveRoute(toJson());
  }
}

  Map<String,dynamic> getRouteWithId(Map<String, dynamic> json) {
    Map<String,dynamic> routeWithId;
    final List<dynamic> decodedPlacesList = json['placesList'] as List<dynamic>;

    final List<Place> placesList = decodedPlacesList.map((placeMap) {
      return Place.fromJson(placeMap as Map<String, dynamic>);
    }).toList();

     TouristRoute touristRoute= new TouristRoute(
      name: json['name'] as String,
      placesList: placesList,
      currentPlaceIndex: json['currentPlaceIndex'] as int,
      numberPeople: json['numberPeople'] as int,
      numberGuides: json['numberGuides'] as int,
      routeIsPublic: json['routeIsPublic'] as bool,
      routeDate: DateTime.parse(json['routeDate'] as String),
      startingPoint: LatLng(
        json['startingPoint']['latitude'] as double,
        json['startingPoint']['longitude'] as double,
      ),
      startTime: TimeOfDay(
        hour: json['startTime']['hour'] as int,
        minute: json['startTime']['minute'] as int,
      ),
      endTime: TimeOfDay(
        hour: json['endTime']['hour'] as int,
        minute: json['endTime']['minute'] as int,
      ),
      image: json['image'] as String,
      description: json['description'] as String,
      hasStarted: json['hasStarted'] as bool,
      routeType: (json['routeType'] as List<dynamic>)
          .map(
            (e) => RouteType.values.firstWhere(
              (element) => element.toString().split('.')[1] == e,
            ),
          )
          .toList(),
    );

    routeWithId = {
      "id" : json['id'],
      "creator" : json['ownerUid'],
      "route" : touristRoute
    };

    return routeWithId;

  }

  


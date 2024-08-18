// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String name;
  final LatLng ubication;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  Place({
    required this.name,
    required this.ubication,
    required this.startTime,
    required this.endTime,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'] as String,
      ubication: LatLng(
        json['ubication']['latitude'] as double,
        json['ubication']['longitude'] as double,
      ),
      startTime: TimeOfDay(
        hour: json['startTime']['hour'] as int,
        minute: json['startTime']['minute'] as int,
      ),
      endTime: TimeOfDay(
        hour: json['endTime']['hour'] as int,
        minute: json['endTime']['minute'] as int,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ubication': {
        'latitude': ubication.latitude,
        'longitude': ubication.longitude,
      },
      'startTime': {
        'hour': startTime.hour,
        'minute': startTime.minute,
      },
      'endTime': {
        'hour': endTime.hour,
        'minute': endTime.minute,
      },
    };
  }
}

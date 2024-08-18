import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// ignore: avoid_classes_with_only_static_members
class MapConstants {
  static final globalNavigatorKey = GlobalKey<NavigatorState>();
  static String? googleApiKey = dotenv.env['GOOGLE_API_KEY'];
  static const darkMapStylePath = 'asset/json/dark_mode_style.json';
  static const lightMapStylePath = 'asset/json/light_mode_style.json';
  static const androidLocationIntentAddress =
      'android.settings.LOCATION_SOURCE_SETTINGS';
}

import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_your_route_front/core/constants/map_contants.dart';
import 'package:share_your_route_front/modules/shared/builders/custom_dialogue_route.dart';

class PermissionProvider {
  static PermissionStatus locationPermission = PermissionStatus.denied;
  static DialogRoute? permissionDialogRoute;
  static bool isServiceOn = false;

  static Future<void> handleLocationPermission() async {
    isServiceOn = await Permission.location.serviceStatus.isEnabled;
    locationPermission = await Permission.location.status;
    if (isServiceOn) {
      switch (locationPermission) {
        case PermissionStatus.permanentlyDenied:
          permissionDialogRoute = myCustomDialogRoute(
              title: "Location Service",
              text:
                  "To use navigation, please allow location usage in settings.",
              buttonText: "Go To Settings",
              onPressed: () {
                Navigator.of(MapConstants.globalNavigatorKey.currentContext!)
                    .removeRoute(PermissionProvider.permissionDialogRoute!);
                openAppSettings();
              });
          Navigator.of(MapConstants.globalNavigatorKey.currentContext!)
              .push(permissionDialogRoute!);
        case PermissionStatus.denied:
          Permission.location.request().then((value) {
            locationPermission = value;
          });
          break;
        default:
      }
    } else {
      permissionDialogRoute = myCustomDialogRoute(
          title: "Location Service",
          text: "To use navigation, please turn location service on.",
          buttonText: Platform.isAndroid ? "Turn It On" : "Ok",
          onPressed: () {
            Navigator.of(MapConstants.globalNavigatorKey.currentContext!)
                .removeRoute(PermissionProvider.permissionDialogRoute!);
            if (Platform.isAndroid) {
              const AndroidIntent intent =
                  AndroidIntent(action: MapConstants.androidLocationIntentAddress);
              intent.launch();
            } else {
              // TODO: ios integration
            }
          });
      Navigator.of(MapConstants.globalNavigatorKey.currentContext!)
          .push(permissionDialogRoute!);
    }
  }
}
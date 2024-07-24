import 'package:flutter/material.dart';

String formatDuration(TimeOfDay startTime, TimeOfDay endTime) {
  final int startMinutes = startTime.hour * 60 + startTime.minute;
  final int endMinutes = endTime.hour * 60 + endTime.minute;

  final int differenceInMinutes = endMinutes - startMinutes;

  final int hours = differenceInMinutes ~/ 60;
  final int minutes = differenceInMinutes % 60;
  String formattedDuration = '';

  if (minutes > 0) {
    formattedDuration = '$hours horas con $minutes minutos';
  } else {
    formattedDuration = '$hours horas';
  }
  return formattedDuration;
}

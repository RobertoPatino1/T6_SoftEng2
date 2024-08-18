import 'package:intl/intl.dart';

String getDropOffTime(num duration) {
  final int minutes = (duration / 60).round();
  final int seconds = (duration % 60).round();
  final DateTime tripEndDateTime =
      DateTime.now().add(Duration(minutes: minutes, seconds: seconds));
  final String dropOffTime = DateFormat.jm().format(tripEndDateTime);
  return dropOffTime;
}

// ignore_for_file: non_constant_identifier_names

bool DateComparator(DateTime routeDate) {
  return DateTime(routeDate.year, routeDate.month, routeDate.day) ==
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
}

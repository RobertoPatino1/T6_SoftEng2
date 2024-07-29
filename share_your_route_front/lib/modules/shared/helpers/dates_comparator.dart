bool DateComparator(DateTime routeDate) {
  return DateTime(routeDate.year, routeDate.month, routeDate.day) ==
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
}

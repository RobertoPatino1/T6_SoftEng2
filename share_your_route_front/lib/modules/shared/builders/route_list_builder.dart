import 'package:flutter/material.dart';

class RouteListBuilder {
  Widget buildRouteList(BuildContext context, String routeListName) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(left: 10, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: Theme.of(context).textTheme.headlineMedium!.fontSize,
            color: const Color.fromRGBO(191, 141, 48, 1),
            margin: const EdgeInsets.only(right: 5),
          ),
          Text(
            routeListName,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}

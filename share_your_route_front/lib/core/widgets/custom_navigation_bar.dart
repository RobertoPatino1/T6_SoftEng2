import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentPageIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomNavigationBar({
    super.key,
    required this.currentPageIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return NavigationBar(
      backgroundColor: const Color.fromARGB(189, 227, 227, 227),
      height: 60,
      onDestinationSelected: onDestinationSelected,
      indicatorColor: const Color.fromRGBO(37, 60, 89, 0),
      selectedIndex: currentPageIndex,
      destinations: <Widget>[
        NavigationDestination(
          selectedIcon: Icon(
            Icons.explore,
            size: 20,
            color: theme.colorScheme.primary,
          ),
          icon: const Icon(
            Icons.explore_outlined,
            size: 20,
            color: Colors.grey,
          ),
          label: 'Explorar',
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.notifications,
            size: 20,
            color: theme.colorScheme.primary,
          ),
          icon: const Icon(
            Icons.notifications_outlined,
            size: 20,
            color: Colors.grey,
          ),
          label: 'Notificaciones',
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.person,
            size: 20,
            color: theme.colorScheme.primary,
          ),
          icon: const Icon(
            Icons.person,
            size: 20,
            color: Colors.grey,
          ),
          label: 'Perfil',
        ),
      ],
    );
  }
}

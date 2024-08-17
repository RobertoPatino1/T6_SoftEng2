import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentPageIndex;
  final ValueChanged<int> onDestinationSelected;
  final int unreadNotificationsCount;

  const CustomNavigationBar({
    super.key,
    required this.currentPageIndex,
    required this.onDestinationSelected,
    required this.unreadNotificationsCount,
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
        Stack(
          children: [
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
            if (unreadNotificationsCount > 0)
              Positioned(
                right: 52,
                top: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '$unreadNotificationsCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.person,
            size: 20,
            color: theme.colorScheme.primary,
          ),
          icon: const Icon(
            Icons.person_outlined,
            size: 20,
            color: Colors.grey,
          ),
          label: 'Perfil',
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/constants/colors.dart';

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
    final isDarkMode = theme.brightness == Brightness.dark;
    final customNavBarBackgroundColor =
        isDarkMode ? darkButtonBackgroundColor : lightButtonBackgroundColor;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final selectionColor = isDarkMode ? yellowAccentColor : Colors.black;

    return NavigationBar(
      backgroundColor: customNavBarBackgroundColor.withOpacity(0.6),
      height: 60,
      onDestinationSelected: onDestinationSelected,
      indicatorColor: selectionColor.withOpacity(0.2),
      selectedIndex: currentPageIndex,
      destinations: <Widget>[
        NavigationDestination(
          selectedIcon: Icon(
            Icons.explore,
            size: 30,
            color: selectionColor,
          ),
          icon: Icon(
            Icons.explore_outlined,
            size: 30,
            color: textColor,
          ),
          label: 'Explorar',
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.notifications,
            size: 30,
            color: selectionColor,
          ),
          icon: Icon(
            Icons.notifications_outlined,
            size: 30,
            color: textColor,
          ),
          label: 'Notificaciones',
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.person,
            size: 30,
            color: selectionColor,
          ),
          icon: Icon(
            Icons.person_outlined,
            size: 30,
            color: textColor,
          ),
          label: 'Perfil',
        ),
      ],
    );
  }
}

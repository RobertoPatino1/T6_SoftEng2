import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_your_route_front/core/constants/colors.dart';
import 'package:share_your_route_front/core/constants/route_type.dart';
import 'package:share_your_route_front/core/utils/jsonConverters/tourist_route_json_converter.dart';
import 'package:share_your_route_front/core/widgets/custom_navigation_bar.dart';
import 'package:share_your_route_front/models/tourist_route.dart';
import 'package:share_your_route_front/modules/notification/presenters/notification_page.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_view.dart';
import 'package:share_your_route_front/modules/route_creation/presenters/route_creation_screen.dart';
import 'package:share_your_route_front/modules/shared/builders/route_card_builder.dart';
import 'package:share_your_route_front/modules/shared/builders/route_list_builder.dart';
import 'package:share_your_route_front/modules/shared/helpers/dates_comparator.dart';
import 'package:share_your_route_front/modules/shared/providers/api_provider.dart';
import 'package:share_your_route_front/modules/shared/providers/tourist_route_provider.dart';
import 'package:share_your_route_front/modules/shared/services/route_service.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';

List<TouristRoute> routeList = [];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late final RouteService routeService;
  late TouristRouteService _touristRouteService;
  int currentPageIndex = 0;
  late PageController _pageController;
  int unreadNotificationsCount = 3;
  final List<NotificationItem> notifications = [
    NotificationItem("Actualizacion de sus rutas favoritas",
        "Detalles del mensaje 1", DateTime.now(),),
    NotificationItem("Registro en ruta 'El Dorado'", "Detalles del mensaje 2",
        DateTime.now().subtract(const Duration(hours: 1)),),
    NotificationItem("Cambios en ruta 'Ceibos'", "Detalles del mensaje 3",
        DateTime.now().subtract(const Duration(days: 1)),),
  ];


  void _handleUnreadCountChanged(int count) {
    setState(() {
      unreadNotificationsCount = count;
    });
  }

  @override
  void initState() {
    super.initState();
    _touristRouteService = TouristRouteService();
    _touristRouteService.currentTouristRouteNotifier
        .addListener(_onTouristRouteChange);
    _pageController = PageController(initialPage: currentPageIndex);
    _handleUnreadCountChanged(notifications.where((n) => !n.isRead).length);
  }

  @override
  void dispose() {
    _touristRouteService.currentTouristRouteNotifier
        .removeListener(_onTouristRouteChange);
    _pageController.dispose();
    super.dispose();
  }

  void _onTouristRouteChange() {
    setState(() {});
  }

  void _onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
      if (index == 1) {
        _handleUnreadCountChanged(notifications.where((n) => !n.isRead).length);
      }
    });
  }

  void _onDestinationSelected(int index) {
    setState(() {
      currentPageIndex = index;
    });

    if (index == 1) {
      _handleUnreadCountChanged(notifications.where((n) => !n.isRead).length);
    }

    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final topNavBarBackgroundColor =
        isDarkMode ? darkButtonBackgroundColor : lightButtonBackgroundColor;

    Theme.of(context);
    final TouristRoute? currentRoute =
        _touristRouteService.getCurrentTouristRoute();
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        currentPageIndex: currentPageIndex,
        onDestinationSelected: _onDestinationSelected,
        unreadNotificationsCount: unreadNotificationsCount,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        children: <Widget>[
          Column(
            children: <Widget>[
              if (currentRoute == null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 50,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    color: topNavBarBackgroundColor.withOpacity(0.6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Es hora de una nueva aventura!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "¿Deseas crear una ruta?",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
                          navigateWithSlideTransition(
                            context,
                            const CreateRoute(),
                          );
                        },
                        child: const IntrinsicWidth(
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Empezar una ruta'),
                                SizedBox(width: 2.1),
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "Ruta en curso:",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentRoute.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Modular.to.pushNamed('/auth/home/room/');
                          Modular.to.pushNamed('/auth/home/room/active');
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BlinkingDot(),
                            SizedBox(width: 8),
                            Text("Seguir ruta"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Expanded(
                child: SingleChildScrollView(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: getAllRoutes(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<TouristRoute> routeList =
                            listFromJson(snapshot.data!);
                        final todayRoutes = routeList.where((ruta) {
                          return DateComparator(ruta.routeDate);
                        }).toList();
                        return Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 30,
                            ),
                            if (todayRoutes.isNotEmpty) ...[
                              RouteListBuilder()
                                  .buildRouteList(context, "Rutas de hoy"),
                              RouteCardBuilder().buildRouteCard(
                                context,
                                todayRoutes,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                            RouteListBuilder().buildRouteList(
                              context,
                              "Rutas dentro de la ciudad",
                            ),
                            RouteCardBuilder().buildRouteCard(
                              context,
                              routeList
                                  .where(
                                    (ruta) => ruta.routeType
                                        .contains(RouteType.Ciudad),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            RouteListBuilder().buildRouteList(
                                context, "Día en la naturaleza ",),
                            RouteCardBuilder().buildRouteCard(
                              context,
                              routeList
                                  .where(
                                    (ruta) => ruta.routeType
                                        .contains(RouteType.Naturaleza),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            RouteListBuilder()
                                .buildRouteList(context, "Cultura e Historia"),
                            RouteCardBuilder().buildRouteCard(
                              context,
                              routeList
                                  .where(
                                    (ruta) => ruta.routeType
                                        .contains(RouteType.Cultura),
                                  )
                                  .toList(),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ),
            ],
          ),
          NotificationPage(
            notifications: notifications,
            onUnreadCountChanged: _handleUnreadCountChanged,
          ),
          ProfileView(),
        ],
      ),
    );
  }
}

class BlinkingDot extends StatefulWidget {
  const BlinkingDot({super.key});

  @override
  _BlinkingDotState createState() => _BlinkingDotState();
}

class _BlinkingDotState extends State<BlinkingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_your_route_front/core/constants/route_type.dart';
import 'package:share_your_route_front/core/utils/jsonConverters/tourist_route_json_converter.dart';
import 'package:share_your_route_front/models/tourist_route.dart';
import 'package:share_your_route_front/modules/shared/builders/route_card_builder.dart';
import 'package:share_your_route_front/modules/shared/helpers/route_type_helper.dart';
import 'package:share_your_route_front/modules/shared/providers/tourist_route_provider.dart';
import 'package:share_your_route_front/modules/shared/services/route_service.dart';

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
  List<TouristRoute> routeList = [];
  late TouristRouteService _touristRouteService;
  int currentPageIndex = 0;

  Future<void> _loadData() async {
    routeService = await RouteService.create();
    final routes = await routeService.fetchRouteData();
    setState(() {
      routeList = routes;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _touristRouteService = TouristRouteService();
    _touristRouteService.currentTouristRouteNotifier
        .addListener(_onTouristRouteChange);
  }

  @override
  void dispose() {
    _touristRouteService.currentTouristRouteNotifier
        .removeListener(_onTouristRouteChange);
    super.dispose();
  }

  void _onTouristRouteChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TouristRoute? currentRoute =
        _touristRouteService.getCurrentTouristRoute();

    print(listFromJson(
      getPublicRoutes(),
    ).length);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromRGBO(37, 60, 89, 0),
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon:
                Icon(Icons.explore, size: 20, color: theme.colorScheme.primary),
            icon: const Icon(Icons.explore_outlined,
                size: 20, color: Colors.grey),
            label: 'Explorar',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.notifications,
                size: 20, color: theme.colorScheme.primary),
            icon: const Icon(Icons.notifications_outlined,
                size: 20, color: Colors.grey),
            label: 'Notificaciones',
          ),
          NavigationDestination(
            selectedIcon:
                Icon(Icons.person, size: 20, color: theme.colorScheme.primary),
            icon: const Icon(Icons.person, size: 20, color: Colors.grey),
            label: 'Perfil',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: <Widget>[
          Column(
            children: <Widget>[
              if (currentRoute == null) ...[
                Container(
                  height: 250,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        "Es hora de una nueva aventura!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "¿Deseas crear una ruta?",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Modular.to.pushNamed('/auth/home/creation');
                        },
                        child: const IntrinsicWidth(
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Empezar una ruta'),
                                SizedBox(width: 2.1),
                                Icon(Icons.play_arrow,
                                    color: Colors.white, size: 15),
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
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 10, right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 4,
                              height: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .fontSize,
                              color: const Color.fromRGBO(191, 141, 48, 1),
                              margin: const EdgeInsets.only(right: 5),
                            ),
                            Text(
                              "Rutas privadas",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: RouteCardBuilder().buildRouteCard(
                          context,
                          routeList
                              .where((ruta) =>
                                  ruta.routeType.contains(RouteType.city))
                              .toList(),
                        ), // Color added for testing scroll
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 10, right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 4,
                              height: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .fontSize,
                              color: const Color.fromRGBO(191, 141, 48, 1),
                              margin: const EdgeInsets.only(right: 5),
                            ),
                            Text(
                              "Rutas publicas",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: RouteCardBuilder().buildRouteCard(
                          context,
                          routeList, // Replace with your data source
                        ), // Color added for testing scroll
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Messages page
          Container(
            alignment: Alignment.center,
            child: Text(
              "Muy pronto!!!",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          //Profile page
          Container(
            alignment: Alignment.center,
            child: Text(
              "Muy pronto!!!",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
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

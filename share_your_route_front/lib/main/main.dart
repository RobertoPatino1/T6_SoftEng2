// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_your_route_front/modules/auth/auth_module.dart';
import 'package:share_your_route_front/modules/shared/themes/global_theme_data.dart';

Future main() async {
  await dotenv.load(fileName: "lib/core/configs/.env");
  return runApp(
    ProviderScope(
      child: ModularApp(module: AppModule(), child: AppWidget()),
    ),
  );
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Share your route',
      themeMode: ThemeMode.light,
      theme: GlobalThemeData.lightThemeData,
      routerConfig: Modular.routerConfig,
    ); //added by extension
  }
}

class AppModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => MainPage());
    r.module('/auth', module: AuthModule());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Modular.to.navigate('/auth/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: 200,
                  height: 150,
                  child: Image.asset('asset/images/logo.png'),
                ),
              ),
            ),
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 20),
            Text('Cargando...'),
          ],
        ),
      ),
    );
  }
}

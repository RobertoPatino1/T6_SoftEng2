import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_your_route_front/modules/auth/auth_module.dart';
import 'package:share_your_route_front/modules/shared/ui/themes/global_theme_data.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/core/configs/.env");
  runApp(
    ProviderScope(
      child: ModularApp(module: AppModule(), child: AppWidget()),
    ),
  );
}

class AppWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Share your route',
      themeMode: themeMode,
      theme: GlobalThemeData.lightThemeData,
      darkTheme: GlobalThemeData.darkThemeData,
      routerConfig: Modular.routerConfig,
    );
  }
}

class AppModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const MainPage());
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
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    final status = await Permission.location.status;
    if (status.isDenied) {
      await _showLocationDialog();
    } else if (status.isGranted) {
      await _determinePositionAndNavigate();
    } else if (status.isPermanentlyDenied) {
      await _showLocationDeniedDialog();
    }
  }

  Future<void> _showLocationDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permiso de ubicación necesario'),
        content: const Text(
          'Para utilizar esta aplicación, necesitas permitir el acceso a tu ubicación.',
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final status = await Permission.location.request();
              if (status.isGranted) {
                await _determinePositionAndNavigate();
              } else if (status.isDenied) {
                await _showLocationDeniedDialog();
              }
            },
            child: const Text('Aceptar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  Future<void> _showLocationDeniedDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubicación denegada'),
        content: const Text(
          'No se puede acceder a la aplicación sin permiso de ubicación.',
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final status = await Permission.location.request();
              if (status.isGranted) {
                await _determinePositionAndNavigate();
              }
            },
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Future<void> _determinePositionAndNavigate() async {
    try {
      await determinePosition();
      Timer(const Duration(seconds: 3), () {
        Modular.to.navigate('/auth/');
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener la ubicación: $error')),
      );
    }
  }

  Future<Position> determinePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Error: Permiso de ubicación denegado");
      }
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
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
            const SizedBox(height: 20),
            const Text('Cargando...'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:share_your_route_front/core/constants/urls.dart';
import 'package:share_your_route_front/main/main.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class AccesibilityScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: "Accesibilidad"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          Image.asset(
            accessibilityScreenLogoURL,
            width: 300,
            height: 300,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 229, 229),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('Tema Oscuro'),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) async {
                  Vibrate.vibrate();

                  final newThemeMode = value ? ThemeMode.dark : ThemeMode.light;
                  ref.read(themeModeProvider.notifier).state = newThemeMode;
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

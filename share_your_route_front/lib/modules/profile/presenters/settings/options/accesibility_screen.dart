import 'package:flutter/material.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class AccesibilityScreen extends StatefulWidget {
  @override
  _AccessibilitySettingsPageState createState() =>
      _AccessibilitySettingsPageState();
}

class _AccessibilitySettingsPageState extends State<AccesibilityScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Accesibilidad"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          Image.asset(
            'asset/images/accessibility_screen_img.png',
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
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                    // TODO: Aquí es donde se cambia el tema de la aplicación
                    if (isDarkMode) {
                      // TODO:Cambiar al tema oscuro
                      // TODO:Cambia el tema globalmente usando el ThemeData o un ThemeMode
                    } else {
                      // TODO:Cambiar al tema claro
                    }
                  });
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

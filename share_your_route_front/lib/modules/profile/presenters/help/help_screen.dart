import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/utils/animations/page_transitions.dart';
import 'package:share_your_route_front/modules/profile/presenters/help/options/licence_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/help/options/terms_and_privacy_screen.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),

          Image.asset(
            'asset/images/help_screen_img.jpg',
            width: 500,
            height: 500,
            fit: BoxFit.contain,
          ),
          const Spacer(flex: 2),
          // Opciones
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 229, 229),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                _buildOption(
                  context,
                  Icons.description,
                  'Términos y Políticas',
                  const TermsAndPrivacyScreen(),
                ),
                _buildDivider(),
                _buildOption(
                  context,
                  Icons.lock,
                  'Licencia',
                  const LicenseScreen(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ), // Espacio entre las opciones y el texto de propiedad
          Text(
            '© 2024 Share Your Route LLC™',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context,
    IconData icon,
    String title,
    Widget page,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Acción al tocar la opción
          navigateWithSlideTransition(context, page);
        },
        splashColor: Colors.grey,
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    );
  }
}

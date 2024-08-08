import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/utils/animations/page_transitions.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_options.dart';
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'asset/images/help_screen_img.jpg',
              width: double.infinity,
              height: 400,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            ProfileOptions(
              optionGroups: [
                OptionGroup(
                  options: [
                    OptionItem(
                      icon: Icons.description,
                      title: 'Términos y Políticas',
                      onTap: () async {
                        navigateWithSlideTransition(
                          context,
                          const TermsAndPrivacyScreen(),
                        );
                      },
                    ),
                    OptionItem(
                      icon: Icons.lock,
                      title: 'Licencia',
                      onTap: () async {
                        navigateWithSlideTransition(
                          context,
                          const LicenseScreen(),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
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
      ),
    );
  }
}

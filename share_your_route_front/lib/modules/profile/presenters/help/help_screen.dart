import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/constants/urls.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_options.dart';
import 'package:share_your_route_front/modules/profile/presenters/help/options/licence_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/help/options/terms_and_privacy_screen.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Ayuda"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              helpScreenLogoURL,
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
                      title: 'Licencias',
                      onTap: () async {
                        navigateWithSlideTransition(
                          context,
                          const LicenseScreen(),
                        );
                      },
                    ),
                  ],
                ),
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

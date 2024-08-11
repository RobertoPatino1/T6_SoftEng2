import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/constants/urls.dart';
import 'package:share_your_route_front/modules/profile/presenters/about/about_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_header.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_options.dart';
import 'package:share_your_route_front/modules/profile/presenters/help/help_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/routes/created_routes_history.dart';
import 'package:share_your_route_front/modules/profile/presenters/routes/joined_routes_history.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/settings_screen.dart';
import 'package:share_your_route_front/modules/shared/services/auth_service.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int currentPageIndex = 2;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileHeader(
              imagePath: stockProfilePictureURL,
              name: 'John Doe',
              email: 'johndoe@example.com',
              backgroundImagePath: stockBackgroundPictureURL,
              bio: 'Edita tu bio desde ajustes.',
            ),
            const SizedBox(height: 20),
            ProfileOptions(
              optionGroups: [
                OptionGroup(
                  options: [
                    OptionItem(
                      icon: Icons.route,
                      title: 'Rutas creadas',
                      onTap: () async {
                        navigateWithSlideTransition(
                          context,
                          const CreatedRoutesHistory(),
                        );
                      },
                    ),
                    OptionItem(
                      icon: Icons.backpack,
                      title: 'Rutas a las que te has unido',
                      onTap: () async {
                        navigateWithSlideTransition(
                          context,
                          const JoinedRoutesHistory(),
                        );
                      },
                    ),
                  ],
                ),
                OptionGroup(
                  options: [
                    OptionItem(
                      icon: Icons.settings,
                      title: 'Ajustes',
                      onTap: () async {
                        navigateWithSlideTransition(context, SettingsView());
                      },
                    ),
                    OptionItem(
                      icon: Icons.help,
                      title: 'Ayuda',
                      onTap: () async {
                        navigateWithSlideTransition(
                          context,
                          const HelpScreen(),
                        );
                      },
                    ),
                    OptionItem(
                      icon: Icons.info,
                      title: 'Información',
                      onTap: () async {
                        navigateWithSlideTransition(
                          context,
                          const AboutScreen(),
                        );
                      },
                    ),
                    OptionItem(
                      icon: Icons.logout,
                      title: 'Cerrar sesión',
                      onTap: () async {
                        _authService.logout();
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

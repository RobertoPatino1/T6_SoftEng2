import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/utils/animations/page_transitions.dart';
import 'package:share_your_route_front/modules/profile/presenters/about/about_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_header.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_options.dart';
import 'package:share_your_route_front/modules/profile/presenters/help/help_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/routes/created_routes_history.dart';
import 'package:share_your_route_front/modules/profile/presenters/routes/joined_routes_history.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/settings_screen.dart';
import 'package:share_your_route_front/modules/shared/services/auth_service.dart';

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
              imagePath:
                  'asset/images/centro_artistico.jpg', // Cambiar a la imagen de perfil del usuario
              name: 'John Doe',
              email: 'johndoe@example.com',
              backgroundImagePath: 'asset/images/aventura_ciudad.jpg',
              bio:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In fringilla nibh non vulputate iaculis. Sed id ligula quis sapien ultricies lobortis quis sit amet massa. Nam convallis, lectus et posuere fermentum, augue tellus mollis velit, vitae aliquam dolor lectus at libero. In at luctus ante. Pellentesque mattis urna metus, et dignissim diam lobortis vitae.', // TODO: Cambiar esta biografía a ser dinámica
            ),
            const SizedBox(height: 20),
            ProfileOptions(
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
        ),
      ),
    );
  }
}

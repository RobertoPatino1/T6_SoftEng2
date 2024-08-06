import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_header.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_options.dart';
import 'package:share_your_route_front/modules/shared/services/auth_service.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int currentPageIndex = 2; // Perfil page index
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileHeader(
              imagePath:
                  'asset/images/centro_artistico.jpg', // TODO: Change profile image to the user profile image
              name: 'John Doe',
              email: 'johndoe@example.com',
            ),
            const SizedBox(height: 20),
            ProfileOptions(
              options: [
                OptionItem(
                  icon: Icons.route,
                  title: 'Rutas creadas',
                  onTap: () async {
                    // TODO: SHOW ALL THE ROUTES THAT THE USER HAS CREATED IN A LIST
                  },
                ),
                OptionItem(
                  icon: Icons.backpack,
                  title: 'Rutas a las que te has unido',
                  onTap: () async {
                    // TODO: SHOW ALL THE TRIPS THE USER HAS REGISTERED IN A LIST
                  },
                ),
                OptionItem(
                  icon: Icons.settings,
                  title: 'Ajustes',
                  onTap: () async {
                    Modular.to.pushNamed('/auth/home/profile/settings');
                  },
                ),
                OptionItem(
                  icon: Icons.help,
                  title: 'Ayuda',
                  onTap: () async {
                    // TODO: GO TO HELP SCREEN
                  },
                ),
                OptionItem(
                  icon: Icons.info,
                  title: 'Información',
                  onTap: () async {
                    // TODO: GO TO HELP SCREEN
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

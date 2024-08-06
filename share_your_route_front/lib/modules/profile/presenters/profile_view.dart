// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:share_your_route_front/modules/profile/presenters/profile_header.dart';
import 'package:share_your_route_front/modules/profile/presenters/profile_options.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int currentPageIndex = 2; // Perfil page index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileHeader(
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
                  onTap: () {
                    // TODO: SHOW ALL THE ROUTES THAT THE USER HAS CREATED IN A LIST
                  },
                ),
                OptionItem(
                  icon: Icons.backpack,
                  title: 'Rutas a las que te has unido',
                  onTap: () {
                    // TODO: SHOW ALL THE TRIPS THE USER HAS REGISTERED IN A LIST
                  },
                ),
                OptionItem(
                  icon: Icons.help,
                  title: 'Ayuda',
                  onTap: () {
                    // TODO: GO TO HELP SCREEN
                  },
                ),
                OptionItem(
                  icon: Icons.settings,
                  title: 'Ajustes',
                  onTap: () {
                    // TODO: GO TO SETTINGS SCREEN
                  },
                ),
                OptionItem(
                  icon: Icons.logout,
                  title: 'Cerrar sesión',
                  onTap: () {
                    // TODO: LOG OUT
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

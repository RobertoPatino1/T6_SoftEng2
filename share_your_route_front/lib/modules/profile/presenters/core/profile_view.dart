import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/constants/urls.dart';
import 'package:share_your_route_front/models/user_data.dart';
import 'package:share_your_route_front/modules/profile/presenters/about/about_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_header.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_options.dart';
import 'package:share_your_route_front/modules/profile/presenters/help/help_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/routes/created_routes_history.dart';
import 'package:share_your_route_front/modules/profile/presenters/routes/joined_routes_history.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/settings_screen.dart';
import 'package:share_your_route_front/modules/shared/providers/api_provider.dart';
import 'package:share_your_route_front/modules/shared/services/auth_service.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int currentPageIndex = 2;
  final AuthService _authService = AuthService();
  Column buildUserDataColumn(UserData user) {
    final String backgroundPhoto = (user.backgroundPhoto == "") ? stockBackgroundPictureURL: user.backgroundPhoto;
    final String profilePhoto = (user.profilePhoto == "") ? stockProfilePictureURL: user.profilePhoto;
    return Column(
      children: [
        ProfileHeader(
          imagePath: profilePhoto,
          name: '${user.firstName} ${user.lastName}',
          email: user.email,
          backgroundImagePath: backgroundPhoto,
          bio: user.bio,
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
                    navigateWithSlideTransition(context, SettingsScreen());
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
                    _authService.logout(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
          future: getUserData(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No se encontraron datos del usuario'),
                );
              } else if (snapshot.data!.containsKey('error')) {
                return const Center(
                  child: Text('Error al cargar los datos del usuario'),
                );
              } else if (snapshot.data!.containsKey('user')) {
                final Map<String,dynamic> user = snapshot.data!["user"] as Map<String,dynamic>;
                final UserData userData = UserData.fromJson(user);
                return buildUserDataColumn(userData);
              }
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error al cargar los datos del usuario'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

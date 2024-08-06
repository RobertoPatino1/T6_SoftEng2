import 'package:flutter/material.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_header.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/settings_view.dart';
import 'package:share_your_route_front/modules/shared/services/auth_service.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int currentPageIndex = 2; // Perfil page index
  final AuthService _authService = AuthService();

  void _navigateWithAnimation(String routeName) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          // Aquí se puede resolver la ruta manualmente con un condicional o un método que retorne el widget deseado
          if (routeName == '/auth/home/profile/settings') {
            return SettingsView(); // Reemplaza esto con tu widget de destino
          }
          // Agrega más rutas según sea necesario
          return Container(); // Si no se encuentra la ruta, devuelves un widget vacío o algo similar.
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

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
                    // Mostrar todas las rutas que el usuario ha creado
                  },
                ),
                OptionItem(
                  icon: Icons.backpack,
                  title: 'Rutas a las que te has unido',
                  onTap: () async {
                    // Mostrar todos los viajes a los que el usuario se ha registrado
                  },
                ),
                OptionItem(
                  icon: Icons.settings,
                  title: 'Ajustes',
                  onTap: () async {
                    _navigateWithAnimation('/auth/home/profile/settings');
                  },
                ),
                OptionItem(
                  icon: Icons.help,
                  title: 'Ayuda',
                  onTap: () async {
                    // Ir a la pantalla de ayuda
                  },
                ),
                OptionItem(
                  icon: Icons.info,
                  title: 'Información',
                  onTap: () async {
                    // Ir a la pantalla de información
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

class ProfileOptions extends StatelessWidget {
  final List<OptionItem> options;

  const ProfileOptions({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 230, 229, 229),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: options.take(2).map((option) {
              return Column(
                children: [
                  InkWell(
                    onTap: option.onTap,
                    child: ListTile(
                      leading: Icon(option.icon),
                      title: Text(option.title),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                  if (option != options[1]) const Divider(),
                ],
              );
            }).toList(),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 230, 229, 229),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: options.skip(2).map((option) {
              return Column(
                children: [
                  InkWell(
                    onTap: option.onTap,
                    child: ListTile(
                      leading: Icon(option.icon),
                      title: Text(option.title),
                      trailing: option.title != 'Cerrar sesión'
                          ? const Icon(Icons.chevron_right)
                          : null,
                    ),
                  ),
                  if (option != options.last) const Divider(),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class OptionItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  OptionItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

import 'package:flutter/material.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_options.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/edition/edit_profile.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileOptions(
              options: [
                OptionItem(
                  icon: Icons.edit,
                  title: 'Editar Perfil',
                  onTap: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(),
                      ),
                    );
                  },
                ),
                OptionItem(
                  icon: Icons.accessibility,
                  title: 'Accesibilidad',
                  onTap: () async {
                    // TODO: Implementar la lógica para ajustes de accesibilidad
                  },
                ),
                OptionItem(
                  icon: Icons.delete,
                  title: 'Eliminar cuenta',
                  onTap: () async {
                    // TODO: Implementar la lógica para eliminar cuenta
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

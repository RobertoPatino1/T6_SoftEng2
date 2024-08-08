import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/utils/animations/page_transitions.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_options.dart';
import 'package:share_your_route_front/modules/profile/presenters/deletion/delete_account_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/options/accesibility_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/options/edit_profile_screen.dart';

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
                    navigateWithSlideTransition(context, EditProfilePage());
                  },
                ),
                OptionItem(
                  icon: Icons.accessibility,
                  title: 'Accesibilidad',
                  onTap: () async {
                    navigateWithSlideTransition(context, AccesibilityScreen());
                  },
                ),
                OptionItem(
                  icon: Icons.delete,
                  title: 'Eliminar cuenta',
                  onTap: () async {
                    // TODO: Implementar la lógica para eliminar cuenta
                    navigateWithSlideTransition(context, DeleteAccountScreen());
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

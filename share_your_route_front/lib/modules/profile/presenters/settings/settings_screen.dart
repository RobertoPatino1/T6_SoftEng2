import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/constants/urls.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_options.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/options/accesibility_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/options/deletion/delete_account_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/options/edition/edit_profile_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/options/edition/password/check_password_screen.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Ajustes'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              settingsScreenLogoURL,
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
                      icon: Icons.edit,
                      title: 'Editar Perfil',
                      onTap: () async {
                        navigateWithSlideTransition(
                          context,
                          EditProfileScreen(),
                        );
                      },
                    ),
                    OptionItem(
                      icon: Icons.accessibility,
                      title: 'Accesibilidad',
                      onTap: () async {
                        navigateWithSlideTransition(
                            context, AccesibilityScreen(),);
                      },
                    ),
                  ],
                ),
                OptionGroup(
                  options: [
                    OptionItem(
                      icon: Icons.password,
                      title: 'Cambiar contraseña',
                      onTap: () async {
                        navigateWithSlideTransition(
                          context,
                          CheckPasswordScreen(),
                        );
                      },
                    ),
                  ],
                ),
                OptionGroup(
                  options: [
                    OptionItem(
                      icon: Icons.delete,
                      title: 'Eliminar cuenta',
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      onTap: () async {
                        navigateWithSlideTransition(
                            context, DeleteAccountScreen(),);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

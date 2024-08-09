import 'package:flutter/material.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/options/edition/password/change_password_screen.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';

class CheckPasswordScreen extends StatefulWidget {
  @override
  _CheckPasswordScreenState createState() => _CheckPasswordScreenState();
}

class _CheckPasswordScreenState extends State<CheckPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  void _checkPassword() {
    if (_formKey.currentState!.validate()) {
      // TODO: Validar la contraseña con la base de datos
      navigateWithSlideTransition(context, ChangePasswordScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Verificar Contraseña"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'Contraseña Actual'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña actual';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkPassword,
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}

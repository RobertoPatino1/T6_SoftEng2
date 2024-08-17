import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_your_route_front/core/constants/app_regex.dart';
import 'package:share_your_route_front/core/constants/urls.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ForgotPassword();
  }
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _sendResetEmail() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implementar la lógica de envío de correo para restablecer la contraseña
      showSnackbar(
        context,
        "Revisa tu correo y sigue las instrucciones de recuperación",
        "confirmation",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 15),
                    child: Center(
                      child: SizedBox(
                        width: 200,
                        height: 150,
                        child: Image.asset(logoURL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: emailController,
                      decoration: buildInputDecoration(
                        labelText: 'Email',
                        hintText: 'samsepiol@example.com',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su email';
                        }
                        if (!AppRegex.emailRegex.hasMatch(value)) {
                          return 'Por favor ingrese un email válido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  OutlinedButton(
                    onPressed: _sendResetEmail,
                    child: const Text(
                      'Enviar correo de recuperación',
                    ),
                  ),
                  const SizedBox(height: 130),
                  TextButton(
                    onPressed: () {
                      Modular.to.navigate('/auth/');
                    },
                    child: const Text(
                      'Regresar a inicio de sesión',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

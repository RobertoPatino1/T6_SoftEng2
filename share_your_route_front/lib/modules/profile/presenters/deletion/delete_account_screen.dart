import 'package:flutter/material.dart';
import 'package:share_your_route_front/modules/shared/helpers/ui_helpers.dart';
import 'package:share_your_route_front/modules/shared/services/auth_service.dart';

class DeleteAccountScreen extends StatefulWidget {
  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isButtonEnabled = false;

  void _deleteAccount() {
    if (_formKey.currentState!.validate()) {
      // Lógica para eliminar la cuenta aquí
      // Validar la contraseña ingresada con Firebase
      _authService.logout();
    }
  }

  void _checkPasswordField(String value) {
    setState(() {
      _isButtonEnabled = value.isNotEmpty;
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eliminar Cuenta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.warning, color: Colors.red, size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Advertencia: Esta acción es irreversible. Al eliminar tu cuenta, se borrarán todos tus datos, configuraciones y rutas creadas de Share Your Route.',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Por favor, ingresa tu contraseña para continuar:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                onChanged: _checkPasswordField,
                decoration: buildInputDecoration(hintText: "Contraseña"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _isButtonEnabled
                      ? _deleteAccount
                      : () {
                          showSnackbar(
                            context,
                            "Asegurate de ingresar tu contraseña",
                            "error",
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled
                        ? Colors.red
                        : const Color.fromARGB(29, 158, 158, 158),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                  ),
                  child: const Text('Eliminar Cuenta'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

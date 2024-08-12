import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final passNotifier = ValueNotifier<PasswordStrength?>(null);
  final confirmPassNotifier = ValueNotifier<String?>(null);
  bool showPasswordStrength = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    passNotifier.dispose();
    confirmPassNotifier.dispose();
    super.dispose();
  }

  void _validateConfirmPassword() {
    if (newPasswordController.text != confirmPasswordController.text) {
      confirmPassNotifier.value = 'Las contraseñas no son iguales';
    } else {
      confirmPassNotifier.value = null;
    }
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      if (newPasswordController.text == confirmPasswordController.text) {
        if (passNotifier.value == PasswordStrength.strong ||
            passNotifier.value == PasswordStrength.secure) {
          // TODO: Implementar la lógica de cambio de contraseña en la base de datos
          showSnackbar(
            context,
            "Contraseña actualizada con éxito",
            "confirmation",
          );
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else {
          showSnackbar(context, "Debe ingresar una contraseña fuerte", "error");
        }
      } else {
        showSnackbar(context, "Las contraseñas no coinciden", "error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 75, 115),
        centerTitle: true,
        title: const Text(
          "Cambiar Contraseña",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: newPasswordController,
                obscureText: _obscureNewPassword,
                decoration: buildInputDecoration(
                  labelText: 'Nueva Contraseña',
                ).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  passNotifier.value = PasswordStrength.calculate(text: value);
                  _validateConfirmPassword();
                  setState(() {
                    showPasswordStrength = value.isNotEmpty;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nueva contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              Visibility(
                visible: showPasswordStrength,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 15,
                  ),
                  child: PasswordStrengthChecker(
                    strength: passNotifier,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: buildInputDecoration(
                  labelText: 'Confirmar Contraseña',
                ).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  _validateConfirmPassword();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor confirme su nueva contraseña';
                  }
                  return null;
                },
              ),
              ValueListenableBuilder<String?>(
                valueListenable: confirmPassNotifier,
                builder: (context, errorMessage, child) {
                  return errorMessage != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                            top: 5,
                          ),
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        )
                      : Container();
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _changePassword,
                child: const Text('Actualizar Contraseña'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

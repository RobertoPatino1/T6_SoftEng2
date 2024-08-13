import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:share_your_route_front/core/constants/app_regex.dart';
import 'package:share_your_route_front/core/constants/urls.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';
import 'package:share_your_route_front/modules/shared/providers/api_provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Register();
  }
}

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final passNotifier = ValueNotifier<PasswordStrength?>(null);
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final confirmPassNotifier = ValueNotifier<String?>(null);
  bool showPasswordStrength = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    passNotifier.dispose();
    confirmPassNotifier.dispose();
    super.dispose();
  }

  void _validateConfirmPassword() {
    if (passwordController.text != confirmPasswordController.text) {
      confirmPassNotifier.value = 'Las contraseñas no son iguales';
    } else {
      confirmPassNotifier.value = null;
    }
  }

  void _register() {
    if (_formKey.currentState!.validate() &&
        passwordController.text == confirmPasswordController.text) {
      if (passNotifier.value == PasswordStrength.strong ||
          passNotifier.value == PasswordStrength.secure) {
        //TODO: REGISTER USER IN FIREBASE DATABASE BEFORE CHANGING SCREEN
        Modular.to.pushNamed('/auth/home');
      } else {
        showSnackbar(context, 'Debe ingresar una contraseña fuerte', 'error');
      }
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
                      controller: nameController,
                      decoration: buildInputDecoration(
                        labelText: 'Nombres',
                        hintText: 'Elliot Sam',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese sus nombres';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      top: 15,
                    ),
                    child: TextFormField(
                      controller: lastNameController,
                      decoration: buildInputDecoration(
                        labelText: 'Apellidos',
                        hintText: 'Alderson Sepiol',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese sus apellidos';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      top: 15,
                    ),
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
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      top: 15,
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      decoration: buildInputDecoration(
                        labelText: 'Contraseña',
                      ).copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        passNotifier.value =
                            PasswordStrength.calculate(text: value);
                        _validateConfirmPassword();
                        setState(() {
                          showPasswordStrength = value.isNotEmpty;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su contraseña';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
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
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      top: 15,
                    ),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: buildInputDecoration(
                        labelText: 'Confirmar contraseña',
                      ).copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        _validateConfirmPassword();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor confirme su contraseña';
                        }
                        return null;
                      },
                    ),
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
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      top: 15,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: _register,
                    child: const Text(
                      'Crear cuenta',
                    ),
                  ),
                  const SizedBox(height: 130),
                  TextButton(
                    onPressed: () {
                      Modular.to.navigate('/auth/');
                    },
                    child: const Text(
                      'Ya estás registrado? Inicia sesión aquí',
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

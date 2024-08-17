import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';

import 'package:share_your_route_front/core/constants/urls.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Login();
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: 200,
                      height: 150,
                      child: Image.asset(logoURL),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: _emailController,
                    decoration: buildInputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 15,
                  ),
                  child: TextField(
                    controller: _passwordController,
                    decoration: buildInputDecoration(labelText: "Contraseña"),
                    obscureText: true,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Modular.to.navigate('/auth/forgotPassword');
                  },
                  child: Text(
                    'Olvidaste tu contraseña?',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      if (credential.user != null) {
                        Modular.to.navigate('/auth/home/');
                      }
                    } on FirebaseAuthException catch (e) {
                      showSnackbar(
                        context,
                        "Credenciales incorrectas, intente nuevamente.",
                        "error",
                      );
                      Logger.root.shout('Failed with error code: ${e.code}');
                      Logger.root.shout(e.message);
                      //TODO: REMOVE THIS STATEMENT BEFORE DEPLOYMENT
                      // Modular.to.navigate('/auth/home/');
                      //TODO: REMOVE THIS STATEMENT BEFORE DEPLOYMENT
                    }
                  },
                  child: const Text(
                    'Iniciar sesión',
                  ),
                ),
                const SizedBox(height: 130),
                TextButton(
                  onPressed: () {
                    Modular.to.pushNamed('/auth/register');
                  },
                  child: const Text(
                    'Usuario nuevo? Crea una cuenta',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

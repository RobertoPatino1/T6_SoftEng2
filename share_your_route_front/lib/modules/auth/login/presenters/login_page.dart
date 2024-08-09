import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
                      child: Image.asset('asset/images/logo.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    decoration: buildInputDecoration(
                      labelText: 'Nombre de usuario o Email',
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
                    decoration: buildInputDecoration(labelText: "Contraseña"),
                    obscureText: true,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                  },
                  child: Text(
                    'Olvidaste tu contraseña?',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Modular.to.pushNamed('/auth/home/');
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

import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_your_route_front/modules/auth/forgot_password/presenters/forgot_password_screen.dart';
import 'package:share_your_route_front/modules/auth/login/presenters/login_page.dart';
import 'package:share_your_route_front/modules/auth/register/presenters/register_page.dart';
import 'package:share_your_route_front/modules/home/home_module.dart';

class AuthModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const LoginPage());
    r.child('/register', child: (context) => const Register());
    r.child('/forgotPassword',
        child: (context) => const ForgotPasswordScreen(),);
    r.module('/home', module: HomeModule());
  }
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_your_route_front/modules/profile/presenters/core/profile_view.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/settings_screen.dart';

class ProfileViewModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => ProfileView(),
    );
    r.child(
      '/settings',
      child: (context) => SettingsView(),
    );
  }
}

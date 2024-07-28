import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_your_route_front/modules/profile/presenters/profile_settings.dart';
import 'package:share_your_route_front/modules/profile/presenters/profile_view.dart';

class ProfileViewModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => ProfileView(),
    );
    r.child(
      '/settings',
      child: (context) => ProfileSettings(),
    );
  }
}

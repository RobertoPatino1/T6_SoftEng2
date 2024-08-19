import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_your_route_front/modules/route_room/active_route/presenters/map_admin.dart';
import 'package:share_your_route_front/modules/route_room/active_route/presenters/map_user.dart';
import 'package:share_your_route_front/modules/route_room/route_preview/presenters/route_preview_page.dart';

class RouteRoomModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => RouteItineraryPage(),
    );
    r.child(
      '/activeAdmin',
      child: (context) => MapAdminPage(),
    );

    r.child(
      '/activeUser',
      child: (context) => MapUserPage(),
    );
  }
}

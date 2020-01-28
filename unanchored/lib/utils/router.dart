import 'package:unanchored/pages/pages.dart';

class Router {
  static const String login = '/login';
  static const String home = '/home';
  static const String room = '/room';

  static final routes = {
    login: (context) => LoginPage(),
    home: (context) => HomePage(),
    room: (context) => RoomPage(),
  };
}

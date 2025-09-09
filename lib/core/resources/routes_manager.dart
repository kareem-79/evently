import 'package:evently/features/authentication/login/login_screen.dart';
import 'package:evently/features/authentication/register/register_screen.dart';
import 'package:evently/features/layout/main_layout.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static const String register = "/register";
  static const String login = "/Login";
  static const String mainLayout = "/MainLayout";

  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case register:
        {
          return CupertinoPageRoute(builder: (context) => RegisterScreen());
        }
      case login:
        {
          return CupertinoPageRoute(builder: (context) => LoginScreen());
        }
      case mainLayout:
        {
          return CupertinoPageRoute(builder: (context) => MainLayout());
        }
    }
  }
}

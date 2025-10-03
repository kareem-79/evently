import 'package:evently/features/authentication/login/login_screen.dart';
import 'package:evently/features/authentication/register/register_screen.dart';
import 'package:evently/features/create_event/create_event.dart';
import 'package:evently/features/layout/main_layout.dart';
import 'package:evently/features/on_boarding/on_boarding.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static const String register = "/register";
  static const String login = "/Login";
  static const String onBoarding="OnBoarding";
  static const String mainLayout = "/MainLayout";
  static const String createEvent = "/CreateEvent";

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
      case onBoarding:
        {
          return CupertinoPageRoute(builder: (context) => OnBoarding());
        }
      case mainLayout:
        {
          return CupertinoPageRoute(builder: (context) => MainLayout());
        }
      case createEvent:
        {
          return CupertinoPageRoute(builder: (context) => CreateEvent());
        }

    }
  }
}

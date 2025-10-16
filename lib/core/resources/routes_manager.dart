import 'package:evently/features/authentication/login/login_screen.dart';
import 'package:evently/features/authentication/register/register_screen.dart';
import 'package:evently/features/create_event/create_event.dart';
import 'package:evently/features/layout/main_layout.dart';
import 'package:evently/features/layout/map/pick_location_screen.dart';
import 'package:evently/features/on_boarding/on_boarding.dart';
import 'package:evently/provider/create_event_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class RoutesManager {
  static const String register = "/register";
  static const String login = "/Login";
  static const String onBoarding = "OnBoarding";
  static const String mainLayout = "/MainLayout";
  static const String createEvent = "/CreateEvent";
  static const String pickLocationScreen = "/PickLocationScreen";

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
          return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => CreateEventProvider(),
              child: CreateEvent(),
            ),
          );
        }
      case pickLocationScreen:
        {
          return CupertinoPageRoute(
            settings: settings,
            builder: (context) {
              CreateEventProvider provider =
                  ModalRoute.of(context)?.settings.arguments
                      as CreateEventProvider;
              return PickLocationScreen(provider: provider);
            },
          );
        }
    }
  }
}

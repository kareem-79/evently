import 'package:evently/config/theme/theme_manager.dart';
import 'package:evently/core/prefs_manager/prefs_manager.dart';
import 'package:evently/core/resources/routes_manager.dart';
import 'package:evently/firebase/firebase_services.dart';
import 'package:evently/model/user_model.dart';
import 'package:evently/provider/config_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'firebase/fcm_services.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PrefsManager.init();
  if (FirebaseAuth.instance.currentUser != null) {
    UserModel.currentUser = await FirebaseServices.getUserFromFireStore(
      FirebaseAuth.instance.currentUser!.uid,
    );
  }

  final configProvider = ConfigProvider();
  await configProvider.loadSavedSettings();
  runApp(
    ChangeNotifierProvider(
      create: (context) => configProvider,
      child: const Evently(),
    ),
  );
}

class Evently extends StatelessWidget {
  const Evently({super.key});

  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);
    return ScreenUtilInit(
      designSize: Size(393, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManager.getRoute,
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? RoutesManager.login
            : RoutesManager.mainLayout,
        theme: ThemeManager.light,
        darkTheme: ThemeManager.dark,
        themeMode: configProvider.currentTheme,
        locale: configProvider.locale,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'),
          Locale('es'),
          Locale('ar'),
          Locale('fr'),
          Locale('ja'),
          Locale('ru'),
          Locale('zh'),
        ],
      ),
    );
  }
}

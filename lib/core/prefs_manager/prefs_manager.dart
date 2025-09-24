import 'package:evently/core/resources/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void saveTheme(ThemeMode themeMode) {
    String theme = themeMode == ThemeMode.light ? "Light" : "Dark";
    prefs.setString(ChachConstant.themeKey, theme);

  }

  static ThemeMode? getSavedTheme()  {
    String? savedTheme = prefs.getString(ChachConstant.themeKey);
    if (savedTheme != null) {
      if (savedTheme == "Light") {
        return ThemeMode.light;
      } else {
        return ThemeMode.dark;
      }
    }
    return null;
  }
  static void saveLocale(Locale locale) {
    prefs.setString(ChachConstant.localeKey, locale.languageCode);
  }

  static Locale? getSavedLocale() {
    String? savedCode = prefs.getString(ChachConstant.localeKey);
    if (savedCode != null) {
      return Locale(savedCode);
    }
    return null;
  }
}

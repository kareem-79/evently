import 'package:flutter/material.dart';

class ConfigProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  Locale _locale = const Locale("en");


  bool get isDarkEnable => currentTheme == ThemeMode.dark;
  Locale get locale => _locale;
  String get appLanguageCode => _locale.languageCode;

  void changeAppTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    if (!_supportedLanguages.contains(locale.languageCode)) return;
    _locale = locale;
    notifyListeners();
  }

  void changeAppLanguage(String code) {
    if (!_supportedLanguages.contains(code)) return;
    _locale = Locale(code);
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale("en");
    notifyListeners();
  }

  static const List<String> _supportedLanguages = [
    "en",
    "ar",
    "es",
    "fr",
    "ja",
    "ru",
    "zh",
  ];
}

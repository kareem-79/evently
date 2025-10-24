import 'package:evently/core/prefs_manager/prefs_manager.dart';
import 'package:flutter/material.dart';

class ConfigProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  Locale _locale = const Locale("en");


  bool get isDarkEnable => currentTheme == ThemeMode.dark;

  Locale get locale => _locale;

  String get appLanguageCode => _locale.languageCode;

  Future<void> loadSavedSettings() async {
    currentTheme = PrefsManager.getSavedTheme() ?? ThemeMode.light;
    _locale = PrefsManager.getSavedLanguage() ?? const Locale("en");
    notifyListeners();
  }

  void changeAppTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    PrefsManager.saveTheme(currentTheme);
    notifyListeners();
  }

  void setLocale(Locale locale) {
    if (!_supportedLanguages.contains(locale.languageCode)) return;
    _locale = locale;
    PrefsManager.saveLanguage(locale);
    notifyListeners();
  }

  void changeAppLanguage(String code) {
    if (!_supportedLanguages.contains(code)) return;
    _locale = Locale(code);
    PrefsManager.saveLanguage(_locale);
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale("en");
    PrefsManager.saveLanguage(_locale);
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

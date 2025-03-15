import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeThemeNotifer extends ChangeNotifier {
  ChangeThemeNotifer({
    required SharedPreferences sharedPreferences,
  }) : super() {
    _getTheme(sharedPreferences);
  }

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void _getTheme(SharedPreferences preferences) {
    final mode = preferences.getString('theme_mode');
    switch (mode) {
      case 'light':
        _themeMode = ThemeMode.light;
      case 'dark':
        _themeMode = ThemeMode.dark;
      default:
        _themeMode = ThemeMode.system;
    }
  }
}

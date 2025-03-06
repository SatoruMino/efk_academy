import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier({
    required SharedPreferences sharedPreferences,
  })  : _sharedPreferences = sharedPreferences,
        super() {
    onStartUp();
  }

  final SharedPreferences _sharedPreferences;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void onStartUp() {
    final mode = _sharedPreferences.getString('themeMode');

    if (mode == 'light') {
      _themeMode = ThemeMode.light;
    } else if (mode == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
  }

  void onChanged(ThemeMode mode) async {
    _themeMode = mode;
    await _sharedPreferences.setString('themeMode', mode.name);
    notifyListeners();
  }
}

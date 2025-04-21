import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  ThemeProvider() {
    loadTheme();
  }

  ThemeMode get themeMode => currentTheme;

  void changeTheme(ThemeMode newThemeMode) async {
    if (currentTheme == newThemeMode) return;
    currentTheme = newThemeMode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', newThemeMode == ThemeMode.dark ? 'dark' : 'light');
  }

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('themeMode');

    if (savedTheme != null) {
      currentTheme = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }
}

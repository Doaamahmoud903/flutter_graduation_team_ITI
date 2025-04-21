import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLocal = "en";

  LanguageProvider() {
    loadLanguage();
  }

  void changeLocal(String newLocal) async {
    if (currentLocal == newLocal) return;

    currentLocal = newLocal;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', newLocal);
  }

  void loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString('languageCode');

    if (savedLanguage != null) {
      currentLocal = savedLanguage;
      notifyListeners();
    }
  }
}

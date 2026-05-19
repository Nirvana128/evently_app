import 'package:evently/services/prefs_service.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLanguage = 'en';

  LanguageProvider() {
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final isEnglish = await PrefsService.isEnglish();
    currentLanguage = isEnglish ? 'en' : 'ar';
    notifyListeners();
  }

  Future<void> changeLanguage(String language) async {
    currentLanguage = language;
    await PrefsService.setEnglish(language == 'en');
    notifyListeners();
  }
}

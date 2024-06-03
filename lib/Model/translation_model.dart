import 'package:flutter/material.dart';
import 'package:malaymate/Model/translation_service.dart';

class TranslationModel extends ChangeNotifier {
  final TranslationService _translationService = TranslationService();
  final TextEditingController englishInputController = TextEditingController();
  final TextEditingController malayInputController = TextEditingController();
  String _translatedText = '';
  String _selectedLanguage = 'English to Malay'; // Default language pair

  String get translatedText => _translatedText;
  String get selectedLanguage => _selectedLanguage;

  Future<void> translateText(String text) async {
    try {
      String toLang = _selectedLanguage == 'English to Malay' ? 'Malay' : 'English';
      var translation = await _translationService.translate(text, toLang: toLang);
      _translatedText = translation;
    } catch (e) {
      print('Error translating text: $e');
      _translatedText = 'Translation failed';
    }
    notifyListeners();
  }

  void setSelectedLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  void clearText() {
    englishInputController.clear();
    malayInputController.clear();
    _translatedText = '';
    notifyListeners();
  }
}

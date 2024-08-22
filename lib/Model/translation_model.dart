import 'package:flutter/material.dart';
import 'package:malaymate/Model/translation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationModel extends ChangeNotifier {
  final TranslationService _translationService = TranslationService();
  final TextEditingController englishInputController = TextEditingController();
  final TextEditingController malayInputController = TextEditingController();

  String _translatedText = '';
  String _selectedLanguage = 'English to Malay'; // Default language pair
  List<String> _recentTranslations = []; // New list to store recent translations

  String get translatedText => _translatedText;
  String get selectedLanguage => _selectedLanguage;
  List<String> get recentTranslations => _recentTranslations; // Getter for recent translations

  TranslationModel() {
    _loadRecentTranslations();  // Load recent translations on initialization
  }

  Future<void> translateText(String text) async {
    try {
      String toLang = _selectedLanguage == 'English to Malay' ? 'Malay' : 'English';
      var translation = await _translationService.translate(text, toLang: toLang);
      _translatedText = translation;

      _addRecentTranslation(text); // Add the translated text to the recent list
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


   // Method to add recent translations
   void _addRecentTranslation(String text) {
     // Remove if already in the list to avoid duplicates
     if (_recentTranslations.contains(text)) {
       _recentTranslations.remove(text);
     }
     // Add to the start of the list
     _recentTranslations.insert(0, text);
     // Keep only the latest 10 translations
     if (_recentTranslations.length > 10) {
       _recentTranslations.removeLast();
     }
     notifyListeners();
     _saveRecentTranslations();  // Save the updated recent translations list
   }

   //to save recent in lightwieght database
  Future<void> _loadRecentTranslations() async {
    final prefs = await SharedPreferences.getInstance();
    _recentTranslations = prefs.getStringList('recentTranslations') ?? [];
    notifyListeners();
  }

  Future<void> _saveRecentTranslations() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('recentTranslations', _recentTranslations);
  }

}

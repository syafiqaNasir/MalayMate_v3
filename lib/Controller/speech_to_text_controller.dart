import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:malaymate/Model/translation_service.dart';

class SpeechToTextController with ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  final SpeechToText speechToText = SpeechToText();
  final TranslationService translationService = TranslationService();
  bool speechEnabled = false;
  String lastWords = "";
  String translatedText = ""; // New variable for translated text
  String selectedLocaleId = "en_US";

  SpeechToTextController() {
    listenForPermissions();
    if (!speechEnabled) {
      _initSpeech();
    }
  }

  void listenForPermissions() async {
    final status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.denied:
        requestForPermission();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.provisional:
        break;
    }
  }

  Future<void> requestForPermission() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      openAppSettings();
    }
  }

  void _initSpeech() async {
    speechEnabled = await speechToText.initialize();
    notifyListeners();
  }

  void startListening() async {
    await speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(hours: 1),
      localeId: selectedLocaleId,
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );
    notifyListeners();
  }

  void stopListening() async {
    await speechToText.stop();
    notifyListeners();
  }

  void setLocale(String locale) {
    selectedLocaleId = locale;
    notifyListeners();
  }

  void clearText() {
    lastWords = "";
    translatedText = ""; // Clear translated text as well
    textController.clear();
    notifyListeners();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    lastWords = "${lastWords}${result.recognizedWords} ";
    textController.text = lastWords;
    notifyListeners();
  }

  Future<void> translateText() async {
    // Determine the target language for translation
    String targetLanguage = selectedLocaleId == "en_US" ? "Malay" : "English";

    // Translate the recognized text
    translatedText = await translationService.translate(lastWords, toLang: targetLanguage);

    notifyListeners();
  }
}

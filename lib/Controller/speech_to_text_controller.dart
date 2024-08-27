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
  bool isListening = false;

  SpeechToTextController() {
    listenForPermissions();
  }

  void listenForPermissions() async {
    final status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.denied:
        await requestForPermission();
        break;
      case PermissionStatus.granted:
        _initSpeech();
        break;
      case PermissionStatus.limited:
        await requestForPermission();
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
      case PermissionStatus.restricted:
        openAppSettings();
        break;
      case PermissionStatus.provisional:
        await requestForPermission();
        break;
    }
  }

  Future<void> requestForPermission() async {
    final status = await Permission.microphone.request();
    if (status == PermissionStatus.granted) {
      _initSpeech();
    } else {
      openAppSettings();
    }
  }

  void _initSpeech() async {
    print("Initializing Speech-to-Text...");
    speechEnabled = await speechToText.initialize(
      onStatus: (status) {
        print('Speech status: $status');
      },
      onError: (error) {
        print('Speech error: $error');
      },
    );
    if (!speechEnabled) {
      print("Speech recognition not enabled.");
    } else {
      print("Speech recognition initialized successfully.");
    }
    notifyListeners();
  }

  startListening() async {
    if (speechEnabled && !isListening) {
      isListening = true; // Manually set the listening state

      await speechToText.listen(
        onResult: _onSpeechResult,
        listenFor: const Duration(hours: 1),  // Set a longer duration
        localeId: selectedLocaleId,
        cancelOnError: false,
        partialResults: true, // Enable partial results to see if any speech is being captured
        listenMode: ListenMode.dictation, // Use 'dictation' for continuous listening until you stop it
      );

      print("Listening started with locale: $selectedLocaleId");
      notifyListeners();
    } else {
      print("Speech recognition is not enabled or already listening.");
    }
  }

  stopListening() async {
    if (isListening) {
      await speechToText.stop();
      isListening = false; // Reset the listening state
      // Suppose this is where you get the recognized text
      String recognizedText = textController.text;

      // Format the recognized text with enhanced processing
      recognizedText = _enhancedFormatText(recognizedText);

      // Set the formatted text back to the controller or wherever it's used
      textController.text = recognizedText;

      // Optionally, update the translatedText as well if it's separate
      translatedText = recognizedText;

      // Call the translation method here
      await translateText();

      notifyListeners();
    }
  }

  // Enhanced helper method to format text
  String _enhancedFormatText(String text) {
    // Split the text into sentences based on common sentence delimiters
    List<String> sentences = text.split(RegExp(r'(?<=[.!?])\s+'));

    // Capitalize the first letter of each sentence and ensure it ends with a period
    sentences = sentences.map((sentence) {
      sentence = sentence.trim();
      if (sentence.isNotEmpty) {
        // Capitalize the first letter of the sentence
        sentence = sentence[0].toUpperCase() + sentence.substring(1);

        // Ensure the sentence ends with a punctuation mark
        if (!RegExp(r'[.!?]$').hasMatch(sentence)) {
          sentence += '.';
        }
      }
      return sentence;
    }).toList();

    // Join the sentences back into a single string
    return sentences.join(' ');
  }

  // Method to perform the translation
  Future<void> translateText() async {
    // Determine the target language for translation
    String targetLanguage = selectedLocaleId == "en_US" ? "Malay" : "English";

    // Translate the recognized text
    translatedText = await translationService.translate(textController.text, toLang: targetLanguage);

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
    print("Speech result received: ${result.recognizedWords}, final: ${result.finalResult}");

    if (result.finalResult) {
      lastWords = result.recognizedWords;
    } else {
      lastWords = result.recognizedWords; // Optionally handle partial results differently
    }
    textController.text = lastWords;
    notifyListeners();
  }
}

// lib/Model/utility_service.dart

import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_tts/flutter_tts.dart';

class UtilityService {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await flutterTts.setLanguage("ms");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  void shareText(String text) {
    Share.share(text);
  }
}

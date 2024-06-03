// translate_with_camera_page.dart
import 'package:flutter/material.dart';
import 'package:malaymate/Controller/camera_translation_controller.dart';
import 'package:malaymate/Model/camera_language_selection.dart';
import 'translate_text_screen.dart';

class TranslateWithCameraPage extends StatefulWidget {
  const TranslateWithCameraPage({Key? key}) : super(key: key);

  @override
  State<TranslateWithCameraPage> createState() => _TranslateWithCameraPageState();
}

class _TranslateWithCameraPageState extends State<TranslateWithCameraPage> {
  late CameraTranslationController _controller;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraTranslationController();
  }

  Future<void> _takePicture() async {
    try {
      final recognizedText = await _controller.parseText();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TranslateTextScreen(recognizedText: recognizedText),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Lens'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.flash_on),
            color: _isFlashOn ? Colors.yellow : Colors.white,
            onPressed: () {
              // Flash toggle functionality if needed
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Handle settings button
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: LanguageSelection(onLanguageChanged: (fromLang, toLang) {
              _controller.fromLang = fromLang;
              _controller.toLang = toLang;
            }),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: _takePicture,
                  child: Icon(Icons.camera, size: 50, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), backgroundColor: Colors.black.withOpacity(0.7),
                    padding: EdgeInsets.all(16), // Background color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

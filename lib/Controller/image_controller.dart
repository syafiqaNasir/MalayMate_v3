import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:malaymate/Model/translation_service.dart';

class ImageController {
  final imageNotifier = ValueNotifier<XFile?>(null);
  final ocrResultNotifier = ValueNotifier<String>('');
  final translatedResultNotifier = ValueNotifier<String>('');
  final TranslationService _translationService = TranslationService();

  String _fromLanguage = 'English';
  String _toLanguage = 'Malay';

  String get fromLanguage => _fromLanguage;
  String get toLanguage => _toLanguage;

  void swapLanguages() {
    final temp = _fromLanguage;
    _fromLanguage = _toLanguage;
    _toLanguage = temp;
  }

  Future<void> uploadImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageNotifier.value = pickedFile;
    }
  }

  Future<void> cropImage() async {
    final image = imageNotifier.value;
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Camera Translation',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
          ),
        ],
      );
      if (croppedFile != null) {
        imageNotifier.value = XFile(croppedFile.path);
      }
    }
  }

  Future<void> performOCR() async {
    final imageFile = imageNotifier.value;
    if (imageFile == null) return;

    final request = http.MultipartRequest('POST', Uri.parse('http://10.131.73.241:5000/ocr'));
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final result = json.decode(responseData);
      ocrResultNotifier.value = result['text'];
    } else {
      ocrResultNotifier.value = 'Failed to perform OCR';
    }
  }

  Future<void> translateText() async {
    try {
      final translatedText = await _translationService.translate(
          ocrResultNotifier.value,
          toLang: _toLanguage
      );
      translatedResultNotifier.value = translatedText;
    } catch (e) {
      translatedResultNotifier.value = 'Failed to translate text';
    }
  }

  void clear() {
    imageNotifier.value = null;
    ocrResultNotifier.value = '';
    translatedResultNotifier.value = '';
  }
}

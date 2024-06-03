// camera_translation_controller.dart
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:malaymate/Model/translation_service.dart';
import 'package:image/image.dart' as img;
import 'package:exif/exif.dart';

class CameraTranslationController {
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer textRecognizer = TextRecognizer();
  final TranslationService translationService = TranslationService();

  String fromLang = 'English';
  String toLang = 'Malay';

  Future<List<String>> parseText() async {
    // Pick an image using the camera
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 670,
      maxHeight: 970,
    );

    if (image == null) {
      throw Exception('No image selected');
    }

    final inputImage = await _processImage(image.path);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    // Sort the blocks by their vertical position (top)
    final sortedBlocks = recognizedText.blocks..sort((a, b) => a.boundingBox.top.compareTo(b.boundingBox.top));

    return sortedBlocks.map((block) => block.text).toList();
  }

  Future<InputImage> _processImage(String imagePath) async {
    final originalFile = File(imagePath);
    final bytes = await originalFile.readAsBytes();
    img.Image? originalImage = img.decodeImage(Uint8List.fromList(bytes));

    if (originalImage != null) {
      // Read EXIF data to check the orientation
      final exifData = await readExifFromBytes(bytes);
      final orientation = exifData['Image Orientation']?.printable;

      // Rotate the image based on EXIF orientation
      img.Image rotatedImage;
      if (orientation == 'Rotated 90 CW') {
        rotatedImage = img.copyRotate(originalImage, angle: 90);
      } else if (orientation == 'Rotated 180') {
        rotatedImage = img.copyRotate(originalImage, angle: 180);
      } else if (orientation == 'Rotated 270 CW') {
        rotatedImage = img.copyRotate(originalImage, angle: -90);
      } else {
        rotatedImage = originalImage;
      }

      final rotatedBytes = img.encodeJpg(rotatedImage);
      final rotatedFile = await File(imagePath).writeAsBytes(rotatedBytes);

      return InputImage.fromFilePath(rotatedFile.path);
    } else {
      return InputImage.fromFilePath(imagePath);
    }
  }

  Future<String> translateText(String text) async {
    final translatedText = await translationService.translate(text, toLang: toLang);
    return translatedText;
  }
}

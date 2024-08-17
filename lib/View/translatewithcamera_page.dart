import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malaymate/Controller/image_controller.dart';
import 'package:malaymate/Controller/translatewithtext_controller.dart';
import 'package:dotted_border/dotted_border.dart';

class TranslateWithCameraPage extends StatefulWidget {
  final HomeController homeController;

  const TranslateWithCameraPage({
    super.key,
    required this.homeController,
  });

  @override
  _TranslateWithCameraPageState createState() => _TranslateWithCameraPageState();
}

class _TranslateWithCameraPageState extends State<TranslateWithCameraPage> {
  final ImageController _controller = ImageController();

  @override
  Widget build(BuildContext context) {
    _controller.setContext(context);  // Pass context to controller
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Camera Translation',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _body()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade500,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (index) => widget.homeController.onTabTapped(index, context),
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0), // Adjust padding
              child: Icon(Icons.home, size: 30), // Increase icon size
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.sticky_note_2_sharp, size: 30),
            ),
            label: "Text",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.camera_alt, size: 30),
            ),
            label: "Camera",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.mic, size: 30),
            ),
            label: "Voice",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.bookmark, size: 30),
            ),
            label: "Phrasebook",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        iconSize: 30.0, // Set a default icon size
        selectedFontSize: 14.0, // Customize text size
        unselectedFontSize: 12.0,
        elevation: 10, // Add elevation for a raised effect
      ),
    );
  }

  Widget _body() {
    return ValueListenableBuilder(
      valueListenable: _controller.imageNotifier,
      builder: (context, image, child) {
        if (image != null) {
          return _imageCard();
        } else {
          return _uploaderCard();
        }
      },
    );
  }

  Widget _imageCard() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 440,
                child: Card(
                  elevation: 4.0,
                  color: Colors.blue.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _image(),
                  ),
                ),
              ),
            ),
            _translatedTextCard(),
          ],
        ),
      ),
    );
  }

  Widget _translatedTextCard() {
    return ValueListenableBuilder(
      valueListenable: _controller.translatedResultNotifier,
      builder: (context, translatedResult, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            height: 200,
            width: 360,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _controller.toLanguage,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _languageButton(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: TextEditingController(text: translatedResult.isNotEmpty ? translatedResult : null),
                    decoration: const InputDecoration(
                      hintText: 'Translated text will appear here...',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    readOnly: true,
                    maxLines: null, // Allows the text field to grow if the text is multiline
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _languageButton() {
    List<String> languageOptions = [
      'English to Malay',
      'Malay to English',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: DropdownButton<String>(
        value: '${_controller.fromLanguage} to ${_controller.toLanguage}',
        items: languageOptions.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              switch (newValue) {
                case 'English to Malay':
                  _controller.fromLanguage = 'English';
                  _controller.toLanguage = 'Malay';
                  break;
                case 'Malay to English':
                  _controller.fromLanguage = 'Malay';
                  _controller.toLanguage = 'English';
                  break;
                default:
                  break;
              }
            });
          }
        },
      ),
    );
  }

  Widget _menu() {
    return Container(
      padding: const EdgeInsets.only(bottom: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await _controller.captureImage();
            },
            backgroundColor: Colors.blue.shade200,
            tooltip: 'Scan Here',
            child: const Icon(Icons.camera_alt_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: FloatingActionButton(
              onPressed: () async {
                await _controller.uploadImage();
              },
              backgroundColor: Colors.blue.shade200,
              tooltip: 'Upload Here',
              child: const Icon(Icons.image),
            ),
          ),
          if (_controller.imageNotifier.value != null)
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: FloatingActionButton(
                onPressed: () async {
                  await _controller.cropImage();
                },
                backgroundColor: Colors.blue.shade200,
                tooltip: 'Crop',
                child: const Icon(Icons.crop),
              ),
            ),
        ],
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final imagePath = _controller.imageNotifier.value?.path;
    if (imagePath != null) {
      return Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  _menu(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: 250,
                width: 400,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 0.8 * screenWidth,
                    maxHeight: 0.7 * screenHeight,
                  ),
                  child: kIsWeb ? Image.network(imagePath) : Image.file(File(imagePath)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: _controller.clear,
                    child: Text(
                      'Clear',
                      style: TextStyle(color: Colors.black87),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue.shade200,
                      side: BorderSide(color: Colors.black87, width: 1),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      await _controller.performOCR();
                      await _controller.translateText();
                    },
                    child: Text(
                      'Translate',
                      style: TextStyle(color: Colors.black87),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue.shade200,
                      side: BorderSide(color: Colors.black87, width: 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _uploaderCard() {
    return Center(
      child: SingleChildScrollView(
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SizedBox(
            width: 320.0,
            height: 300.0,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DottedBorder(
                      radius: const Radius.circular(12.0),
                      borderType: BorderType.RRect,
                      dashPattern: const [8, 4],
                      color: Colors.grey,
                      child: Center(
                        child: Text(
                          "Take a photo to start...",
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _menu(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

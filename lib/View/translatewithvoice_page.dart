import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malaymate/Controller/speech_to_text_controller.dart';
import 'package:malaymate/Controller/translatewithtext_controller.dart';

class TranslateWithVoicePage extends StatefulWidget {
  const TranslateWithVoicePage({Key? key, required this.homeController}) : super(key: key);
  final HomeController homeController;

  @override
  _TranslateWithVoicePageState createState() => _TranslateWithVoicePageState();
}

class _TranslateWithVoicePageState extends State<TranslateWithVoicePage> {
  String selectedLanguage = 'English to Malay';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SpeechToTextController(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Voice Translation',
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer<SpeechToTextController>(
            builder: (context, controller, child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Choose language: ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        DropdownButton<String>(
                          value: selectedLanguage,
                          items: <String>['English to Malay', 'Malay to English'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedLanguage = newValue;
                                if (selectedLanguage == 'English to Malay') {
                                  controller.setLocale("en_US");
                                } else {
                                  controller.setLocale("ms");
                                }
                                controller.textController.clear();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Constrained box to limit container height
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.32, // Limits height to 25% of the screen
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.blue[100]!, Colors.blue[100]!], // Slight gradient difference
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5), // Less intense shadow
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedLanguage == 'English to Malay' ? 'English' : 'Malay',
                            style: TextStyle(
                              fontSize: 20, // Font size for the language display
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.black, // Black text color
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: SingleChildScrollView(
                              child: TextField(
                                controller: controller.textController,
                                minLines: 1,
                                maxLines: null,
                                style: const TextStyle(
                                  fontSize: 20, // Slightly smaller font size for text input
                                  color: Colors.black, // Black text color
                                  fontWeight: FontWeight.normal, // Normal weight for user input
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: 'Tap the mic button to start...',
                                  hintStyle: TextStyle(
                                    fontSize: 20, // Readable font size for the hint text
                                    fontWeight: FontWeight.w500, // Normal weight for hint text
                                  ),
                                  fillColor: Colors.blue.shade100,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12), // Space between the TextField and buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FloatingActionButton(
                                onPressed: controller.clearText,
                                tooltip: 'Clear',
                                backgroundColor: Colors.blue.shade300,
                                child: Icon(Icons.clear),
                              ),
                              const SizedBox(width: 16),
                              FloatingActionButton(
                                onPressed: () async {
                                  print("Mic button pressed. isListening: ${controller.isListening}");
                                  if (!controller.isListening) {
                                    // Start listening
                                    await controller.startListening();
                                    print("Started listening...");
                                  } else {
                                    // Stop listening
                                    await controller.stopListening();
                                    print("Stopped listening...");
                                    // Translate after stopping
                                    controller.translateText();
                                  }
                                },
                                tooltip: 'Listen',
                                backgroundColor: Colors.blue.shade300,
                                child: Icon(controller.isListening ? Icons.mic : Icons.mic_off),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  // Constrained box for the translation output
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.32, // Limits height to 25% of the screen
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.blue[100]!, Colors.blue[100]!], // Slight gradient difference
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5), // Less intense shadow
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            selectedLanguage == 'English to Malay' ? 'Malay' : 'English',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Expanded(
                            child: SingleChildScrollView(
                              child: TextField(
                                minLines: 1,
                                maxLines: null,
                                controller: TextEditingController(text: controller.translatedText),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: controller.translatedText.isEmpty ? Colors.grey.shade600 : Colors.black,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: 'Translated text...',
                                  hintStyle: const TextStyle(
                                    fontSize: 20, // Readable font size for the hint text
                                  ),
                                  fillColor: Colors.blue.shade100,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 0),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.volume_up, color: Colors.black),
                                onPressed: () {
                                  widget.homeController.speakText(controller.translatedText);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.copy, color: Colors.black),
                                onPressed: () {
                                  widget.homeController.copyText(controller.translatedText);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Copied to clipboard")),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.share, color: Colors.black),
                                onPressed: () {
                                  widget.homeController.shareText(controller.translatedText);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue.shade500,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          onTap: (index) => widget.homeController.onTabTapped(index, context),
          items: [
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
          iconSize: 30.0,
          selectedFontSize: 14.0,
          unselectedFontSize: 12.0,
          elevation: 10,
        ),
      ),
    );
  }
}

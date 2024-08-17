// lib/Pages/translatewithtext_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:malaymate/Controller/translatewithtext_controller.dart';
import 'package:malaymate/Model/translation_model.dart';

class TranslateWithTextPage extends StatefulWidget {
  @override
  _TranslateWithTextPageState createState() => _TranslateWithTextPageState();
}

class _TranslateWithTextPageState extends State<TranslateWithTextPage> {
  late HomeController homeController;
  late FocusNode englishFocusNode;
  late TextEditingController englishInputController;
  late TextEditingController malayInputController;

  @override
  void initState() {
    super.initState();
    final translationModel = Provider.of<TranslationModel>(context, listen: false);
    homeController = HomeController(translationModel);
    englishFocusNode = FocusNode();
    englishInputController = TextEditingController();
    malayInputController = TextEditingController();
    englishInputController.addListener(_onTextChanged);
    malayInputController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    englishFocusNode.dispose();
    englishInputController.dispose();
    malayInputController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    homeController.clearText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Text Translation',
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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 32,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10.0),
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
                              value: Provider.of<TranslationModel>(context).selectedLanguage,
                              items: <String>['English to Malay', 'Malay to English'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  Provider.of<TranslationModel>(context, listen: false).setSelectedLanguage(newValue);
                                  _onTextChanged();
                                }
                              },
                            ),
                          ],
                        ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Consumer<TranslationModel>(
                  builder: (context, translationModel, child) {
                    return ListView(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      children: [
                        if (translationModel.selectedLanguage == 'English to Malay') ...[
                          inputBubble("English", englishInputController, translationModel, homeController),
                          SizedBox(height: 20),
                          translationBubble("Malay", translationModel.translatedText, homeController),
                        ] else ...[
                          inputBubble("Malay", malayInputController, translationModel, homeController),
                          SizedBox(height: 20),
                          translationBubble("English", translationModel.translatedText, homeController),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade500,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (index) => homeController.onTabTapped(index, context),
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

  Widget inputBubble(String language, TextEditingController controller, TranslationModel translationModel, HomeController homeController) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue[100]!, Colors.blue[100]!],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          TextField(
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Start typing...',
              hintStyle: TextStyle(fontSize: 20),
              border: InputBorder.none,
            ),
            style: TextStyle(fontSize: 20),
            controller: controller,
            focusNode: language == 'English' ? englishFocusNode : null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  controller.clear();  // Directly clear the controller's text
                  homeController.clearText();
                },
                child: Text(
                  'Clear',
                  style: TextStyle(color: Colors.black87),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black87, width: 1),
                ),
              ),
              OutlinedButton(
                onPressed: () => homeController.translateText(controller.text),
                child: Text(
                  'Translate',
                  style: TextStyle(color: Colors.black87),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black87, width: 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget translationBubble(String language, String initialText, HomeController homeController) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue[100]!, Colors.blue[100]!],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          TextField(
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Translated text...',
              hintStyle: TextStyle(fontSize: 20),
              border: InputBorder.none,
            ),
            style: TextStyle(fontSize: 20),
            controller: TextEditingController(text: initialText),
            readOnly: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.volume_up, color: Colors.black),
                onPressed: () {
                  if (initialText.isNotEmpty) homeController.speakText(initialText);
                },
              ),
              IconButton(
                icon: Icon(Icons.copy, color: Colors.black),
                onPressed: () {
                  if (initialText.isNotEmpty) {
                    homeController.copyText(initialText);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copied to clipboard")));
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.share, color: Colors.black),
                onPressed: () {
                  if (initialText.isNotEmpty) homeController.shareText(initialText);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
  late FocusNode malayFocusNode;
  late TextEditingController englishInputController;
  late TextEditingController malayInputController;

  @override
  void initState() {
    super.initState();
    final translationModel = Provider.of<TranslationModel>(context, listen: false);
    homeController = HomeController(translationModel);
    englishFocusNode = FocusNode();
    malayFocusNode = FocusNode();
    englishInputController = TextEditingController();
    malayInputController = TextEditingController();
    englishInputController.addListener(_onTextChanged);
    malayInputController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    englishFocusNode.dispose();
    malayFocusNode.dispose();
    englishInputController.dispose();
    malayInputController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    homeController.clearText();
  }

  void _translateText() {
    final translationModel = Provider.of<TranslationModel>(context, listen: false);
    if (translationModel.selectedLanguage == 'English to Malay') {
      homeController.translateText(englishInputController.text);
    } else {
      homeController.translateText(malayInputController.text);
    }
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
      body: GestureDetector(
        onTap: () {
          // Hide the keyboard when tapping outside of the TextField
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10,),
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
                                  setState(() {
                                    // Immediately clear text controllers on language change
                                    englishInputController.clear();
                                    malayInputController.clear();
                                  });
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
                            SizedBox(height: 15),
                            translationBubble("Malay", translationModel.translatedText, homeController),
                          ] else ...[
                            inputBubble("Malay", malayInputController, translationModel, homeController),
                            SizedBox(height: 20),
                            translationBubble("English", translationModel.translatedText, homeController),
                          ],
                          // Recent Translations Section
                          SizedBox(height: 20),
                          Divider(
                            color: Colors.grey.shade400, // Color of the line, can be adjusted to match your theme
                            thickness: 1.5, // Thickness of the line
                            indent: 1, // Optional: adds space before the start of the line
                            endIndent: 1, // Optional: adds space after the end of the line
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                            child: Row(
                              children: [
                                Icon(Icons.history, color: Colors.blueAccent), // Add a small icon to the left
                                SizedBox(width: 8), // Space between the icon and text
                                Text(
                                  'Recent...',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent, // Matching color with the icon or theme
                                    letterSpacing: 1.5, // Slightly increase letter spacing
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 150, // Set a fixed height for the ListView container
                            child: ListView.builder(
                              // Remove the shrinkWrap and NeverScrollableScrollPhysics properties
                              itemCount: translationModel.recentTranslations.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (translationModel.selectedLanguage == 'English to Malay') {
                                        englishInputController.text = translationModel.recentTranslations[index];
                                      } else {
                                        malayInputController.text = translationModel.recentTranslations[index];
                                      }
                                      homeController.translateText(translationModel.recentTranslations[index]);
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,  // Use white background for a clean look
                                      borderRadius: BorderRadius.circular(15),  // Rounded corners for softness
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),  // Subtle shadow for depth
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: Colors.blueAccent.withOpacity(0.3), // Light border to match the theme
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent.withOpacity(0.1),  // Light background circle for icon
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.history,
                                            color: Colors.blueAccent,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Expanded(
                                          child: Text(
                                            translationModel.recentTranslations[index],
                                            style: GoogleFonts.poppins(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade500,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (index) => homeController.onTabTapped(index, context),
        items: [
          // BottomNavigationBarItem(
          //   icon: Padding(
          //     padding: const EdgeInsets.only(bottom: 8.0), // Adjust padding
          //     child: Icon(Icons.home, size: 30), // Increase icon size
          //   ),
          //   label: "Home",
          // ),
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
                onPressed: () {
                // Call the translate function when the button is clicked
                _translateText();
                },
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
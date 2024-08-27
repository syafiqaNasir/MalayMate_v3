// File: lib/screens/phrasebook_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malaymate/Model/translation_model.dart';
import 'situation_screen.dart';
import 'package:malaymate/Controller/translatewithtext_controller.dart'; // Import HomeController
import 'package:malaymate/Model/translations_data.dart';

class PhrasebookScreen extends StatefulWidget {
  @override
  _PhrasebookScreenState createState() => _PhrasebookScreenState();
}

class _PhrasebookScreenState extends State<PhrasebookScreen> {
  String selectedAccent = 'Standard Malay';
  late HomeController homeController; // Declare homeController

  @override
  void initState() {
    super.initState();
    final TranslationModel translationModel = TranslationModel();
    homeController = HomeController(translationModel); // Initialize homeController
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Phrasebook',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              _showAccentSelectionDialog(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: translationsData[selectedAccent]?.keys.map((situation) {
          return ListTile(
            title: Text(
              _getTitleWithIcon(situation),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              _navigateToSituation(context, situation);
            },
          );
        }).toList() ?? [],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade500,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (index) => homeController.onTabTapped(index, context),
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
        iconSize: 30.0, // Set a default icon size
        selectedFontSize: 14.0, // Customize text size
        unselectedFontSize: 12.0,
        elevation: 10, // Add elevation for a raised effect
      ),
    );
  }

  String _getTitleWithIcon(String situation) {
    switch (situation) {
      case 'Essentials':
        return '🌐   Essentials';
      case 'While Traveling':
        return '✈️    While Traveling';
      case 'Help/Medical':
        return '➕   Help/Medical';
      case 'At the Hotel':
        return '🏨   At the Hotel';
      case 'At the Restaurant':
        return '🍽️   At the Restaurant';
      case 'At the Store':
        return '🛒   At the Store';
      case 'At Work':
        return '💼   At Work';
      default:
        return situation;
    }
  }

  void _showAccentSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Accent'),
          content: DropdownButton<String>(
            value: selectedAccent,
            onChanged: (String? newValue) {
              setState(() {
                selectedAccent = newValue!;
              });
              Navigator.of(context).pop();
            },
            items: translationsData.keys.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _navigateToSituation(BuildContext context, String situation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SituationScreen(
          situation: situation,
          accent: selectedAccent,
          translationsData: translationsData,
          homeController: homeController, // Pass the initialized HomeController
        ),
      ),
    );
  }
}

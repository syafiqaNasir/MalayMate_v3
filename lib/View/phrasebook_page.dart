import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malaymate/Controller/phrasebook_controller.dart';
import 'package:malaymate/Controller/translatewithtext_controller.dart';
import 'package:malaymate/Model/translation_model.dart';
import 'package:malaymate/View/Esssentials/essentials.dart';
import 'package:malaymate/View/Esssentials/essentials_ganu.dart';
import 'package:malaymate/View/Esssentials/essentials_kel.dart';
import 'package:malaymate/View/Esssentials/essentials_negeri.dart';
import 'package:malaymate/View/Esssentials/essentials_pahang.dart';
import 'package:malaymate/View/Esssentials/essentials_perak.dart';
import 'package:malaymate/View/Esssentials/essentials_sabah.dart';

import 'Esssentials/essentials_johor.dart';
import 'Esssentials/essentials_kedah.dart';
import 'Esssentials/essentials_melaka.dart';
import 'Esssentials/essentials_sarawak.dart';

class PhrasebookScreen extends StatefulWidget {
  const PhrasebookScreen({Key? key}) : super(key: key);

  @override
  _PhrasebookScreenState createState() => _PhrasebookScreenState();
}

class _PhrasebookScreenState extends State<PhrasebookScreen> {
  String selectedAccent = 'Standard Malay';
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    final TranslationModel translationModel = TranslationModel();
    homeController = HomeController(translationModel);
  }

  @override
  Widget build(BuildContext context) {
    final PhrasebookController controller = PhrasebookController();

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
            icon: Image.asset(
              'assets/images/book.png',
              height: 30,
              width: 30,
            ),
            onPressed: () {
              _showAccentSelectionDialog(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          return ListTile(
            leading: Text(
              category.icon,
              style: const TextStyle(fontSize: 24),
            ),
            title: Text(
              category.name,
              style: const TextStyle(color: Colors.black87, fontSize: 18),
            ),
            onTap: () {
              if (category.name == 'Essentials') {
                _navigateToEssentials(context);
              }
              // Add other cases for different categories if needed
            },
          );
        },
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
            },
            items: <String>['Standard Malay', 'Kelantan', 'Terengganu', 'Johor', 'Kedah', 'Melaka',
              'Negeri', 'Pahang', 'Perak', 'Sabah', 'Sarawak' ]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToEssentials(BuildContext context) {
    if (selectedAccent == 'Standard Malay') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Essentials(homeController: homeController),
        ),
      );
    } else if (selectedAccent == 'Kelantan') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EssentialsKelantan(homeController: homeController),
        ),
      );
    }
    else if (selectedAccent == 'Terengganu') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TerengganuEssentials(homeController: homeController),
        ),
      );
    }
    else if (selectedAccent == 'Johor') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JohorEssentials(homeController: homeController),
        ),
      );
    }
    else if (selectedAccent == 'Kedah') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KedahEssentials(homeController: homeController),
        ),
      );
    }
    else if (selectedAccent == 'Melaka') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MelakaEssentials(homeController: homeController),
        ),
      );
    }
    else if (selectedAccent == 'Negeri') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NegeriEssentials(homeController: homeController),
        ),
      );
    }
    else if (selectedAccent == 'Pahang') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PahangEssentials(homeController: homeController),
        ),
      );
    }
    else if (selectedAccent == 'Perak') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PerakEssentials(homeController: homeController),
        ),
      );
    }
    else if (selectedAccent == 'Sabah') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SabahEssentials(homeController: homeController),
        ),
      );
    }
    else if (selectedAccent == 'Sarawak') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SarawakEssentials(homeController: homeController),
        ),
      );
    }
  }
}

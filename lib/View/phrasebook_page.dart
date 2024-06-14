import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malaymate/Controller/phrasebook_controller.dart';
import 'package:malaymate/Controller/home_controller.dart';
import 'package:malaymate/Model/translation_model.dart';
import 'package:malaymate/View/essentials.dart';
import 'package:malaymate/View/essentials_kel.dart';

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
        title: Text(
          'Phrasebook',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        backgroundColor: Colors.white,
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "Camera"),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Voice"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Phrasebook"),
        ],
        type: BottomNavigationBarType.fixed,
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
            items: <String>['Standard Malay', 'Kelantan']
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
  }
}

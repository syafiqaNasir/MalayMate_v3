import 'package:flutter/material.dart';
import 'package:malaymate/Controller/home_controller.dart';

class TerengganuEssentials extends StatelessWidget {
  final HomeController homeController;

  TerengganuEssentials({required this.homeController});

  final List<Map<String, dynamic>> phrases = [
    {
      'category': 'GREETING',
      'phrases': [
        'Hello',
        'My name is ',
        'Excuse me',
        'Goodbye',
        'How are you?',
        'Nice to meet you!',
      ],
    },
    {
      'category': 'BASICS',
      'phrases': [
        'Please',
        'I\'m sorry.',
        'Thank you.',
      ],
    },
    {
      'category': 'DIRECTIONS',
      'phrases': [
        'Left',
        'Right',
        'Straight ahead',
        'In ___ meters.',
        'Traffic light',
        'Stop sign',
        'North',
        'South',
        'East',
        'West',
      ],
    },
    {
      'category': 'MONEY',
      'phrases': [
        'Where is the ATM?',
        'I want to exchange money.',
        'What is the exchange fee?',
        'How much does it cost?',
      ],
    },
    {
      'category': 'GENERAL',
      'phrases': [
        'Where is the toilet?',
        'Where is the grocery store?',
        'This is an emergency!',
        'I need help.',
      ],
    },
    {
      'category': 'LANGUAGE',
      'phrases': [
        'Do you speak ___?',
        'I don\'t speak ___.',
        'I don\'t understand.',
        'I speak ___.',
      ],
    },
  ];

  final Map<String, String> translations = {
    'Hello': 'Halo',
    'My name is ': 'Nama ambe ',
    'Excuse me': 'Tumpang lalu',
    'Goodbye': 'Selamat tinggal',
    'How are you?': 'Guane gamok?',
    'Nice to meet you!': 'Serok nok jupo demo!',
    'Please': 'Tolong',
    'I\'m sorry.': 'Ambe minta maaf.',
    'Thank you.': 'Terima kasih.',
    'Left': 'Kiri',
    'Right': 'Kanan',
    'Straight ahead': 'Jale terus',
    'In ___ meters.': 'Dalam ___ meter.',
    'Traffic light': 'Lampu isyarat',
    'Stop sign': 'Tanda berenti',
    'North': 'Utara',
    'South': 'Selatan',
    'East': 'Timur',
    'West': 'Barat',
    'Where is the ATM?': 'Mano ATM?',
    'I want to exchange money.': 'Ambe nok tukar pitih.',
    'What is the exchange fee?': 'Berape yuran tukar pitih?',
    'How much does it cost?': 'Berape harganye?',
    'Where is the toilet?': 'Mano tandas?',
    'Where is the grocery store?': 'Mano kedai runcit?',
    'This is an emergency!': 'Ini kecemasan!',
    'I need help.': 'Ambe perlu bantuan.',
    'Do you speak ___?': 'Demo kecek ___?',
    'I don\'t speak ___.': 'Ambe tok kecek ___.',
    'I don\'t understand.': 'Ambe tok paham.',
    'I speak ___.': 'Ambe kecek ___.',
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Essentials'),
      ),
      body: ListView(
        children: phrases.map((category) {
          return CategorySection(
            category: category['category'],
            phrases: List<String>.from(category['phrases']),
            translations: translations,
            homeController: homeController,
          );
        }).toList(),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String category;
  final List<String> phrases;
  final Map<String, String> translations;
  final HomeController homeController;

  CategorySection({
    required this.category,
    required this.phrases,
    required this.translations,
    required this.homeController,
  });

  void showTranslation(BuildContext context, String phrase) {
    final translation = translations[phrase] ?? 'Translation not available';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Translation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(translation,
              style: TextStyle(fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.copy, color: Colors.black),
                  onPressed: () {
                    if (translation.isNotEmpty) {
                      homeController.copyText(translation);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Copied to clipboard")),
                      );
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.volume_up, color: Colors.black),
                  onPressed: () {
                    if (translation.isNotEmpty) homeController.speakText(translation);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share, color: Colors.black),
                  onPressed: () {
                    if (translation.isNotEmpty) homeController.shareText(translation);
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ExpansionTile(
          title: Text(
            category,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          children: phrases.map((phrase) {
            return ListTile(
              title: Text(phrase),
              onTap: () => showTranslation(context, phrase),
            );
          }).toList(),
        ),
      ),
    );
  }
}


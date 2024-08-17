import 'package:flutter/material.dart';
import 'package:malaymate/Controller/translatewithtext_controller.dart';

class MelakaEssentials extends StatelessWidget {
  final HomeController homeController;

  MelakaEssentials({required this.homeController});

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
    'My name is ': 'Nama saye ',
    'Excuse me': 'Tumpang lalu',
    'Goodbye': 'Selamat tinggal',
    'How are you?': 'Apa khabar?',
    'Nice to meet you!': 'Seronok jumpe awak!',
    'Please': 'Tolong',
    'I\'m sorry.': 'Saye minta maaf.',
    'Thank you.': 'Terima kasih.',
    'Left': 'Kiri',
    'Right': 'Kanan',
    'Straight ahead': 'Jalan terus',
    'In ___ meters.': 'Dalam ___ meter.',
    'Traffic light': 'Lampu isyarat',
    'Stop sign': 'Tanda berhenti',
    'North': 'Utara',
    'South': 'Selatan',
    'East': 'Timur',
    'West': 'Barat',
    'Where is the ATM?': 'Kat mane ATM?',
    'I want to exchange money.': 'Saye nak tukar duit.',
    'What is the exchange fee?': 'Berapo yuran tukar duit?',
    'How much does it cost?': 'Berapo hargenye?',
    'Where is the toilet?': 'Kat mane tandas?',
    'Where is the grocery store?': 'Kat mane kedai runcit?',
    'This is an emergency!': 'Ini kecemasan!',
    'I need help.': 'Saye perlu bantuan.',
    'Do you speak ___?': 'Awak cakap ___?',
    'I don\'t speak ___.': 'Saye tak cakap ___.',
    'I don\'t understand.': 'Saye tak faham.',
    'I speak ___.': 'Saye cakap ___.',
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


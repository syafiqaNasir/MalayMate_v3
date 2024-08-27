import 'package:flutter/material.dart';
import 'package:malaymate/Controller/translatewithtext_controller.dart';

class SabahEssentials extends StatelessWidget {
  final HomeController homeController;

  SabahEssentials({required this.homeController});

  final List<Map<String, dynamic>> phrases = [
    {
      'category': 'GREETING',
      'phrases': [
        'My name is ',
        'Excuse me',
      ],
    },
    {
      'category': 'BASICS',
      'phrases': [
        'I\'m sorry.',
        'Thank you.',
      ],
    },
    {
      'category': 'DIRECTIONS',
      'phrases': [
        'Straight ahead',
        'In ___ meters.',
      ],
    },
    {
      'category': 'MONEY',
      'phrases': [
        'Where is the ATM?',
        'How much does it cost?',
      ],
    },
    {
      'category': 'GENERAL',
      'phrases': [
        'This is an emergency!',
        'I need help.',
      ],
    },
    {
      'category': 'LANGUAGE',
      'phrases': [
        'Do you speak ___?',
        'I don\'t understand.',
      ],
    },
  ];

  final Map<String, String> translations = {
    'Hello': 'Alo',
    'My name is ': 'Nama saya ',
    'Excuse me': 'Sori ya',
    'Goodbye': 'Selamat tinggal',
    'How are you?': 'Macam mana khabar?',
    'Nice to meet you!': 'Senang jumpa kau!',
    'Please': 'Tolong',
    'I\'m sorry.': 'Saya minta maaf.',
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
    'Where is the ATM?': 'Di mana ATM?',
    'I want to exchange money.': 'Saya mau tukar duit.',
    'What is the exchange fee?': 'Berapa yuran tukar duit?',
    'How much does it cost?': 'Berapa harganya?',
    'Where is the toilet?': 'Di mana tandas?',
    'Where is the grocery store?': 'Di mana kedai runcit?',
    'This is an emergency!': 'Ini kecemasan!',
    'I need help.': 'Saya perlu bantuan.',
    'Do you speak ___?': 'Kau cakap ___?',
    'I don\'t speak ___.': 'Saya tidak cakap ___.',
    'I don\'t understand.': 'Saya tidak faham.',
    'I speak ___.': 'Saya cakap ___.',
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


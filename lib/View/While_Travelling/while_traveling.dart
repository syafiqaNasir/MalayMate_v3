import 'package:flutter/material.dart';
import 'package:malaymate/Controller/translatewithtext_controller.dart';

class WhileTraveling extends StatelessWidget {
  final HomeController homeController;

  WhileTraveling({required this.homeController});

  final List<Map<String, dynamic>> phrases = [
    {
      'category': 'LOCATIONS',
      'phrases': [
        'Where is the airport?',
        'Where is the train station?',
      ],
    },
    {
      'category': 'BUYING TICKETS',
      'phrases': [
        'Where can I buy a ticket?',
        'How much is a ticket?',
      ],
    },
    {
      'category': 'PUBLIC TRANSPORTATION',
      'phrases': [
        'Where do I change trains?',
        'Where is the platform?',
      ],
    },
    {
      'category': 'TAXIS & CARS',
      'phrases': [
        'Where is the taxi stand?',
        'Where can I rent a car?',
      ],
    },
    {
      'category': 'ARRIVAL & DEPARTURES',
      'phrases': [
        'Where are the Arrivals?',
        'Where are the Departures?',
      ],
    },
    {
      'category': 'AIR TRAVEL',
      'phrases': [
        'Where is gate ___?',
        'Where is the baggage claim?',
      ],
    },
    {
      'category': 'CUSTOMS & IMMIGRATION',
      'phrases': [
        'Here is my passport.',
        'Do I need a visa?',
      ],
    },
  ];

  final Map<String, String> translations = {
    'Where is the airport?': 'Di mana lapangan terbang?',
    'Where is the train station?': 'Di mana stesen kereta api?',
    'Where can I buy a ticket?': 'Di mana saya boleh beli tiket?',
    'How much is a ticket?': 'Berapa harga tiket?',
    'Where do I change trains?': 'Di mana saya tukar kereta api?',
    'Where is the platform?': 'Di mana platform?',
    'Where is the taxi stand?': 'Di mana tempat teksi?',
    'Where can I rent a car?': 'Di mana saya boleh sewa kereta?',
    'Where are the Arrivals?': 'Di mana Ketibaan?',
    'Where are the Departures?': 'Di mana Pelepasan?',
    'Where is gate ___?': 'Di mana pintu ___?',
    'Where is the baggage claim?': 'Di mana tuntutan bagasi?',
    'Here is my passport.': 'Ini pasport saya.',
    'Do I need a visa?': 'Adakah saya perlukan visa?',
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
            Text(
              translation,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
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

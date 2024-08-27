// File: lib/screens/situation_screen.dart

import 'package:flutter/material.dart';
import 'package:malaymate/Controller/translatewithtext_controller.dart';

class SituationScreen extends StatelessWidget {
  final String situation;
  final String accent;
  final HomeController homeController;
  final Map<String, Map<String, Map<String, String>>> translationsData;

  SituationScreen({
    required this.situation,
    required this.accent,
    required this.translationsData,
    required this.homeController,
  });

  @override
  Widget build(BuildContext context) {
    final translations = translationsData[accent]?[situation] ?? {};

    // Group phrases by category
    Map<String, List<String>> groupedPhrases = _groupPhrasesByCategory(translations);

    return Scaffold(
      appBar: AppBar(
        title: Text('$situation - $accent'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0), // Adjust vertical padding between items
        children: groupedPhrases.keys.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Adjust padding around each card
            child: Card(
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Adjust padding inside each tile
                title: Text(
                  category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                children: groupedPhrases[category]!.map((phrase) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0), // Adjust padding inside each list tile
                    title: Text(phrase),
                    onTap: () {
                      _showTranslationDialog(context, phrase, translations[phrase] ?? '');
                    },
                  );
                }).toList(),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Map<String, List<String>> _groupPhrasesByCategory(Map<String, String> translations) {
    // Grouping logic remains the same
    Map<String, List<String>> groupedPhrases = {
      'GREETING': [],
      'BASICS': [],
      'DIRECTIONS': [],
      'MONEY': [],
      'EMERGENCY': [],
      'GENERAL': [],
    };

    translations.forEach((phrase, translation) {
      if (phrase.contains('Hello') || phrase.contains('Excuse me')) {
        groupedPhrases['GREETING']!.add(phrase);
      } else if (phrase.contains('Thank you') || phrase.contains('Please')) {
        groupedPhrases['BASICS']!.add(phrase);
      } else if (phrase.contains('Left') || phrase.contains('Right')) {
        groupedPhrases['DIRECTIONS']!.add(phrase);
      } else if (phrase.contains('ATM') || phrase.contains('money')) {
        groupedPhrases['MONEY']!.add(phrase);
      } else if (phrase.contains('emergency') || phrase.contains('help')) {
        groupedPhrases['EMERGENCY']!.add(phrase);
      } else {
        groupedPhrases['GENERAL']!.add(phrase);
      }
    });

    groupedPhrases.removeWhere((key, value) => value.isEmpty);

    return groupedPhrases;
  }

  void _showTranslationDialog(BuildContext context, String phrase, String translation) {
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
}

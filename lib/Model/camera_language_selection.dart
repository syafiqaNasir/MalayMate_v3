// language_selection.dart
import 'package:flutter/material.dart';

class LanguageSelection extends StatefulWidget {
  final Function(String fromLang, String toLang) onLanguageChanged;

  const LanguageSelection({required this.onLanguageChanged, Key? key}) : super(key: key);

  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  String fromLang = 'English';
  String toLang = 'Malay';

  void _toggleLanguage() {
    setState(() {
      if (fromLang == 'English') {
        fromLang = 'Malay';
        toLang = 'English';
      } else {
        fromLang = 'English';
        toLang = 'Malay';
      }
      widget.onLanguageChanged(fromLang, toLang);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(fromLang, style: TextStyle(color: Colors.white)),
        IconButton(
          icon: Icon(Icons.swap_horiz, color: Colors.white),
          onPressed: _toggleLanguage,
        ),
        Text(toLang, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}

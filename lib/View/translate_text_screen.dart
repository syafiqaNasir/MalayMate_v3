// // translate_text_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:malaymate/Controller/camera_translation_controller.dart';
//
// class TranslateTextScreen extends StatefulWidget {
//   final List<String> recognizedText;
//   const TranslateTextScreen({Key? key, required this.recognizedText}) : super(key: key);
//
//   @override
//   State<TranslateTextScreen> createState() => _TranslateTextScreenState();
// }
//
// class _TranslateTextScreenState extends State<TranslateTextScreen> {
//   late CameraTranslationController _controller;
//   String _selectedText = '';
//   String _translatedText = '';
//   final FlutterTts _flutterTts = FlutterTts();
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = CameraTranslationController();
//   }
//
//   Future<void> _translateText() async {
//     try {
//       final translatedText = await _controller.translateText(_selectedText);
//       setState(() {
//         _translatedText = translatedText;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> _copyToClipboard() async {
//     await Clipboard.setData(ClipboardData(text: _translatedText));
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copied to clipboard')));
//   }
//
//   Future<void> _playVoice() async {
//     await _flutterTts.speak(_translatedText);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Lens'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.recognizedText.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(widget.recognizedText[index]),
//                   onTap: () {
//                     setState(() {
//                       _selectedText = widget.recognizedText[index];
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//           if (_selectedText.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Text(
//                     _selectedText,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   ElevatedButton(
//                     onPressed: _translateText,
//                     child: Text('Translate'),
//                   ),
//                   if (_translatedText.isNotEmpty)
//                     Column(
//                       children: [
//                         Text(
//                           _translatedText,
//                           style: TextStyle(fontSize: 18, color: Colors.green),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.copy),
//                               onPressed: _copyToClipboard,
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.volume_up),
//                               onPressed: _playVoice,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

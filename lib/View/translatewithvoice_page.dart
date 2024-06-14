import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malaymate/Controller/speech_to_text_controller.dart';

class TranslateWithVoicePage extends StatefulWidget {
  const TranslateWithVoicePage({Key? key}) : super(key: key);

  @override
  _TranslateWithVoicePageState createState() => _TranslateWithVoicePageState();
}

class _TranslateWithVoicePageState extends State<TranslateWithVoicePage> {
  bool isEnglishToMalay = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SpeechToTextController(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Voice Translation',
            style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Consumer<SpeechToTextController>(
              builder: (context, controller, child) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                isEnglishToMalay ? "English" : "Malay",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.swap_horiz),
                          onPressed: () {
                            setState(() {
                              isEnglishToMalay = !isEnglishToMalay;
                              controller.setLocale(isEnglishToMalay ? "en_US" : "ms");
                            });
                          },
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                isEnglishToMalay ? "Malay" : "English",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.textController,
                            minLines: 6,
                            maxLines: 10,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          children: [
                            FloatingActionButton.small(
                              onPressed: controller.speechToText.isNotListening
                                  ? controller.startListening
                                  : controller.stopListening,
                              tooltip: 'Listen',
                              backgroundColor: Colors.blueGrey,
                              child: Icon(controller.speechToText.isNotListening
                                  ? Icons.mic_off
                                  : Icons.mic),
                            ),
                            const SizedBox(height: 8),
                            FloatingActionButton.small(
                              onPressed: controller.clearText,
                              tooltip: 'Clear',
                              backgroundColor: Colors.red,
                              child: Icon(Icons.clear),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: controller.translateText,
                      child: Text("Translate"),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        controller.translatedText.isEmpty
                            ? "Translated text..."
                            : controller.translatedText,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:malaymate/Model/translation_model.dart';
import 'package:malaymate/Model/utility_service.dart';
import 'package:malaymate/View/home_page.dart';
import 'package:malaymate/View/translatewithvoice_page.dart';
import 'package:malaymate/View/translatewithcamera_page.dart';
import 'package:malaymate/View/phrasebook_page.dart';


class HomeController {
  final TranslationModel translationModel;
  final UtilityService utilityService = UtilityService();

  HomeController(this.translationModel);

  void onTabTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => TranslateWithCameraPage(homeController: this,)));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => TranslateWithVoicePage(homeController: this)));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => PhrasebookScreen()));
        break;
    }
  }

  void clearText() {
    translationModel.clearText();
  }

  Future<void> translateText(String text) async {
    await translationModel.translateText(text);
  }

  Future<void> speakText(String text) async {
    await utilityService.speak(text);
  }

  void copyText(String text) {
    utilityService.copyToClipboard(text);
  }

  void shareText(String text) {
    utilityService.shareText(text);
  }
}

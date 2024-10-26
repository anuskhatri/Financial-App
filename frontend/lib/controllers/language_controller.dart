import 'dart:async';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class TranslationController extends GetxController {
  final List<String> languages = [
    'en',
    'hi',
    'bn',
    'te',
    'mr',
    'ta',
    'ur',
    'gu',
    'ml',
    'kn',
    'or',
    'pa',
    'as',
    'mai',
    'sat',
    'ks',
    'ne',
    'kok',
    'sd',
    'doi',
    'mni',
  ];
  final translator = GoogleTranslator();
  RxString langCode = "en".obs;

  void changeLangCode(int index, String inputText) {
    if (index >= 0 && index < languages.length) {
      langCode.value = languages[index];
      translateText(inputText);
    }
  }

  Future<String?> translateText(String input) async {
    try {
      String translated = await translator
          .translate(input, to: langCode.value)
          .then((t) => t.text);
      return translated;
    } catch (e) {
      print('Translation error: $e');
    }
    return null;
  }
}

final TranslationController translationController =
    Get.put(TranslationController());

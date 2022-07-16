import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/data/model/questions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionProvider {
  // load questions from json file
  Future<Questions> loadQuestions() async {
    // set path depending language using AppLocalizations
    String path;
    if (AppLocalizations.of(Get.context!)!.localeName == 'es') {
      path = 'assets/data/questions_es.json';
    } else {
      path = 'assets/data/questions_en.json';
    }

    final String jsonString = await rootBundle.loadString(path);
    final jsonResponse = json.decode(jsonString);
    return Questions.fromJson(jsonResponse);
  }
}

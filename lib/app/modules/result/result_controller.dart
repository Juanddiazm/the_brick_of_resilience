import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/data/model/questionnaire.dart';
import 'package:the_brick_of_resilience/app/data/repository/local/questionnaire_repository.dart';
import 'package:the_brick_of_resilience/app/modules/global/global_controller.dart';
import 'package:the_brick_of_resilience/app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResultController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  final QuestionnaireRepository questionnaireRepository =
      Get.find<QuestionnaireRepository>();

  Map<String, int> mapOfSkills = {
    Constants.controlOfEmotions: 0,
    Constants.selfDiscipline: 0,
    Constants.optimism: 0,
    Constants.analysisOfCauses: 0,
    Constants.empathy: 0,
    Constants.selfEfficacy: 0,
    Constants.overcomeFears: 0
  };

  ResultController();

  @override
  Future<void> onInit() async {
    getResult();
    super.onInit();
  }

  Future<void> saveQuestionnaire() async {
    // update questionnaire if exists else create new questionnaire
    if (globalController.idQuestionnaire != 0) {
      questionnaireRepository.updateQuestionnaire(
          globalController.idQuestionnaire, globalController.questionnaire);
    } else {
      globalController.idQuestionnaire = await questionnaireRepository
          .createQuestionnaire(globalController.questionnaire);
    }
  }

  getResult() {
    if (globalController.questionnaire.results.isEmpty) {
      calculateResult();
    }
    update();
  }

  calculateResult() {
    // iterate over answers from questionnaire
    Map<String, int> mapOfSkills = {};
    for (var i = 0; i < globalController.questionnaire.answers.length; i++) {
      var question = globalController.questions.questions[i];
      var type = question.type;

      var answer = globalController.questionnaire.answers[i];

      // convert variables in map
      mapOfSkills = calculateResultAux(type, answer);
    }
    addMapOfSkillsToQuestionnaire(mapOfSkills);
    saveQuestionnaire();
  }

  Map<String, int> calculateResultAux(String type, Answer answer) {
    // convert variables in map

    switch (type) {
      case Constants.controlOfEmotionsPlus:
        mapOfSkills[Constants.controlOfEmotions] =
            (mapOfSkills[Constants.controlOfEmotions]! + answer.answer);
        break;
      case Constants.controlOfEmotionsMinus:
        mapOfSkills[Constants.controlOfEmotions] =
            (mapOfSkills[Constants.controlOfEmotions]! - answer.answer);
        break;
      case Constants.selfDisciplinePlus:
        mapOfSkills[Constants.selfDiscipline] =
            (mapOfSkills[Constants.selfDiscipline]! + answer.answer);
        break;
      case Constants.selfDisciplineMinus:
        mapOfSkills[Constants.selfDiscipline] =
            (mapOfSkills[Constants.selfDiscipline]! - answer.answer);
        break;
      case Constants.optimismPlus:
        mapOfSkills[Constants.optimism] =
            (mapOfSkills[Constants.optimism]! + answer.answer);
        break;
      case Constants.optimismMinus:
        mapOfSkills[Constants.optimism] =
            (mapOfSkills[Constants.optimism]! - answer.answer);
        break;
      case Constants.analysisOfCausesPlus:
        mapOfSkills[Constants.analysisOfCauses] =
            (mapOfSkills[Constants.analysisOfCauses]! + answer.answer);
        break;
      case Constants.analysisOfCausesMinus:
        mapOfSkills[Constants.analysisOfCauses] =
            (mapOfSkills[Constants.analysisOfCauses]! - answer.answer);
        break;
      case Constants.empathyPlus:
        mapOfSkills[Constants.empathy] =
            (mapOfSkills[Constants.empathy]! + answer.answer);
        break;
      case Constants.empathyMinus:
        mapOfSkills[Constants.empathy] =
            (mapOfSkills[Constants.empathy]! - answer.answer);
        break;
      case Constants.selfEfficacyPlus:
        mapOfSkills[Constants.selfEfficacy] =
            (mapOfSkills[Constants.selfEfficacy]! + answer.answer);
        break;
      case Constants.selfEfficacyMinus:
        mapOfSkills[Constants.selfEfficacy] =
            (mapOfSkills[Constants.selfEfficacy]! - answer.answer);
        break;
      case Constants.overcomeFearsPlus:
        mapOfSkills[Constants.overcomeFears] =
            (mapOfSkills[Constants.overcomeFears]! + answer.answer);
        break;
      case Constants.overcomeFearsMinus:
        mapOfSkills[Constants.overcomeFears] =
            (mapOfSkills[Constants.overcomeFears]! - answer.answer);
        break;
      default:
        break;
    }
    return mapOfSkills;
  }

  void addMapOfSkillsToQuestionnaire(Map<String, int> mapOfSkills) {
    for (var key in mapOfSkills.keys) {
      var resultItem = Result(
          itemName: key,
          score: mapOfSkills[key],
          description: getDescriptionUsingAverage(key, mapOfSkills[key]!));
      globalController.questionnaire.results.add(resultItem);
    }
  }

  String getItemName(context, String itemName) {
    switch (itemName) {
      case Constants.controlOfEmotions:
        return AppLocalizations.of(context)!.controlOfEmotions;
      case Constants.selfDiscipline:
        return AppLocalizations.of(context)!.selfDiscipline;
      case Constants.optimism:
        return AppLocalizations.of(context)!.optimism;
      case Constants.analysisOfCauses:
        return AppLocalizations.of(context)!.analysisOfCauses;
      case Constants.empathy:
        return AppLocalizations.of(context)!.empathy;
      case Constants.selfEfficacy:
        return AppLocalizations.of(context)!.selfEfficacy;
      case Constants.overcomeFears:
        return AppLocalizations.of(context)!.overcomeFears;
      default:
        return "";
    }
  }

  String getDescription(context, String description) {
    switch (description) {
      case Constants.aboveAverage:
        return AppLocalizations.of(context)!.aboveAverage;
      case Constants.average:
        return AppLocalizations.of(context)!.average;
      case Constants.belowAverage:
        return AppLocalizations.of(context)!.belowAverage;
      default:
        return "";
    }
  }

  Color getColorByDescription(String description) {
    switch (description) {
      case Constants.aboveAverage:
        return Colors.green;
      case Constants.average:
        return Colors.yellow;
      case Constants.belowAverage:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  String getDescriptionUsingAverage(String itemName, int score) {
    switch (itemName) {
      case Constants.controlOfEmotions:
        return getControlOfEmotionsDescription(score);
      case Constants.selfDiscipline:
        return getSelfDisciplineDescription(score);
      case Constants.optimism:
        return getOptimismDescription(score);
      case Constants.analysisOfCauses:
        return getAnalysisOfCausesDescription(score);
      case Constants.empathy:
        return getEmpathyDescription(score);
      case Constants.selfEfficacy:
        return getSelfEfficacyDescription(score);
      case Constants.overcomeFears:
        return getOvercomeFearsDescription(score);
      default:
        return "";
    }
  }

  // Sobre promedio: Puntajes superiores a +13
  // Promedio: Puntajes entre 6 y 13
  // Bajo promedio: Puntajes inferiores a 6
  String getControlOfEmotionsDescription(int score) {
    if (score > 13) {
      return Constants.aboveAverage;
    } else if (score >= 6 && score <= 13) {
      return Constants.average;
    } else if (score < 6) {
      return Constants.belowAverage;
    }
    return "";
  }

  // Sobre promedio: Puntajes superiores a 0
  // Promedio: Puntajes entre -6 y 0
  // Bajo promedio: Puntajes inferiores a -6
  String getSelfDisciplineDescription(int score) {
    if (score > 0) {
      return Constants.aboveAverage;
    } else if (score >= -6 && score <= 0) {
      return Constants.average;
    } else if (score < -6) {
      return Constants.belowAverage;
    }
    return "";
  }

  // Sobre promedio: Puntajes superiores a +6
  // Promedio: Puntajes entre -2 y +6
  // Bajo promedio: Puntajes inferiores a -2
  String getOptimismDescription(int score) {
    if (score > 6) {
      return Constants.aboveAverage;
    } else if (score >= -2 && score <= 6) {
      return Constants.average;
    } else if (score < -2) {
      return Constants.belowAverage;
    }
    return "";
  }

  // Sobre promedio: Puntajes superiores a +8
  // Promedio: Puntajes entre 0 y +8
  // Bajo promedio: Puntajes inferiores a 0
  String getAnalysisOfCausesDescription(int score) {
    if (score > 8) {
      return Constants.aboveAverage;
    } else if (score >= 0 && score <= 8) {
      return Constants.average;
    } else if (score < 0) {
      return Constants.belowAverage;
    }
    return "";
  }

  // Sobre promedio: Puntajes superiores a +12
  // Promedio: Puntajes entre 3 y 12
  // Bajo promedio: Puntajes inferiores a 3
  String getEmpathyDescription(int score) {
    if (score > 12) {
      return Constants.aboveAverage;
    } else if (score >= 3 && score <= 12) {
      return Constants.average;
    } else if (score < 3) {
      return Constants.belowAverage;
    }
    return "";
  }

//   Sobre promedio: Puntajes superiores a +10
// Promedio: Puntajes entre 6 y 10
// Bajo promedio: Puntajes inferiores a 6
  String getSelfEfficacyDescription(int score) {
    if (score > 10) {
      return Constants.aboveAverage;
    } else if (score >= 6 && score <= 10) {
      return Constants.average;
    } else if (score < 6) {
      return Constants.belowAverage;
    }
    return "";
  }

//   Sobre promedio: Puntajes superiores a +9
// Promedio: Puntajes entre 4 y 9
// Bajo promedio: Puntajes inferiores a 4
  String getOvercomeFearsDescription(int score) {
    if (score > 9) {
      return Constants.aboveAverage;
    } else if (score >= 4 && score <= 9) {
      return Constants.average;
    } else if (score < 4) {
      return Constants.belowAverage;
    }
    return "";
  }
}

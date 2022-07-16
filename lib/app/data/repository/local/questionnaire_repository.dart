import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/data/model/questionnaire.dart';
import 'package:the_brick_of_resilience/app/data/provider/local/questionnaire_provider.dart';

class QuestionnaireRepository {
  final QuestionnaireProvider _questionnaireProvider =
      Get.find<QuestionnaireProvider>();

  QuestionnaireRepository();

  Future<int> createQuestionnaire(Questionnaire questionnaire) async {
    return await _questionnaireProvider.createQuestionnaire(questionnaire);
  }

  Future<List<Map<String, dynamic>>> getQuestionnaires() async {
    return await _questionnaireProvider.getQuestionnaires();
  }

  Future<List<Map<String, dynamic>>> getQuestionnaire() async {
    return await _questionnaireProvider.getQuestionnaire();
  }

  Future<bool> isQuestionnaireSaved() async {
    return await _questionnaireProvider.isQuestionnaireSaved();
  }

  Future<int> updateQuestionnaire(int id, Questionnaire questionnaire) async {
    return await _questionnaireProvider.updateQuestionnaire(id, questionnaire);
  }

  Future<void> deleteQuestionnaire() async {
    return await _questionnaireProvider.deleteQuestionnaire();
  }
}

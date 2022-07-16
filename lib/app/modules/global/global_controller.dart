import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/data/model/questionnaire.dart';
import 'package:the_brick_of_resilience/app/data/model/questions.dart';
import 'package:the_brick_of_resilience/app/data/repository/local/questionnaire_repository.dart';
import 'package:the_brick_of_resilience/app/data/repository/local/questions_repository.dart';

class GlobalController extends GetxController {
  final QuestionnaireRepository questionnaireRepository =
      Get.find<QuestionnaireRepository>();

  final QuestionRepository questionRepository = Get.find<QuestionRepository>();

  int idQuestionnaire = 0;
  Questions questions = Questions(questions: []);
  Questionnaire questionnaire = Questionnaire(answers: [], results: []);
  bool isQuestionnaireSaved = false;
  RxBool isAbleToContinueQuestionnaire = false.obs;
  RxBool isAbleToShowResults = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initQuestions();
    await initQuestionnaire();
    validateIsAbleToContinueQuestionnaire();
    validateIsAbleToShowResults();
  }

  // initialize questions
  Future<void> initQuestions() async {
    questions = await questionRepository.getQuestions();
  }

  // initialize questionnaire
  Future<void> initQuestionnaire() async {
    isQuestionnaireSaved = await questionnaireRepository.isQuestionnaireSaved();

    if (isQuestionnaireSaved) {
      var resultQuestionnaire =
          await questionnaireRepository.getQuestionnaire();
      idQuestionnaire = resultQuestionnaire.first['id'];
      questionnaire =
          Questionnaire.fromRawJson(resultQuestionnaire.first['questionnaire']);
    }

    print('questionnaire:' + questionnaire.toRawJson());
  }

  // isAbleToContinueQuestionnaire
  validateIsAbleToContinueQuestionnaire() async {
    var isTheQuestionnaireFinished = _isTheQuestionnaireFinished();

    var isAnyQuestionAnswered = _isAnyQuestionAnswered();

    isQuestionnaireSaved = await questionnaireRepository.isQuestionnaireSaved();

    isAbleToContinueQuestionnaire.value = isQuestionnaireSaved &&
        isAnyQuestionAnswered &&
        !isTheQuestionnaireFinished;
  }

  _isTheQuestionnaireFinished() {
    var numberOfQuestions = (questions).questions.length;
    var numberOfAnswers = questionnaire.answers.length;
    return numberOfQuestions == numberOfAnswers;
  }

  _isAnyQuestionAnswered() {
    var numberOfAnswers = questionnaire.answers.length;
    return numberOfAnswers > 0;
  }

  validateIsAbleToShowResults() {
    var numberOfAnswers = questionnaire.results.length;
    isAbleToShowResults.value = numberOfAnswers > 0;
  }
}

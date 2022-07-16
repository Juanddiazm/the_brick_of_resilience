import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/data/model/questionnaire.dart';
import 'package:the_brick_of_resilience/app/data/repository/local/questionnaire_repository.dart';
import 'package:the_brick_of_resilience/app/modules/global/global_controller.dart';

class QuestionnaireController extends GetxController {
  final QuestionnaireRepository questionnaireRepository =
      Get.find<QuestionnaireRepository>();

  final GlobalController globalController = Get.find<GlobalController>();

  RxInt currentQuestion = 0.obs;
  RxInt answer = 0.obs;

  QuestionnaireController();

  @override
  Future<void> onInit() async {
    initCurrentAnswer();
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    await globalController.validateIsAbleToContinueQuestionnaire();
    globalController.validateIsAbleToShowResults();
  }

  // initialize currentAnswer
  void initCurrentAnswer() {
    currentQuestion.value = globalController.questionnaire.answers.length + 1;
    setOrResetNextAnswer();
    update();
  }

  int getAnswerSaved() =>
      globalController.questionnaire.answers[currentQuestion.value - 1].answer;

  // nextQuestion()
  void nextQuestion() {
    savePreviousAnswer();
    currentQuestion.value++;
    setOrResetNextAnswer();
    update();
    // print currentQuestion.value
    print('currentQuestion: ${currentQuestion.value}');
    print('questionnaire:' + globalController.questionnaire.toRawJson());
  }

  void savePreviousAnswer() {
    var answerObj = Answer(id: currentQuestion.value, answer: 0);
    // update answerObj
    answerObj.answer = answer.value;
    // verify if answerObj id is in questionnaire.answers list
    setAnswerObj(answerObj);
  }

  void setOrResetNextAnswer() {
    // set or reset answer
    if (currentQuestion.value > globalController.questionnaire.answers.length) {
      answer.value = 0;
    } else {
      answer.value = getAnswerSaved();
    }
  }

  // backQuestion()
  void backQuestion() {
    if (currentQuestion.value > 1) {
      currentQuestion.value--;
    }
    answer.value = getAnswerSaved();
    update();

    // print currentQuestion.value
    print('currentQuestion: ${currentQuestion.value}');
    print('questionnaire:' + globalController.questionnaire.toRawJson());
  }

  Future<void> setAnswerObj(Answer answerObj) async {
    if (globalController.questionnaire.answers
        .any((element) => element.id == currentQuestion.value)) {
      // if true, update answerObj
      globalController.questionnaire.answers
          .firstWhere((element) => element.id == currentQuestion.value)
          .answer = answerObj.answer;
    } else {
      // if false, add answerObj
      globalController.questionnaire.answers.add(answerObj);
    }

    // update questionnaire if exists else create new questionnaire
    await saveQuestionnaire();
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

  // finishQuestionnaire() - go to result page
  void finishQuestionnaire() {
    savePreviousAnswer();
    Get.offAndToNamed('/result');
  }

  void setAnswer(int option) {
    answer.value = option;
    update();
    print('answer: ${answer.value}');
  }
}

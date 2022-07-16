import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/data/model/questionnaire.dart';
import 'package:the_brick_of_resilience/app/data/repository/local/questionnaire_repository.dart';
import 'package:the_brick_of_resilience/app/modules/global/global_controller.dart';
import 'package:the_brick_of_resilience/app/routes/app_routes.dart';

class HomeController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  final QuestionnaireRepository questionnaireRepository =
      Get.find<QuestionnaireRepository>();

  HomeController();

  @override
  onReady() async {
    update();
  }

  Future<void> goToNewQuestionnaire() async {
    await questionnaireRepository.deleteQuestionnaire();
    resetQuestionnaire();
    Get.toNamed(AppRoutes.questionnaire);
  }

  void resetQuestionnaire() {
    globalController.questionnaire = Questionnaire(answers: [], results: []);
  }

  // redirect to questionnaire page
  void goToContinueQuestionnaire() {
    Get.toNamed(AppRoutes.questionnaire);
  }

  // redirect to results page
  void goToResults() {
    Get.toNamed(AppRoutes.result);
  }
}

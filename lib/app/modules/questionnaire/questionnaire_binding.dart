import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/modules/questionnaire/questionnaire_controller.dart';

class QuestionnaireBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionnaireController>(() => QuestionnaireController());
  }
}

import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/data/provider/local/question_provider.dart';
import 'package:the_brick_of_resilience/app/data/provider/local/questionnaire_provider.dart';
import 'package:the_brick_of_resilience/app/data/repository/local/questionnaire_repository.dart';
import 'package:the_brick_of_resilience/app/data/repository/local/questions_repository.dart';

import '../data/provider/local/sql_helper.dart';

class DependencyInjection {
  static void init() {
    Get.put<SQLHelper>(SQLHelper());

    // Providers
    Get.put<QuestionnaireProvider>(QuestionnaireProvider());
    Get.put<QuestionProvider>(QuestionProvider());

    // Repositories
    Get.put<QuestionnaireRepository>(QuestionnaireRepository());
    Get.put<QuestionRepository>(QuestionRepository());


  }
}

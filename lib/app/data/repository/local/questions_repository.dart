// Question Repository
import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/data/model/questions.dart';
import 'package:the_brick_of_resilience/app/data/provider/local/question_provider.dart';

class QuestionRepository {
  final QuestionProvider _questionProvider = Get.find<QuestionProvider>();

  Future<Questions> getQuestions() async {
    return await _questionProvider.loadQuestions();
  }
}

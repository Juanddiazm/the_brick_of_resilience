import 'package:get/route_manager.dart';
import 'package:the_brick_of_resilience/app/modules/home/home_binding.dart';
import 'package:the_brick_of_resilience/app/modules/home/home_page.dart';
import 'package:the_brick_of_resilience/app/modules/questionnaire/questionnaire_binding.dart';
import 'package:the_brick_of_resilience/app/modules/questionnaire/questionnaire_page.dart';
import 'package:the_brick_of_resilience/app/modules/result/result_binding.dart';
import 'package:the_brick_of_resilience/app/modules/result/result_page.dart';
import 'package:the_brick_of_resilience/app/modules/splash/splash_binding.dart';
import 'package:the_brick_of_resilience/app/modules/splash/splash_page.dart';
import 'package:the_brick_of_resilience/app/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.splash,
        page: () => const SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.home,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.questionnaire,
        page: () => const QuestionnairePage(),
        binding: QuestionnaireBinding()),
    GetPage(
        name: AppRoutes.result,
        page: () => const ResultPage(),
        binding: ResultBinding()),
  ];
}

import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/modules/global/global_controller.dart';
import 'package:the_brick_of_resilience/app/routes/app_routes.dart';

class SplashController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();

  
  @override
  void onReady() {
    super.onReady();
    _init();
  }

  _init() async {
    await Future.delayed(const Duration(seconds: 2));
    redirectToHome();
  }

  redirectToHome() {
    Get.offNamed(AppRoutes.home);
  }
}

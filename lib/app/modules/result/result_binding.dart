import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/modules/result/result_controller.dart';

class ResultBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultController>(() => ResultController());
  }
}

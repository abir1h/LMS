import 'package:get/get.dart';

import '../controllers/assessment_controller.dart';

class AssessmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AssessmentController());
  }
}

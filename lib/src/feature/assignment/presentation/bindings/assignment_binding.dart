import 'package:get/get.dart';

import '../controllers/assignment_controller.dart';

class AssignmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AssignmentController());
  }
}

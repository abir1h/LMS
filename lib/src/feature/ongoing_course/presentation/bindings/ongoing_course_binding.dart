import '../controllers/ongoing_course_controller.dart';
import 'package:get/get.dart';

class OngoingCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OngoingCourseController());
  }
}

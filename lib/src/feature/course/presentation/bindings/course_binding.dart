import 'package:get/get.dart';

import '../controllers/course_list_controller.dart';
import '../controllers/course_details_controller.dart';
import '../controllers/course_controller.dart';

class CourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseController());
    Get.lazyPut(() => CourseListController());
    Get.lazyPut(() => CourseDetailsController());
  }
}

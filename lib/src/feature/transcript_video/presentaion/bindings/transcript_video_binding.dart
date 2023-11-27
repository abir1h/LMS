import 'package:get/get.dart';

import '../../../ongoing_course/presentation/controllers/ongoing_course_controller.dart';

class TranscriptVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OngoingCourseController());
  }
}

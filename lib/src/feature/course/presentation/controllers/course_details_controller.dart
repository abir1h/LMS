import 'package:get/get.dart';

class CourseDetailsController extends GetxController {
  final status = "".obs;

  @override
  void onInit() {
    status.value = Get.arguments ?? "";
    super.onInit();
  }
}

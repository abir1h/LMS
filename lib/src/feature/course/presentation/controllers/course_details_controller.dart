import 'package:get/get.dart';

class CourseDetailsController extends GetxController {
  final from = "".obs;
  final status = "".obs;

  @override
  void onInit() {
    from.value = Get.arguments['from'] ?? "";
    status.value = Get.arguments['status'] ?? "";
    super.onInit();
  }
}

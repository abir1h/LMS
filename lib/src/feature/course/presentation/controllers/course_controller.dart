import 'package:get/get.dart';

class CourseController extends GetxController {
  final isExpanded = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  toggle() {
    isExpanded.value = !isExpanded.value;
  }
}

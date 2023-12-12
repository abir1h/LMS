import 'package:get/get.dart';

class IntroductionController extends GetxController {
  final screenName = "".obs;

  @override
  void onInit() {
    screenName.value = Get.arguments ?? "";
    super.onInit();
  }
}

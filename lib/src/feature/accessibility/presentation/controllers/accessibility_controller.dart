import 'package:get/get.dart';

class AccessibilityController extends GetxController {
  RxBool isGrayscale = false.obs;

  void toggleGrayscale() {
    isGrayscale.toggle();
  }
}

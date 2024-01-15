import 'package:get/get.dart';

import '../../../../core/constants/app_theme.dart';

class AccessibilityController extends GetxController with AppTheme {
  RxBool isGrayscale = false.obs;
  RxBool isTextSize = false.obs;

  void toggleGrayscale() {
    isGrayscale.toggle();
  }

  void toggleTextSize() {
    isTextSize.toggle();
  }
}

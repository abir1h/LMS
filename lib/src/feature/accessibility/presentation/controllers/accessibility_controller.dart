import 'package:get/get.dart';

import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/common_imports.dart';

class AccessibilityController extends GetxController with AppTheme {
  RxBool isGrayscale = false.obs;
  RxBool isTextSize = false.obs;
  @override
  void onInit() {
    setTextSwitch();
    super.onInit();
  }

  setTextSwitch() {
    final localStorage = Get.find<LocalStorageService>();
    if (localStorage.getBooleanValue(StringData.textSizeKey) != null) {
      isTextSize.value = localStorage.getBooleanValue(StringData.textSizeKey)!;
    }
    if (localStorage.getBooleanValue(StringData.monochromeSizeKey) != null) {
      isGrayscale.value =
          localStorage.getBooleanValue(StringData.monochromeSizeKey)!;
    }
  }

  void toggleGrayscale() {
    isGrayscale.toggle();
    localStorage.storeBooleanValue(
        StringData.monochromeSizeKey, isGrayscale.value);
  }

  void toggleTextSize() {
    isTextSize.toggle();
  }
}

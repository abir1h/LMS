import 'package:get/get.dart';

import '../../../../core/config/local_storage_services.dart';
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
    final localStorage = Get.find<LocalStorageServiceWithGetX>();

    if (localStorage.getBooleanValue(StringData.monochromeKey) != null) {
      isGrayscale.value =
          localStorage.getBooleanValue(StringData.monochromeKey)!;
    }

    if (localStorage.getBooleanValue(StringData.textSizeKey) != null) {
      isTextSize.value = localStorage.getBooleanValue(StringData.textSizeKey)!;
    }
  }

  void toggleGrayscale() {
    isGrayscale.toggle();
    localStorage.storeBooleanValue(StringData.monochromeKey, isGrayscale.value);
  }

  void toggleTextSize() {
    isTextSize.toggle();
  }
}

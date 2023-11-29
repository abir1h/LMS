import 'package:get/get.dart';

import '../controller/bottom_controller.dart';

class BottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomController());
  }
}

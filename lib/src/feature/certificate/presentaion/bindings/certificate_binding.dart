import 'package:get/get.dart';

import '../controllers/certificate_controller.dart';

class CertificateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CertificateController());
  }
}

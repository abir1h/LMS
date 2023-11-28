import 'package:get/get.dart';

import '../../domain/use_cases/profile_use_case.dart';
import '../../../../core/di/dependency_injection.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileUseCase(profileRepository: locator.get()));
    Get.lazyPut(() => ProfileController(Get.find<ProfileUseCase>()));
  }
}

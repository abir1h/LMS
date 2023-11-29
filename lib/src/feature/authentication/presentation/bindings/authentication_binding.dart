import 'package:get/get.dart';

import '../../../../core/di/dependency_injection.dart';
import '../controllers/authentication_controller.dart';
import '../../domain/use_cases/auth_use_case.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => AuthRepositoryImp(authRemoteDataSource: ));
    Get.lazyPut(() => AuthUseCase(authRepository: locator.get()));
    Get.lazyPut(() => AuthenticationController(Get.find<AuthUseCase>()));
  }
}

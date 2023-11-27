import 'package:demo/src/core/di/dependency_injection.dart';
import 'package:get/get.dart';
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

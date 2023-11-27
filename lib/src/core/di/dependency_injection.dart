import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../feature/authentication/data/data_sources/remote/auth_data_source.dart';
import '../../feature/authentication/data/repositories/auth_repository_imp.dart';
import '../../feature/authentication/domain/repositories/auth_repository.dart';
import '../../feature/authentication/domain/use_cases/auth_use_case.dart';
import '../../feature/authentication/presentation/controllers/authentication_controller.dart';
import '../config/local_storage_services.dart';
import '../network/http_client.dart';

GetIt locator = GetIt.instance;

void setup(){
  Get.lazyPut(() => AuthUseCase(authRepository: locator.get()));
  Get.lazyPut(() => AuthenticationController(Get.find<AuthUseCase>()));

  locator.registerSingleton(BaseHttpClient());
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(authRemoteDataSource: AuthRemoteDataSourceImp()),
  );
}

initLocalServices() async{
  await Get.putAsync(() => LocalStorageService.initialize());
}

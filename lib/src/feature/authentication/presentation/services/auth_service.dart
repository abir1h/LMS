import '../../../../core/di/dependency_injection.dart';
import '../../domain/entities/auth_response_entity.dart';
import '../../domain/use_cases/auth_use_case.dart';

class AuthService {
  AuthService._();
  static final AuthUseCase _authUseCase =
      AuthUseCase(authRepository: locator.get());

  static Future<AuthResponseEntity> userLogin(
      String pdsID, String password) async {
    return _authUseCase.userLoginUseCase(pdsID, password);
  }
}

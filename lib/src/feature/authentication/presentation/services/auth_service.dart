import '../../../../core/di/dependency_injection.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/use_cases/auth_use_case.dart';

class AuthService {
  AuthService._();
  static final AuthUseCase _authUseCase =
      AuthUseCase(authRepository: locator.get());

  static Future<ResponseEntity> getToken(String username, String eMISToken) async {
    return _authUseCase.getTokenUseCase(username, eMISToken);
  }
  static Future<ResponseEntity> getEMISLink() async {
    return _authUseCase.getEMISLinkUseCase();
  }
}

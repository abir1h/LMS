import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;
  AuthUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<AuthResponseEntity> userLoginUseCase(
      String pdsID, String password) async {
    final response = _authRepository.userLogin(pdsID, password);
    return response;
  }
}

import '../entities/auth_response_entity.dart';

abstract class AuthRepository {
  Future<AuthResponseEntity> userLogin(String pdsID, String password);
}

import 'user_data_entity.dart';

class AuthDataEntity {
  final UserDataEntity user;
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final List<String> policy;

  AuthDataEntity({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.policy,
  });
}

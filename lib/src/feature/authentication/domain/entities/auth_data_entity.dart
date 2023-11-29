class AuthDataEntity {
  final String accessToken;
  final String expiresAt;
  final String refreshToken;
  final String role;
  final List<String> permissions;

  AuthDataEntity(
      {required this.accessToken,
      required this.expiresAt,
      required this.refreshToken,
      required this.role,
      required this.permissions});
}

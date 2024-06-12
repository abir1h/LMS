class UserDataEntity {
  final String id;
  final String username;
  final String name;
  final String designation;
  final List<String> role;
  final String type;
  final String fcmToken;

  UserDataEntity({
    required this.id,
    required this.username,
    required this.name,
    required this.designation,
    required this.role,
    required this.type,
    required this.fcmToken,
  });
}

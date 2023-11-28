import 'auth_data_entity.dart';

class AuthResponseEntity {
  final String message;
  final AuthDataEntity? data;
  final List<Map<String, String>>? errors;

  AuthResponseEntity(
      {required this.message, required this.data, required this.errors});
}

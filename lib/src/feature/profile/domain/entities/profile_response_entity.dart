import 'profile_data_entity.dart';

class ProfileResponseEntity{
  final String message;
  final ProfileDataEntity? data;
  final List<Map<String, String>>? errors;

  ProfileResponseEntity({
    required this.message,
    required this.data,
    required this.errors
  });
}
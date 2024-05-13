import 'package:lms/src/feature/profile/domain/entities/emis_user_data_entity.dart';

class UserInfoDataEntity {
  final int id;
  final int pdsId;
  final String createdAt;
  final String updateAt;
  final String deletedAt;
  final String role;
  final String status;
  final EmisUserDataEntity? emisUserDataEntity;


  UserInfoDataEntity({
    required this.id,
    required this.pdsId,
    required this.createdAt,
    required this.updateAt,
    required this.deletedAt,
    required this.role,
    required this.status,
    required this.emisUserDataEntity
  });
}

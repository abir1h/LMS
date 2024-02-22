import 'user_data_entity.dart';

class DiscussionDataEntity {
  final int id;
  final int courseModuleId;
  final String contentType;
  final int contentId;
  final String description;
  final String attachment;
  final int createdBy;
  final String status;
  final String createdAt;
  final String updatedAt;
  final UserDataEntity user;

  DiscussionDataEntity({
    required this.id,
    required this.courseModuleId,
    required this.contentType,
    required this.contentId,
    required this.description,
    required this.attachment,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });
}

import 'user_data_entity.dart';

class CommentDataEntity {
  final int id;
  final int discussionId;
  final String description;
  final String attachment;
  final int createdBy;
  final int status;
  final String createdAt;
  final String updatedAt;
  final UserDataEntity user;

  CommentDataEntity({
    required this.id,
    required this.discussionId,
    required this.description,
    required this.attachment,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });
}

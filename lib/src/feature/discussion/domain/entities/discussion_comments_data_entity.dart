import 'comment_data_entity.dart';
import 'user_data_entity.dart';

class DiscussionCommentsDataEntity {
  final int id;
  final int courseModuleId;
  final String contentType;
  final int contentId;
  final String description;
  final String attachment;
  final int createdBy;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int commentsCount;
  final UserDataEntity user;
  final List<CommentDataEntity> comments;

  DiscussionCommentsDataEntity({
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
    required this.commentsCount,
    required this.user,
    required this.comments,
  });
}

import '../entities/comment_data_entity.dart';
import '../entities/discussion_data_entity.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class DiscussionRepository {
  Future<ResponseEntity> getDiscussionsByContent(
      int courseId, int courseModuleId, int contentId, String contentType);
  Future<ResponseEntity> getDiscussionDetails(int discussionId);
  Future<ResponseEntity> createDiscussion(int courseId, int courseModuleId,
      int contentId, String contentType, String description);
  Future<ResponseEntity> updateDiscussion(
      DiscussionDataEntity discussionDataEntity);
  Future<ResponseEntity> deleteDiscussion(int discussionId);
  Future<ResponseEntity> getDiscussionComments(int discussionId);
  Future<ResponseEntity> createComment(int discussionId, String description);
  Future<ResponseEntity> updateComment(CommentDataEntity commentDataEntity);
}

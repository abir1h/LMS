import '../entities/comment_data_entity.dart';
import '../entities/discussion_data_entity.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class DiscussionRepository {
  Future<ResponseEntity> getDiscussionsByContent(
      int courseId, int courseModuleId, int contentId, String contentType);
  Future<ResponseEntity> getDiscussionDetails(int discussionId);
  Future<ResponseEntity> createDiscussion(int courseId, int courseModuleId,
      int contentId, String contentType, String description);
  Future<ResponseEntity> updateDiscussion(int discussionId, String description);
  Future<ResponseEntity> deleteDiscussion(int discussionId);
  Future<ResponseEntity> voteDiscussion(int discussionId);
  Future<ResponseEntity> getDiscussionComments(int discussionId);
  Future<ResponseEntity> createComment(int discussionId, String description);
  Future<ResponseEntity> updateComment(int commentId, String description);
  Future<ResponseEntity> deleteComment(int commentId);
  Future<ResponseEntity> voteComment(int commentId);
  Future<ResponseEntity> reportComment(int commentId, String remarks);
}

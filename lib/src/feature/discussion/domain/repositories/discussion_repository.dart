import '../../../shared/domain/entities/response_entity.dart';

abstract class DiscussionRepository {
  Future<ResponseEntity> getDiscussions();
  Future<ResponseEntity> getDiscussionDetails(int discussionId);
  Future<ResponseEntity> getDiscussionComments(int discussionId);
}

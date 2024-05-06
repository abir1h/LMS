import '../../../shared/domain/entities/response_entity.dart';
import '../entities/discussion_data_entity.dart';
import '../repositories/discussion_repository.dart';

class DiscussionUseCase {
  final DiscussionRepository _discussionRepository;
  DiscussionUseCase({required DiscussionRepository discussionRepository})
      : _discussionRepository = discussionRepository;

  Future<ResponseEntity> getDiscussionsByContentUseCase(int courseId,
      int courseModuleId, int contentId, String contentType) async {
    final response = _discussionRepository.getDiscussionsByContent(
        courseId, courseModuleId, contentId, contentType);
    return response;
  }

  Future<ResponseEntity> getDiscussionDetailsUseCase(int discussionId) async {
    final response = _discussionRepository.getDiscussionDetails(discussionId);
    return response;
  }

  Future<ResponseEntity> createDiscussionUseCase(
      int courseId,
      int courseModuleId,
      int contentId,
      String contentType,
      String description) async {
    final response = _discussionRepository.createDiscussion(
        courseId, courseModuleId, contentId, contentType, description);
    return response;
  }

  Future<ResponseEntity> updateDiscussionUseCase(
      int discussionId, String description) async {
    final response =
        _discussionRepository.updateDiscussion(discussionId, description);
    return response;
  }

  Future<ResponseEntity> deleteDiscussionUseCase(int discussionId) async {
    final response = _discussionRepository.deleteDiscussion(discussionId);
    return response;
  }

  Future<ResponseEntity> voteDiscussionUseCase(int discussionId) async {
    final response = _discussionRepository.voteDiscussion(discussionId);
    return response;
  }

  Future<ResponseEntity> getDiscussionCommentsUseCase(int discussionId) async {
    final response = _discussionRepository.getDiscussionComments(discussionId);
    return response;
  }

  Future<ResponseEntity> createCommentUseCase(
      int discussionId, String description) async {
    final response =
        _discussionRepository.createComment(discussionId, description);
    return response;
  }

  Future<ResponseEntity> voteCommentUseCase(int commentId) async {
    final response = _discussionRepository.voteComment(commentId);
    return response;
  }

  Future<ResponseEntity> reportCommentUseCase(
      int commentId, String remarks) async {
    final response = _discussionRepository.reportComment(commentId, remarks);
    return response;
  }
}

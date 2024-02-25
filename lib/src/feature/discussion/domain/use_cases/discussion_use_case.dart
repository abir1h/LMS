import '../../../shared/domain/entities/response_entity.dart';
import '../entities/discussion_data_entity.dart';
import '../repositories/discussion_repository.dart';

class DiscussionUseCase {
  final DiscussionRepository _discussionRepository;
  DiscussionUseCase({required DiscussionRepository discussionRepository})
      : _discussionRepository = discussionRepository;

  Future<ResponseEntity> getDiscussionsByContentUseCase(
      int contentId, String contentType) async {
    final response =
        _discussionRepository.getDiscussionsByContent(contentId, contentType);
    return response;
  }

  Future<ResponseEntity> getDiscussionDetailsUseCase(int discussionId) async {
    final response = _discussionRepository.getDiscussionDetails(discussionId);
    return response;
  }

  Future<ResponseEntity> createDiscussionUseCase(
      DiscussionDataEntity discussionDataEntity) async {
    final response =
        _discussionRepository.createDiscussion(discussionDataEntity);
    return response;
  }

  Future<ResponseEntity> updateDiscussionUseCase(
      DiscussionDataEntity discussionDataEntity) async {
    final response =
        _discussionRepository.updateDiscussion(discussionDataEntity);
    return response;
  }

  Future<ResponseEntity> deleteDiscussionUseCase(int discussionId) async {
    final response = _discussionRepository.deleteDiscussion(discussionId);
    return response;
  }

  Future<ResponseEntity> getDiscussionCommentsUseCase(int discussionId) async {
    final response = _discussionRepository.getDiscussionComments(discussionId);
    return response;
  }
}

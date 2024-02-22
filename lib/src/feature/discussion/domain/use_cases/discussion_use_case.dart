import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/discussion_repository.dart';

class DiscussionUseCase {
  final DiscussionRepository _discussionRepository;
  DiscussionUseCase({required DiscussionRepository discussionRepository})
      : _discussionRepository = discussionRepository;

  Future<ResponseEntity> getDiscussionsUseCase() async {
    final response = _discussionRepository.getDiscussions();
    return response;
  }

  Future<ResponseEntity> getDiscussionDetailsUseCase(int discussionId) async {
    final response = _discussionRepository.getDiscussionDetails(discussionId);
    return response;
  }

  Future<ResponseEntity> getDiscussionCommentsUseCase(int discussionId) async {
    final response = _discussionRepository.getDiscussionComments(discussionId);
    return response;
  }
}

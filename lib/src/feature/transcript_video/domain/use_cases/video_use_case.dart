import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/video_repository.dart';

class VideoUseCase {
  final VideoRepository _videoRepository;
  VideoUseCase({required VideoRepository videoRepository})
      : _videoRepository = videoRepository;

  Future<ResponseEntity> videoActivityUseCase(int circularVideoId,
      int lastWatchTime, List<int> questionSeenList) async {
    final response = _videoRepository.videoActivity(
        circularVideoId, lastWatchTime, questionSeenList);
    return response;
  }
}

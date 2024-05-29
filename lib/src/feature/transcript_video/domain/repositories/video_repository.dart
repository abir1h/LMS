import '../../../shared/domain/entities/response_entity.dart';

abstract class VideoRepository {
  Future<ResponseEntity> videoActivity(
      int circularVideoId, int lastWatchTime, List<int> questionSeenList);
}

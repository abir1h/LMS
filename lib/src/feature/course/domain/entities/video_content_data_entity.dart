import 'video_activity_data_entity.dart';
import 'video_qustion_data_entity.dart';

import 'video_data_entity.dart';

class VideoContentDataEntity {
  final VideoDataEntity? videoData;
  final VideoActivityDataEntity? videoActivityData;
  final List<VideoQuestionDataEntity>? videoQuestion;

  const VideoContentDataEntity(
      {required this.videoData,
      required this.videoActivityData,
      required this.videoQuestion});
}

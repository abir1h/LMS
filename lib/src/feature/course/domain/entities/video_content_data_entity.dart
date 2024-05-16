import 'package:lms/src/feature/course/domain/entities/video_qustion_data_entity.dart';

import 'video_data_entity.dart';

class VideoContentDataEntity {
  final VideoDataEntity? videoData;
  final List<VideoQustionDataEntity>? videoQustion;

  const VideoContentDataEntity(
      {required this.videoData, required this.videoQustion});
}

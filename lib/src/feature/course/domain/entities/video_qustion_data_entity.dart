import 'package:lms/src/feature/course/domain/entities/video_choice_data_entity.dart';

class VideoQustionDataEntity {
  final int id;
  final int videoId;
  final String questionText;
  final int popUpTimeSecond;
  final bool status;
  final List<VideoChoiceDataEntity> choices;

  VideoQustionDataEntity({
    required this.id,
    required this.videoId,
    required this.questionText,
    required this.popUpTimeSecond,
    required this.status,
    required this.choices,
  });
}

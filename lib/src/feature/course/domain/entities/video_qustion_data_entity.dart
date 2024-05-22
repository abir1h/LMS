import 'video_choice_data_entity.dart';

class VideoQuestionDataEntity {
  final int id;
  final int videoId;
  final String questionText;
  final int popUpTimeSecond;
  final bool message;
  final bool seen;
  final List<VideoChoiceDataEntity> choices;

  VideoQuestionDataEntity({
    required this.id,
    required this.videoId,
    required this.questionText,
    required this.popUpTimeSecond,
    required this.message,
    required this.seen,
    required this.choices,
  });
}

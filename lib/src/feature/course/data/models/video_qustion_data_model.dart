import 'package:flutter/cupertino.dart';
import 'package:lms/src/feature/course/data/models/video_choice_data_model.dart';

@immutable
class VideoQuestionDataModel {
  final int id;
  final int videoId;
  final String questionText;
  final int popUpTimeSecond;
  final bool message;
  final bool seen;
  final List<VideoChoiceDataModel> choices;

  const VideoQuestionDataModel({
    required this.id,
    required this.videoId,
    required this.questionText,
    required this.popUpTimeSecond,
    required this.message,
    required this.seen,
    required this.choices,
  });

  factory VideoQuestionDataModel.fromJson(Map<String, dynamic> json) =>
      VideoQuestionDataModel(
        id: json["id"] ?? -1,
        videoId: json["video_id"] ?? -1,
        questionText: json["question_text"] ?? "",
        popUpTimeSecond: json["pop_up_time_second"] ?? -1,
        message: json["message"] ?? false,
        seen: json["seen"] ?? false,
        choices: json["choices"] != null
            ? List<VideoChoiceDataModel>.from(
                (json["choices"]).map((x) => VideoChoiceDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video_id": videoId,
        "question_text": questionText,
        "pop_up_time_second": popUpTimeSecond,
        "message": message,
        "seen": seen,
        "choices":
            List<VideoChoiceDataModel>.from(choices.map((x) => x.toJson())),
      };
}

import 'package:flutter/cupertino.dart';
import 'package:lms/src/feature/course/data/models/video_choice_data_model.dart';
@immutable
class VideoQustionDataModel {
  final int id;
  final int videoId;
  final String questionText;
  final int popUpTimeSecond;
  final bool status;
  final List<VideoChoiceDataModel> choices;

  const VideoQustionDataModel({
    required this.id,
    required this.videoId,
    required this.questionText,
    required this.popUpTimeSecond,
    required this.status,
    required this.choices,
  });

  factory VideoQustionDataModel.fromJson(Map<String, dynamic> json) =>
      VideoQustionDataModel(
        id: json["id"]??-1,
        videoId: json["video_id"]??-1,
        questionText: json["question_text"]??"",
        popUpTimeSecond: json["pop_up_time_second"]??-1,
        status: json["status"]??false,
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
        "status": status,
        "choices":
            List<VideoChoiceDataModel>.from(choices.map((x) => x.toJson())),
      };
}

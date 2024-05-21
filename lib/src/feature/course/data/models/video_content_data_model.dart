import 'package:flutter/foundation.dart';
import 'video_activity_data_model.dart';
import 'video_qustion_data_model.dart';
import 'video_data_model.dart';

@immutable
class VideoContentDataModel {
  final VideoDataModel? videoData;
  final VideoActivityDataModel? videoActivity;
  final List<VideoQuestionDataModel>? videoQuestion;

  const VideoContentDataModel(
      {required this.videoData,
      required this.videoActivity,
      required this.videoQuestion});

  factory VideoContentDataModel.fromJson(Map<String, dynamic> json) =>
      VideoContentDataModel(
        videoData: json['video'] != null
            ? VideoDataModel.fromJson(json['video'])
            : null,
        videoActivity: json['activity'] != null
            ? VideoActivityDataModel.fromJson(json['activity'])
            : null,
        videoQuestion: json["questions"] != null
            ? List<VideoQuestionDataModel>.from((json["questions"])
                .map((x) => VideoQuestionDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "video": videoData?.toJson(),
        "activity": videoActivity?.toJson(),
        "questions": List<VideoQuestionDataModel>.from(
            videoQuestion!.map((x) => x.toJson())),
      };
}

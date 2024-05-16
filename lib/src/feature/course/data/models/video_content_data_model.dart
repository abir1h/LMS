import 'package:flutter/foundation.dart';
import 'package:lms/src/feature/course/data/models/video_qustion_data_model.dart';
import 'video_data_model.dart';

@immutable
class VideoContentDataModel {
  final VideoDataModel? videoData;
  final List<VideoQustionDataModel>? videoQustion;

  const VideoContentDataModel(
      {required this.videoData, required this.videoQustion});

  factory VideoContentDataModel.fromJson(Map<String, dynamic> json) =>
      VideoContentDataModel(
        videoData: json['video'] != null
            ? VideoDataModel.fromJson(json['video'])
            : null,
        videoQustion: json["questions"] != null
            ? List<VideoQustionDataModel>.from((json["questions"])
                .map((x) => VideoQustionDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "video": videoData?.toJson(),
        "questions": List<VideoQustionDataModel>.from(
            videoQustion!.map((x) => x.toJson())),
      };
}

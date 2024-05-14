import 'package:flutter/foundation.dart';
import 'video_data_model.dart';

@immutable
class VideoContentDataModel {
  final VideoDataModel? videoData;

  const VideoContentDataModel({
    required this.videoData,
  });

  factory VideoContentDataModel.fromJson(Map<String, dynamic> json) =>
      VideoContentDataModel(
        videoData: json['video'] != null
            ? VideoDataModel.fromJson(json['video'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "video": videoData?.toJson(),
      };
}

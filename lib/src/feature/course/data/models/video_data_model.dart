import 'package:flutter/foundation.dart';

@immutable
class VideoDataModel {
  final int id;
  final int circularId;
  final int courseId;
  final int courseModuleId;
  final String titleEn;
  final String titleBn;
  final String transcriptEn;
  final String transcriptBn;
  final int sort;
  final int status;
  final String category;
  final String videoUrl;

  const VideoDataModel({
    required this.id,
    required this.circularId,
    required this.courseId,
    required this.courseModuleId,
    required this.titleEn,
    required this.titleBn,
    required this.transcriptEn,
    required this.transcriptBn,
    required this.sort,
    required this.status,
    required this.category,
    required this.videoUrl,
  });

  factory VideoDataModel.fromJson(Map<String, dynamic> json) => VideoDataModel(
        id: json["id"] ?? -1,
        circularId: json["circular_id"] ?? -1,
        courseId: json["course_id"] ?? -1,
        courseModuleId: json["course_module_id"] ?? -1,
        titleEn: json["title_en"] ?? "",
        titleBn: json["title_bn"] ?? "",
        transcriptEn: json["transcript_en"] ?? "",
        transcriptBn: json["transcript_bn"] ?? "",
        sort: json["sort"] ?? -1,
        status: json["status"] ?? -1,
        category: json["category"] ?? "",
        videoUrl: json["video_url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "circular_id": circularId,
        "course_id": courseId,
        "course_module_id": courseModuleId,
        "title_en": titleEn,
        "title_bn": titleBn,
        "transcript_en": transcriptEn,
        "transcript_bn": transcriptBn,
        "sort": sort,
        "status": status,
        "category": category,
        "video_url": videoUrl,
      };
}

import 'package:flutter/foundation.dart';

@immutable
class VideoDataModel {
  final int id;
  final int courseId;
  final int courseModuleId;
  final String titleEn;
  final String titleBn;
  final String type;
  final String url;
  final String transcriptEn;
  final String transcriptBn;
  final String category;
  final String history;

  const VideoDataModel({
    required this.id,
    required this.courseId,
    required this.courseModuleId,
    required this.titleEn,
    required this.titleBn,
    required this.type,
    required this.url,
    required this.transcriptEn,
    required this.transcriptBn,
    required this.category,
    required this.history,
  });

  factory VideoDataModel.fromJson(Map<String, dynamic> json) => VideoDataModel(
        id: json["id"] ?? -1,
        courseId: json["course_id"] ?? -1,
        courseModuleId: json["course_module_id"] ?? -1,
        titleEn: json["title_en"] ?? "",
        titleBn: json["title_bn"] ?? "",
        type: json["type"] ?? "",
        url: json["url"] ?? "",
        transcriptEn: json["transcript_en"] ?? "",
        transcriptBn: json["transcript_bn"] ?? "",
        category: json["category"] ?? "",
        history: json["history"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "course_module_id": courseModuleId,
        "title_en": titleEn,
        "title_bn": titleBn,
        "type": type,
        "url": url,
        "transcript_en": transcriptEn,
        "transcript_bn": transcriptBn,
        "category": category,
        "history": history,
      };
}

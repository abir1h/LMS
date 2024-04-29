import 'package:flutter/foundation.dart';

@immutable
class ScriptDataModel {
  final int id;
  final int courseId;
  final int courseModuleId;
  final String titleEn;
  final String titleBn;
  final String descriptionEn;
  final String descriptionBn;
  final String type;
  final String thumbnail;
  final String file;
  final int readingTime;
  final String url;
  final int status;

  const ScriptDataModel({
    required this.id,
    required this.courseId,
    required this.courseModuleId,
    required this.titleEn,
    required this.titleBn,
    required this.descriptionEn,
    required this.descriptionBn,
    required this.type,
    required this.thumbnail,
    required this.file,
    required this.readingTime,
    required this.url,
    required this.status,
  });

  factory ScriptDataModel.fromJson(Map<String, dynamic> json) =>
      ScriptDataModel(
        id: json["id"] ?? -1,
        courseId: json["course_id"] ?? -1,
        courseModuleId: json["course_module_id"] ?? -1,
        titleEn: json["title_en"] ?? "",
        titleBn: json["title_bn"] ?? "",
        descriptionEn: json["description_en"] ?? "",
        descriptionBn: json["description_bn"] ?? "",
        type: json["type"] ?? "",
        thumbnail: json["thumbnail"] ?? "",
        file: json["file"] ?? "",
        readingTime: json["reading_time"] ?? -1,
        url: json["url"] ?? "",
        status: json["status"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "course_module_id": courseModuleId,
        "title_en": titleEn,
        "title_bn": titleBn,
        "description_en": descriptionEn,
        "description_bn": descriptionBn,
        "type": type,
        "thumbnail": thumbnail,
        "file": file,
        "reading_time": readingTime,
        "url": url,
        "status": status,
      };
}

import 'package:flutter/cupertino.dart';

@immutable
class ScriptDataModel {
  final int id;
  final int courseId;
  final int courseModuleId;
  final String titleEn;
  final String titleBn;
  final String descriptionEn;
  final String descriptionBn;
  final String file;
  final int readingTime;
  final int status;

  const ScriptDataModel({
    required this.id,
    required this.courseId,
    required this.courseModuleId,
    required this.titleEn,
    required this.titleBn,
    required this.descriptionEn,
    required this.descriptionBn,
    required this.file,
    required this.readingTime,
    required this.status,
  });

  factory ScriptDataModel.fromJson(Map<String, dynamic> json) => ScriptDataModel(
    id: json["id"]??-1,
    courseId: json["course_id"]??-1,
    courseModuleId: json["course_module_id"]??-1,
    titleEn: json["title_en"]??"",
    titleBn: json["title_bn"]??"",
    descriptionEn: json["description_en"]??"",
    descriptionBn: json["description_bn"]??"",
    file: json["file"]??"",
    readingTime: json["reading_time"]??-1,
    status: json["status"]??-1,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course_id": courseId,
    "course_module_id": courseModuleId,
    "title_en": titleEn,
    "title_bn": titleBn,
    "description_en": descriptionEn,
    "description_bn": descriptionBn,
    "file": file,
    "reading_time": readingTime,
    "status": status,
  };
}

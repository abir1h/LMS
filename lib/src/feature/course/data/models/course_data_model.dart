import 'package:flutter/cupertino.dart';

@immutable
class CourseDataModel {
  final int id;
  final String code;
  final String nameEn;
  final String nameBn;
  final int circularId;
  final String startDate;
  final String endDate;
  final String publishDate;
  final int circularStatus;
  final int courseProgress;

  const CourseDataModel({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.circularId,
    required this.startDate,
    required this.endDate,
    required this.publishDate,
    required this.circularStatus,
    required this.courseProgress,
  });

  factory CourseDataModel.fromJson(Map<String, dynamic> json) =>
      CourseDataModel(
        id: json["id"] ?? -1,
        code: json["code"] ?? "",
        nameEn: json["name_en"] ?? "",
        nameBn: json["name_bn"] ?? "",
        circularId: json["circular_id"] ?? -1,
        startDate: json["start_date"] ?? "",
        endDate: json["end_date"] ?? "",
        publishDate: json["publish_date"] ?? "",
        circularStatus: json["circular_status"] ?? -1,
        courseProgress: json["course_progress"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name_en": nameEn,
        "name_bn": nameBn,
        "circular_id": circularId,
        "start_date": startDate,
        "end_date": endDate,
        "publish_date": publishDate,
        "circular_status": circularStatus,
        "course_progress": courseProgress,
      };
}

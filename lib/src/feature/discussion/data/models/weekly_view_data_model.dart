import 'package:flutter/material.dart';

@immutable
class WeeklyViewDataModel {
  final int id;
  final int courseId;
  final int circularId;
  final String code;
  final String nameEn;
  final String nameBn;
  final String startDate;
  final String endDate;
  final int sort;
  final String learningOutcomeEn;
  final String learningOutcomeBn;
  final bool isModified;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int coursediscussionsCount;
  final String latestTime;

  const WeeklyViewDataModel({
    required this.id,
    required this.courseId,
    required this.circularId,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.startDate,
    required this.endDate,
    required this.sort,
    required this.learningOutcomeEn,
    required this.learningOutcomeBn,
    required this.isModified,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.coursediscussionsCount,
    required this.latestTime,
  });

  factory WeeklyViewDataModel.fromJson(Map<String, dynamic> json) =>
      WeeklyViewDataModel(
        id: json["id"] ?? -1,
        courseId: json["course_id"] ?? -1,
        circularId: json["circular_id"] ?? -1,
        code: json["code"] ?? "",
        nameEn: json["name_en"] ?? "",
        nameBn: json["name_bn"] ?? "",
        startDate: json["start_date"] ?? "",
        endDate: json["end_date"] ?? "",
        sort: json["sort"] ?? -1,
        learningOutcomeEn: json["learning_outcome_en"] ?? "",
        learningOutcomeBn: json["learning_outcome_bn"] ?? "",
        isModified: json["is_modified"] ?? false,
        status: json["status"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        coursediscussionsCount: json["coursediscussions_count"] ?? -1,
        latestTime: json["latest_time"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "circular_id": circularId,
        "code": code,
        "name_en": nameEn,
        "name_bn": nameBn,
        "start_date": startDate,
        "end_date": endDate,
        "sort": sort,
        "learning_outcome_en": learningOutcomeEn,
        "learning_outcome_bn": learningOutcomeBn,
        "is_modified": isModified,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "coursediscussions_count": coursediscussionsCount,
        "latest_time": latestTime,
      };
  static List<WeeklyViewDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, WeeklyViewDataModel>(
            json.map((x) => WeeklyViewDataModel.fromJson(x)).toList())
        : [];
  }
}

import 'package:flutter/foundation.dart';

import 'course_content_data_model.dart';

@immutable
class CourseModuleDataModel {
  final int id;
  final int courseId;
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
  final List<CourseContentDataModel>? courseContents;

  const CourseModuleDataModel(
      {required this.id,
      required this.courseId,
      required this.code,
      required this.nameEn,
      required this.nameBn,
      required this.startDate,
      required this.endDate,
      required this.sort,
      required this.learningOutcomeEn,
      required this.learningOutcomeBn,
      required this.isModified,
      required this.courseContents,
      required this.status});

  factory CourseModuleDataModel.fromJson(Map<String, dynamic> json) =>
      CourseModuleDataModel(
        id: json["id"] ?? -1,
        courseId: json["course_id"] ?? -1,
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
        courseContents: List<CourseContentDataModel>.from(
            (json["course_contents"] ?? [])
                .map((x) => CourseContentDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
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
        "course_contents": List<CourseContentDataModel>.from(
            courseContents!.map((x) => x.toJson())),
      };
  static List<CourseContentDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, CourseContentDataModel>(
            json.map((x) => CourseContentDataModel.fromJson(x)).toList())
        : [];
  }
}

import 'course_content_data_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
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
  final bool isModified;
  final List<CourseContentDataModel>? courseContents;

  const CourseModuleDataModel({
    required this.id,
    required this.courseId,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.startDate,
    required this.endDate,
    required this.sort,
    required this.isModified,
    required this.courseContents,
  });

  factory CourseModuleDataModel.fromRawJson(String str) => CourseModuleDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseModuleDataModel.fromJson(Map<String, dynamic> json) => CourseModuleDataModel(
    id: json["id"]??-1,
    courseId: json["course_id"]??-1,
    code: json["code"]??"",
    nameEn: json["name_en"]??"",
    nameBn: json["name_bn"]??"",
    startDate: json["start_date"]??"",
    endDate: json["end_date"]??"",
    sort: json["sort"]??-1,
    isModified: json["is_modified"]??false,
    courseContents: List<CourseContentDataModel>.from(
        (json["data"] ?? []).map((x) => CourseContentDataModel.fromJson(x))),
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
    "is_modified": isModified,
    "course_contents": List<CourseContentDataModel>.from(courseContents!.map((x) => x.toJson())),
  };
  static List<CourseContentDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, CourseContentDataModel>(
        json.map((x) => CourseContentDataModel.fromJson(x)).toList())
        : [];
  }
}


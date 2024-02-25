import 'package:flutter/material.dart';

import 'course_module_data_model.dart';
import 'course_type_data_model.dart';

@immutable
class CourseDetailsDataModel {
  final int id;
  final String code;
  final String nameEn;
  final String nameBn;
  final String shortDescEn;
  final String shortDescBn;
  final int courseTypeId;
  final CourseTypeDataModel? courseType;
  final List<CourseModuleDataModel>? courseModules;

  const CourseDetailsDataModel({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.shortDescEn,
    required this.shortDescBn,
    required this.courseTypeId,
    required this.courseType,
    required this.courseModules,
  });

  factory CourseDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      CourseDetailsDataModel(
        id: json["id"] ?? -1,
        code: json["code"] ?? "",
        nameEn: json["name_en"] ?? "",
        nameBn: json["name_bn"] ?? "",
        shortDescEn: json["short_desc_en"] ?? "",
        shortDescBn: json["short_desc_bn"] ?? "",
        courseTypeId: json["course_type_id"] ?? -1,
        courseType: json['course_type'] != null
            ? CourseTypeDataModel.fromJson(json['course_type'])
            : null,
        courseModules: json["course_modules"] != null
            ? List<CourseModuleDataModel>.from((json["course_modules"])
                .map((x) => CourseModuleDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name_en": nameEn,
        "name_bn": nameBn,
        "short_desc_en": shortDescEn,
        "short_desc_bn": shortDescBn,
        "course_type_id": courseTypeId,
        "course_type": courseType?.toJson(),
        "course_modules": List<CourseModuleDataModel>.from(
            courseModules!.map((x) => x.toJson())),
      };
}
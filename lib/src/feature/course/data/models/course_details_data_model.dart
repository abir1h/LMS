import 'package:flutter/material.dart';

import 'content_count_data_model.dart';
import 'course_module_data_model.dart';
import 'course_type_data_model.dart';
import 'last_viewed_content_data_model.dart';
import 'upcoming_class_data_model.dart';

@immutable
class CourseDetailsDataModel {
  final int id;
  final String code;
  final String nameEn;
  final String nameBn;
  final String shortDescEn;
  final String shortDescBn;
  final int courseTypeId;
  final String icon;
  final String featuredImage;
  final String supportingDoc;
  final String longDescEn;
  final String longDescBn;
  final UpcomingClassDataModel? upcomingClass;
  final ContentCountDataModel? contentCount;
  final LastViewedContentDataModel? lastViewedContent;
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
    required this.icon,
    required this.featuredImage,
    required this.supportingDoc,
    required this.longDescEn,
    required this.longDescBn,
    required this.upcomingClass,
    required this.contentCount,
    required this.lastViewedContent,
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
        icon: json["icon"] ?? "",
        featuredImage: json["featured_image"] ?? "",
        supportingDoc: json["supporting_doc"] ?? "",
        longDescEn: json["long_desc_en"] ?? "",
        longDescBn: json["long_desc_bn"] ?? "",
        upcomingClass: json['upcoming_class'] != null
            ? UpcomingClassDataModel.fromJson(json['upcoming_class'])
            : null,
        contentCount: json['content_count'] != null
            ? ContentCountDataModel.fromJson(json['content_count'])
            : null,
        lastViewedContent: json['last_viewed_content'] != null
            ? LastViewedContentDataModel.fromJson(json['last_viewed_content'])
            : null,
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
        "icon": icon,
        "featured_image": featuredImage,
        "supporting_doc": supportingDoc,
        "long_desc_en": longDescEn,
        "long_desc_bn": longDescBn,
        "upcoming_class": upcomingClass?.toJson(),
        "content_count": contentCount?.toJson(),
        "last_viewed_content": lastViewedContent?.toJson(),
        "course_type": courseType?.toJson(),
        "course_modules": List<CourseModuleDataModel>.from(
            courseModules!.map((x) => x.toJson())),
      };
}

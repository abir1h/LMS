import 'package:flutter/foundation.dart';

import '../../../course/data/models/course_data_model.dart';
import 'course_summary_data_model.dart';

@immutable
class DashboardDataModel {
  final List<CourseDataModel> courses;
  final CourseSummaryDataModel? courseSummery;
  final int discussion;

  const DashboardDataModel({
    required this.courses,
    required this.courseSummery,
    required this.discussion,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) =>
      DashboardDataModel(
        courses: json["courses"] != null
            ? List<CourseDataModel>.from(
                (json["courses"]).map((x) => CourseDataModel.fromJson(x)))
            : [],
        courseSummery: json['course_summery'] != null
            ? CourseSummaryDataModel.fromJson(json['course_summery'])
            : null,
        discussion: json["discussion"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
        "course_summery": courseSummery?.toJson(),
        "discussion": discussion,
      };
}

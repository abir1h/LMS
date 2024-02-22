import 'package:flutter/cupertino.dart';
import 'course_data_model.dart';

@immutable
class AllCourseDataModel {
  final List<CourseDataModel> courses;
  final List<CourseDataModel> running;

  const AllCourseDataModel({
    required this.courses,
    required this.running,
  });

  factory AllCourseDataModel.fromJson(Map<String, dynamic> json) =>
      AllCourseDataModel(
        courses: json["courses"] != null
            ? List<CourseDataModel>.from(
                (json["courses"]).map((x) => CourseDataModel.fromJson(x)))
            : [],
        running: json["running"] != null
            ? List<CourseDataModel>.from(
                (json["running"]).map((x) => CourseDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "courses": List<CourseDataModel>.from(courses.map((x) => x)),
        "running": List<CourseDataModel>.from(running.map((x) => x.toJson())),
      };
}

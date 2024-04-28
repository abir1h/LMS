import 'package:flutter/cupertino.dart';
import 'course_data_model.dart';

@immutable
class AllCourseDataModel {
  final List<CourseDataModel> courses;
  final List<CourseDataModel> running;
  final List<CourseDataModel> upcoming;
  final List<CourseDataModel> completed;

  const AllCourseDataModel({
    required this.courses,
    required this.running,
    required this.upcoming,
    required this.completed,
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
        upcoming: json["upcoming"] != null
            ? List<CourseDataModel>.from(
                (json["upcoming"]).map((x) => CourseDataModel.fromJson(x)))
            : [],
        completed: json["completed"] != null
            ? List<CourseDataModel>.from(
                (json["completed"]).map((x) => CourseDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "courses": List<CourseDataModel>.from(courses.map((x) => x)),
        "running": List<CourseDataModel>.from(running.map((x) => x.toJson())),
        "upcoming": List<CourseDataModel>.from(upcoming.map((x) => x)),
        "completed":
            List<CourseDataModel>.from(completed.map((x) => x.toJson())),
      };
}

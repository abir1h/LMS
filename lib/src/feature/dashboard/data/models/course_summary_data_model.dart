import 'package:flutter/material.dart';

@immutable
class CourseSummaryDataModel {
  final int runningCourses;
  final int completedCourses;
  final int upcomingCourses;

  const CourseSummaryDataModel({
    required this.runningCourses,
    required this.completedCourses,
    required this.upcomingCourses,
  });

  factory CourseSummaryDataModel.fromJson(Map<String, dynamic> json) =>
      CourseSummaryDataModel(
        runningCourses: json["running_courses"] ?? -1,
        completedCourses: json["completed_courses"] ?? -1,
        upcomingCourses: json["upcoming_courses"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "running_courses": runningCourses,
        "completed_courses": completedCourses,
        "upcoming_courses": upcomingCourses,
      };
}

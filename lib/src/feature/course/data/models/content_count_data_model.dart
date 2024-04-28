import 'package:flutter/material.dart';

@immutable
class ContentCountDataModel {
  final int courseWeekCount;
  final int blendedClassCount;
  final int scriptCount;
  final int videoCount;
  final int assignmentCount;
  final int assessmentCount;

  const ContentCountDataModel({
    required this.courseWeekCount,
    required this.blendedClassCount,
    required this.scriptCount,
    required this.videoCount,
    required this.assignmentCount,
    required this.assessmentCount,
  });

  factory ContentCountDataModel.fromJson(Map<String, dynamic> json) =>
      ContentCountDataModel(
        courseWeekCount: json["course_week_count"] ?? -1,
        blendedClassCount: json["blended_class_count"] ?? -1,
        scriptCount: json["script_count"] ?? -1,
        videoCount: json["video_count"] ?? -1,
        assignmentCount: json["assignment_count"] ?? -1,
        assessmentCount: json["assessment_count"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "course_week_count": courseWeekCount,
        "blended_class_count": blendedClassCount,
        "script_count": scriptCount,
        "video_count": videoCount,
        "assignment_count": assignmentCount,
        "assessment_count": assessmentCount,
      };
}

import 'package:flutter/foundation.dart';

@immutable
class CurrentModuleDataModel {
  final String courseTitle;
  final String courseTitleBN;
  final String completion;

  const CurrentModuleDataModel({
    required this.courseTitle,
    required this.courseTitleBN,
    required this.completion,
  });

  factory CurrentModuleDataModel.fromJson(Map<String, dynamic> json) =>
      CurrentModuleDataModel(
          courseTitle: json["course_title"] ?? "",
          courseTitleBN: json["course_title_bn"] ?? "",
          completion: json["completion"] ?? "");

  Map<String, dynamic> toJson() => {
        "course_title": courseTitle,
        "course_title_bn": courseTitleBN,
        "completion": completion,
      };
}

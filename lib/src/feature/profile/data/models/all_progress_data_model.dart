import 'package:flutter/cupertino.dart';
import 'package:lms/src/feature/profile/data/models/completed_course_data_model.dart';
import 'package:lms/src/feature/profile/data/models/progress_course_data_model.dart';
import 'package:lms/src/feature/profile/data/models/user_info_data_model.dart';

@immutable
class AllProgressDataModel {
  final List<ProgressCourseDataModel> running;
  final List<CompletedCourseDataModel> completed;
  final UserInfoDataModel? userInfoDataModel;

  const AllProgressDataModel(
      {required this.running,
      required this.completed,
      required this.userInfoDataModel});

  factory AllProgressDataModel.fromJson(Map<String, dynamic> json) =>
      AllProgressDataModel(
        running: json["running"] != null
            ? List<ProgressCourseDataModel>.from((json["running"])
                .map((x) => ProgressCourseDataModel.fromJson(x)))
            : [],
        completed: json["completed"] != null
            ? List<CompletedCourseDataModel>.from((json["completed"])
                .map((x) => CompletedCourseDataModel.fromJson(x)))
            : [],
        userInfoDataModel: json['user_info'] != null
            ? UserInfoDataModel.fromJson(json['user_info'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "running":
            List<ProgressCourseDataModel>.from(running.map((x) => x.toJson())),
        "completed": List<ProgressCourseDataModel>.from(
            completed.map((x) => x.toJson())),
        "user_info": userInfoDataModel?.toJson(),
      };
}

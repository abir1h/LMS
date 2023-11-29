import 'package:flutter/foundation.dart';

import 'activity_duration_data_model.dart';
import 'current_module_data_model.dart';
import 'curriculum_data_model.dart';

@immutable
class DashboardDataModel {
  final CurrentModuleDataModel? currentModuleData;
  final CurriculumDataModel? curriculumData;
  final int discussions;
  final int noticesCount;
  final ActivityDurationDataModel? activityDurationData;
  final List<String> noticeboardList;

  const DashboardDataModel(
      {required this.currentModuleData,
      required this.curriculumData,
      required this.discussions,
      required this.noticesCount,
      required this.activityDurationData,
      required this.noticeboardList});

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) =>
      DashboardDataModel(
          currentModuleData: json["currentModule"] == null
              ? null
              : CurrentModuleDataModel.fromJson(json["currentModule"]),
          curriculumData: json["curriculam"] == null
              ? null
              : CurriculumDataModel.fromJson(json["curriculam"]),
          discussions: json["discussions"] ?? 0,
          noticesCount: json["notices_count"] ?? 0,
          activityDurationData: json['activity_duration'] == null
              ? null
              : ActivityDurationDataModel.fromJson(json["activity_duration"]),
          noticeboardList: json['noticeboard'] == null
              ? []
              : List<String>.from(json["noticeboard"].map((x) => x)));
}

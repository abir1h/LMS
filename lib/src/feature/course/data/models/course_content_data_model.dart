import 'package:flutter/foundation.dart';

@immutable
class CourseContentDataModel {
  final String contentTitleEn;
  final String contentTitleBn;
  final String contentType;
  final int contentId;
  final int sort;
  final bool isCompleted;
  final String lastWatchTime;

  const CourseContentDataModel(
      {required this.contentTitleEn,
      required this.contentTitleBn,
      required this.contentType,
      required this.contentId,
      required this.sort,
      required this.isCompleted,
      required this.lastWatchTime});

  factory CourseContentDataModel.fromJson(Map<String, dynamic> json) =>
      CourseContentDataModel(
        contentTitleEn: json["content_title_en"] ?? "",
        contentTitleBn: json["content_title_bn"] ?? "",
        contentType: json["content_type"] ?? "",
        contentId: json["content_id"] ?? -1,
        sort: json["sort"] ?? -1,
        isCompleted: json["is_completed"] ?? false,
        lastWatchTime: json["last_watch_time"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "content_title_en": contentTitleEn,
        "content_title_bn": contentTitleBn,
        "content_type": contentType,
        "content_id": contentId,
        "sort": sort,
      };
  static List<CourseContentDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, CourseContentDataModel>(
            json.map((x) => CourseContentDataModel.fromJson(x)).toList())
        : [];
  }
}

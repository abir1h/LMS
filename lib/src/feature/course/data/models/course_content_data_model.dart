import 'package:flutter/foundation.dart';

@immutable
class CourseContentDataModel {
  final String contentType;
  final int contentId;
  final int sort;
  final String titleEn;
  final String titleBn;
  final bool isCompleted;
  final String lastWatchTime;

  const CourseContentDataModel(
      {required this.contentType,
      required this.contentId,
      required this.sort,
      required this.titleEn,
      required this.titleBn,
      required this.isCompleted,
      required this.lastWatchTime});

  factory CourseContentDataModel.fromJson(Map<String, dynamic> json) =>
      CourseContentDataModel(
        contentType: json["content_type"] ?? "",
        contentId: json["content_id"] ?? -1,
        sort: json["sort"] ?? -1,
        titleEn: json["title_en"] ?? "",
        titleBn: json["title_bn"] ?? "",
        isCompleted: json["is_completed"] ?? false,
        lastWatchTime: json["last_watch_time"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "content_type": contentType,
        "content_id": contentId,
        "sort": sort,
        "title_en": titleEn,
        "title_bn": titleBn,
      };
  static List<CourseContentDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, CourseContentDataModel>(
            json.map((x) => CourseContentDataModel.fromJson(x)).toList())
        : [];
  }
}

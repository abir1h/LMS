import 'package:meta/meta.dart';
import 'dart:convert';

@immutable
class CourseContentDataModel {
  final String contentType;
  final int contentId;
  final int sort;
  final String titleEn;
  final String titleBn;

  const CourseContentDataModel({
    required this.contentType,
    required this.contentId,
    required this.sort,
    required this.titleEn,
    required this.titleBn,
  });

  factory CourseContentDataModel.fromJson(Map<String, dynamic> json) =>
      CourseContentDataModel(
        contentType: json["content_type"] ?? "",
        contentId: json["content_id"] ?? -1,
        sort: json["sort"] ?? -1,
        titleEn: json["title_en"] ?? "",
        titleBn: json["title_bn"] ?? "",
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

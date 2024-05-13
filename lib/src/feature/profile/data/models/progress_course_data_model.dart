import 'package:flutter/cupertino.dart';

@immutable
class ProgressCourseDataModel {
 final int id;
  final String code;
  final String nameEn;
  final String nameBn;
  final String featuredImage;
  final String icon;
  final int circularId;
  final String referenceNumber;
  final String startDate;
  final String endDate;
  final String publishDate;
  final String flag;
  final String url;
  final int circularStatus;
  final int batchId;
  final String batchNameEn;
  final String batchNameBn;
  final int batchStatus;
  final int courseModulesCount;
  final int blendedClassesCount;
  final int courseScriptsCount;
  final int courseProgress;
  const ProgressCourseDataModel({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.featuredImage,
    required this.icon,
    required this.circularId,
    required this.referenceNumber,
    required this.startDate,
    required this.endDate,
    required this.publishDate,
    required this.flag,
    required this.url,
    required this.circularStatus,
    required this.batchId,
    required this.batchNameEn,
    required this.batchNameBn,
    required this.batchStatus,
    required this.courseModulesCount,
    required this.blendedClassesCount,
    required this.courseScriptsCount,
    required this.courseProgress,
  });

  factory ProgressCourseDataModel.fromJson(Map<String, dynamic> json) =>
      ProgressCourseDataModel(
        id: json["id"] ?? -1,
        code: json["code"] ?? "",
        nameEn: json["name_en"] ?? "",
        nameBn: json["name_bn"] ?? "",
        featuredImage: json["featured_image"] ?? "",
        icon: json["icon"] ?? "",
        circularId: json["circular_id"] ?? -1,
        referenceNumber: json["reference_number"] ?? "",
        startDate: json["start_date"] ?? "",
        endDate: json["end_date"] ?? "",
        publishDate: json["publish_date"] ?? "",
        flag: json["flag"] ?? "",
        url: json["url"] ?? "",
        circularStatus: json["circular_status"] ?? -1,
        batchId: json["batch_id"] ?? -1,
        batchNameEn: json["batch_name_en"] ?? "",
        batchNameBn: json["batch_name_bn"] ?? "",
        batchStatus: json["batch_status"] ?? -1,
        courseModulesCount: json["course_modules_count"] ?? -1,
        blendedClassesCount: json["blended_classes_count"] ?? -1,
        courseScriptsCount: json["course_scripts_count"] ?? -1,
        courseProgress: json["course_progress"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name_en": nameEn,
        "name_bn": nameBn,
        "featured_image": featuredImage,
        "icon": icon,
        "circular_id": circularId,
        "reference_number": referenceNumber,
        "start_date": startDate,
        "end_date": endDate,
        "publish_date": publishDate,
        "flag": flag,
        "url": url,
        "circular_status": circularStatus,
        "batch_id": batchId,
        "batch_name_en": batchNameEn,
        "batch_name_bn": batchNameBn,
        "batch_status": batchStatus,
        "course_modules_count": courseModulesCount,
        "blended_classes_count": blendedClassesCount,
        "course_scripts_count": courseScriptsCount,
        "course_progress": courseProgress,
      };
  static List<ProgressCourseDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, ProgressCourseDataModel>(
            json.map((x) => ProgressCourseDataModel.fromJson(x)).toList())
        : [];
  }
}

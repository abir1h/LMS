import 'package:flutter/material.dart';

@immutable
class CircularDataModel {
  final int id;
  final int batchId;
  final int courseId;
  final String referenceNumber;
  final String nameEn;
  final String nameBn;
  final int status;
  final String startDate;
  final String endDate;
  final String courseNameEn;
  final String courseNameBn;
  final String code;
  final String batchNameEn;
  final String batchNameBn;
  final int circularTrainersCount;

  const CircularDataModel({
    required this.id,
    required this.batchId,
    required this.courseId,
    required this.referenceNumber,
    required this.nameEn,
    required this.nameBn,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.courseNameEn,
    required this.courseNameBn,
    required this.code,
    required this.batchNameEn,
    required this.batchNameBn,
    required this.circularTrainersCount,
  });

  factory CircularDataModel.fromJson(Map<String, dynamic> json) =>
      CircularDataModel(
        id: json["id"] ?? -1,
        batchId: json["batch_id"] ?? -1,
        courseId: json["course_id"] ?? -1,
        referenceNumber: json["reference_number"] ?? "",
        nameEn: json["name_en"] ?? "",
        nameBn: json["name_bn"] ?? "",
        status: json["status"] ?? -1,
        startDate: json["start_date"] ?? "",
        endDate: json["end_date"] ?? "",
        courseNameEn: json["course_name_en"] ?? "",
        courseNameBn: json["course_name_bn"] ?? "",
        code: json["code"] ?? "",
        batchNameEn: json["batch_name_en"] ?? "",
        batchNameBn: json["batch_name_bn"] ?? "",
        circularTrainersCount: json["circular_trainers_count"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "batch_id": batchId,
        "course_id": courseId,
        "reference_number": referenceNumber,
        "name_en": nameEn,
        "name_bn": nameBn,
        "status": status,
        "start_date": startDate,
        "end_date": endDate,
        "course_name_en": courseNameEn,
        "course_name_bn": courseNameBn,
        "code": code,
        "batch_name_en": batchNameEn,
        "batch_name_bn": batchNameBn,
        "circular_trainers_count": circularTrainersCount,
      };
  static List<CircularDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, CircularDataModel>(
            json.map((x) => CircularDataModel.fromJson(x)).toList())
        : [];
  }
}

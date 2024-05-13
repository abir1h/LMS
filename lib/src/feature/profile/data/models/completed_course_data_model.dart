import 'package:flutter/cupertino.dart';

@immutable
class CompletedCourseDataModel {
  final int id;
  final String code;
  final String nameEn;
  final String nameBn;
  final int circularId;
  final String endDate;
  final int circularStatus;
  final int marks;

  const CompletedCourseDataModel({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.circularId,
    required this.endDate,
    required this.circularStatus,
    required this.marks,
  });

  factory CompletedCourseDataModel.fromJson(Map<String, dynamic> json) => CompletedCourseDataModel(
    id: json["id"]??-1,
    code: json["code"]??"",
    nameEn: json["name_en"]??"",
    nameBn: json["name_bn"]??"",
    circularId: json["circular_id"]??-1,
    endDate: json["end_date"]??"",
    circularStatus: json["circular_status"]??-1,
    marks: json["marks"]??-1,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name_en": nameEn,
    "name_bn": nameBn,
    "circular_id": circularId,
    "end_date": endDate,
    "circular_status": circularStatus,
    "marks": marks,
  };
}

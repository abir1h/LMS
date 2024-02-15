import 'package:meta/meta.dart';
import 'dart:convert';
@immutable
class CourseTypeDataModel {
  final int id;
  final String nameEn;
  final String nameBn;
  final int status;

  const CourseTypeDataModel({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.status,
  });



  factory CourseTypeDataModel.fromJson(Map<String, dynamic> json) => CourseTypeDataModel(
    id: json["id"]??-1,
    nameEn: json["name_en"]??"",
    nameBn: json["name_bn"]??"",
    status: json["status"]??-1,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_en": nameEn,
    "name_bn": nameBn,
    "status": status,
  };
}

import 'package:flutter/foundation.dart';

@immutable
class BlendedCourseDataModel {
  final int id;
  final String nameEn;
  final String nameBn;

  const BlendedCourseDataModel({
    required this.id,
    required this.nameEn,
    required this.nameBn,
  });

  factory BlendedCourseDataModel.fromJson(Map<String, dynamic> json) =>
      BlendedCourseDataModel(
        id: json["id"] ?? -1,
        nameEn: json["name_en"] ?? "",
        nameBn: json["name_bn"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_en": nameEn,
    "name_bn": nameBn,
  };
}

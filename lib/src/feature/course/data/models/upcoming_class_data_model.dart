import 'package:flutter/material.dart';

@immutable
class UpcomingClassDataModel {
  final String id;
  final String titleEn;
  final String titleBn;
  final String scheduleAt;

  const UpcomingClassDataModel({
    required this.id,
    required this.titleEn,
    required this.titleBn,
    required this.scheduleAt,
  });

  factory UpcomingClassDataModel.fromJson(Map<String, dynamic> json) =>
      UpcomingClassDataModel(
        id: json["id"] ?? "",
        titleEn: json["title_en"] ?? "",
        titleBn: json["title_bn"] ?? "",
        scheduleAt: json["schedule_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title_en": titleEn,
        "title_bn": titleBn,
        "schedule_at": scheduleAt,
      };
}

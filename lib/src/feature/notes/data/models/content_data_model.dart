import 'package:flutter/cupertino.dart';

@immutable
class ContentDataModel {
  final int id;
  final String titleEn;
  final String titleBn;

  const ContentDataModel({
    required this.id,
    required this.titleEn,
    required this.titleBn,
  });

  factory ContentDataModel.fromJson(Map<String, dynamic> json) =>
      ContentDataModel(
        id: json["id"] ?? -1,
        titleEn: json["title_en"] ?? "",
        titleBn: json["title_bn"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title_en": titleEn,
        "title_bn": titleBn,
      };
}

import 'package:flutter/material.dart';

@immutable
class BatchDataModel {
  final int id;
  final String nameEn;
  final String nameBn;

  const BatchDataModel({
    required this.id,
    required this.nameEn,
    required this.nameBn,
  });

  factory BatchDataModel.fromJson(Map<String, dynamic> json) => BatchDataModel(
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

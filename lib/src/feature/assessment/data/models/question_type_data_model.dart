import 'package:flutter/cupertino.dart';

@immutable
class QuestionTypeDataModel {
  final int id;
  final String nameEn;
  final String nameBn;

  const QuestionTypeDataModel({
    required this.id,
    required this.nameEn,
    required this.nameBn,
  });

  factory QuestionTypeDataModel.fromJson(Map<String, dynamic> json) => QuestionTypeDataModel(
    id: json["id"]??-1,
    nameEn: json["name_en"]??"",
    nameBn: json["name_bn"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_en": nameEn,
    "name_bn": nameBn,
  };
}
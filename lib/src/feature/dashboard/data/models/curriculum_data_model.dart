import 'package:flutter/foundation.dart';

@immutable
class CurriculumDataModel {
  final int onGoing;
  final int completed;

  const CurriculumDataModel({
    required this.onGoing,
    required this.completed,
  });

  factory CurriculumDataModel.fromJson(Map<String, dynamic> json) =>
      CurriculumDataModel(
          onGoing: json["ongoing"] ?? "", completed: json["completed"] ?? "");

  Map<String, dynamic> toJson() => {
        "ongoing": onGoing,
        "completed": completed,
      };
}

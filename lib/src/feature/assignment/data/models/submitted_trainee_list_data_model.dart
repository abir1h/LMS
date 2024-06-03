import 'package:flutter/material.dart';

@immutable
class SubmittedTraineeListDataModel {
  final int id;
  final int status;
  final int isAccepted;
  final int isReviewed;

  const SubmittedTraineeListDataModel({
    required this.id,
    required this.status,
    required this.isAccepted,
    required this.isReviewed,
  });

  factory SubmittedTraineeListDataModel.fromJson(Map<String, dynamic> json) =>
      SubmittedTraineeListDataModel(
        id: json["id"] ?? -1,
        status: json["status"] ?? -1,
        isAccepted: json["is_accepted"] ?? -1,
        isReviewed: json["is_reviewed"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "is_accepted": isAccepted,
        "is_reviewed": isReviewed,
      };
}

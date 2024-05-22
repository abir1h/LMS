import 'package:flutter/cupertino.dart';

@immutable
class ResultDataModel {
  final int id;
  final int traineeId;
  final int circularAssessmentId;
  final String startTime;
  final String endTime;
  final String completionTime;
  final int answeredQuestion;
  final int totalMark;
  final int availedMark;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  const ResultDataModel({
    required this.id,
    required this.traineeId,
    required this.circularAssessmentId,
    required this.startTime,
    required this.endTime,
    required this.completionTime,
    required this.answeredQuestion,
    required this.totalMark,
    required this.availedMark,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory ResultDataModel.fromJson(Map<String, dynamic> json) =>
      ResultDataModel(
        id: json["id"] ?? -1,
        traineeId: json["trainee_id"] ?? -1,
        circularAssessmentId: json["circular_assessment_id"] ?? -1,
        startTime: json["start_time"] ?? "",
        endTime: json["end_time"] ?? "",
        completionTime: json["completion_time"] ?? "",
        answeredQuestion: json["answered_question"] ?? 0,
        totalMark: json["total_mark"] ?? 0,
        availedMark: json["availed_mark"] ?? 0,
        status: json["status"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trainee_id": traineeId,
        "circular_assessment_id": circularAssessmentId,
        "start_time": startTime,
        "end_time": endTime,
        "completion_time": completionTime,
        "answered_question": answeredQuestion,
        "total_mark": totalMark,
        "availed_mark": availedMark,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}

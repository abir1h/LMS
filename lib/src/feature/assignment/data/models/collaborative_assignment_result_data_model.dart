import 'package:flutter/material.dart';

@immutable
class CollaborativeAssignmentResultDataModel {
  final int id;
  final int assignmentId;
  final int evaluatedBy;
  final int markObtained;
  final String acceptTime;
  final String details;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int assignmentSubmissionId;

  const CollaborativeAssignmentResultDataModel({
    required this.id,
    required this.assignmentId,
    required this.evaluatedBy,
    required this.markObtained,
    required this.acceptTime,
    required this.details,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.assignmentSubmissionId,
  });

  factory CollaborativeAssignmentResultDataModel.fromJson(
          Map<String, dynamic> json) =>
      CollaborativeAssignmentResultDataModel(
        id: json["id"] ?? -1,
        assignmentId: json["assignment_id"] ?? -1,
        evaluatedBy: json["evaluated_by"] ?? -1,
        markObtained: json["mark_obtained"] ?? 0,
        acceptTime: json["accept_time"] ?? "",
        details: json["details"] ?? "",
        status: json["status"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        assignmentSubmissionId: json["assignment_submission_id"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assignment_id": assignmentId,
        "evaluated_by": evaluatedBy,
        "mark_obtained": markObtained,
        "accept_time": acceptTime,
        "details": details,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "assignment_submission_id": assignmentSubmissionId,
      };
}

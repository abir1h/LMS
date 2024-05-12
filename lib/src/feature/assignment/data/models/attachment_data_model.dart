import 'package:flutter/material.dart';

@immutable
class AttachmentDataModel {
  final int id;
  final int assignmentSubmissionId;
  final String file;
  final String createdAt;
  final String updatedAt;

  const AttachmentDataModel({
    required this.id,
    required this.assignmentSubmissionId,
    required this.file,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttachmentDataModel.fromJson(Map<String, dynamic> json) =>
      AttachmentDataModel(
        id: json["id"] ?? -1,
        assignmentSubmissionId: json["assignment_submission_id"] ?? -1,
        file: json["file"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assignment_submission_id": assignmentSubmissionId,
        "file": file,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

import 'package:flutter/material.dart';

import 'attachment_data_model.dart';

@immutable
class AssignmentSubmissionDataModel {
  final int id;
  final int circularId;
  final int courseId;
  final int circularAssignmentId;
  final int circularSubAssignmentId;
  final int submittedBy;
  final String evaluatedBy;
  final String ipAddress;
  final String answer;
  final int marks;
  final String remarks;
  final int status;
  final int isResubmitted;
  final String createdAt;
  final String updatedAt;
  final List<AttachmentDataModel> attachments;

  const AssignmentSubmissionDataModel({
    required this.id,
    required this.circularId,
    required this.courseId,
    required this.circularAssignmentId,
    required this.circularSubAssignmentId,
    required this.submittedBy,
    required this.evaluatedBy,
    required this.ipAddress,
    required this.answer,
    required this.marks,
    required this.remarks,
    required this.status,
    required this.isResubmitted,
    required this.createdAt,
    required this.updatedAt,
    required this.attachments,
  });

  factory AssignmentSubmissionDataModel.fromJson(Map<String, dynamic> json) =>
      AssignmentSubmissionDataModel(
        id: json["id"] ?? -1,
        circularId: json["circular_id"] ?? -1,
        courseId: json["course_id"] ?? -1,
        circularAssignmentId: json["circular_assignment_id"] ?? -1,
        circularSubAssignmentId: json["circular_sub_assignment_id"] ?? -1,
        submittedBy: json["submitted_by"] ?? -1,
        evaluatedBy: json["evaluated_by"] ?? "",
        ipAddress: json["ip_address"] ?? "",
        answer: json["answer"] ?? "",
        marks: json["marks"] ?? -1,
        remarks: json["remarks"] ?? "",
        status: json["status"] ?? -1,
        isResubmitted: json["is_resubmitted"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        attachments: json["attachments"] != null
            ? List<AttachmentDataModel>.from((json["attachments"])
                .map((x) => AttachmentDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "circular_id": circularId,
        "course_id": courseId,
        "circular_assignment_id": circularAssignmentId,
        "circular_sub_assignment_id": circularSubAssignmentId,
        "submitted_by": submittedBy,
        "evaluated_by": evaluatedBy,
        "ip_address": ipAddress,
        "answer": answer,
        "marks": marks,
        "remarks": remarks,
        "status": status,
        "is_resubmitted": isResubmitted,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "attachments":
            List<AttachmentDataModel>.from(attachments.map((x) => x.toJson())),
      };
}

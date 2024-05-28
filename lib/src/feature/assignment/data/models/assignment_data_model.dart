import 'package:flutter/material.dart';
import 'package:lms/src/feature/assignment/data/models/sub_assignment_data_model.dart';

import 'assignment_submission_data_model.dart';

@immutable
class AssignmentDataModel {
  final int id;
  final int courseId;
  final int circularId;
  final int courseModuleId;
  final String titleEn;
  final String titleBn;
  final int mark;
  final int passMark;
  final int totalTime;
  final String submissionType;
  final String extendedDueDate;
  final String assignmentStartTime;
  final String assignmentEndTime;
  final String descriptionEn;
  final String descriptionBn;
  final String instructionsEn;
  final String instructionsBn;
  final String type;
  final String supportingDoc;
  final int assignmentRequestCount;
  final bool allowed;
  final SubAssignmentDataModel? circularSubAssignments;
  final AssignmentSubmissionDataModel? assignmentSubmissions;

  const AssignmentDataModel({
    required this.id,
    required this.courseId,
    required this.circularId,
    required this.courseModuleId,
    required this.titleEn,
    required this.titleBn,
    required this.mark,
    required this.passMark,
    required this.totalTime,
    required this.submissionType,
    required this.extendedDueDate,
    required this.assignmentStartTime,
    required this.assignmentEndTime,
    required this.descriptionEn,
    required this.descriptionBn,
    required this.instructionsEn,
    required this.instructionsBn,
    required this.type,
    required this.supportingDoc,
    required this.assignmentRequestCount,
    required this.allowed,
    required this.circularSubAssignments,
    required this.assignmentSubmissions,
  });

  factory AssignmentDataModel.fromJson(Map<String, dynamic> json) =>
      AssignmentDataModel(
        id: json["id"] ?? -1,
        courseId: json["course_id"] ?? -1,
        circularId: json["circular_id"] ?? -1,
        courseModuleId: json["course_module_id"] ?? -1,
        titleEn: json["title_en"] ?? "",
        titleBn: json["title_bn"] ?? "",
        mark: json["mark"] ?? -1,
        passMark: json["pass_mark"] ?? -1,
        totalTime: json["total_time"] ?? -1,
        submissionType: json["submission_type"] ?? "",
        extendedDueDate: json["extended_due_date"] ?? "",
        assignmentStartTime: json["assignment_start_time"] ?? "",
        assignmentEndTime: json["assignment_end_time"] ?? "",
        descriptionEn: json["description_en"] ?? "",
        descriptionBn: json["description_bn"] ?? "",
        instructionsEn: json["instructions_en"] ?? "",
        instructionsBn: json["instructions_bn"] ?? "",
        type: json["type"] ?? "",
        supportingDoc: json["supporting_doc"] ?? "",
        assignmentRequestCount: json["assignment_request_count"] ?? 0,
        allowed: json["allowed"] ?? false,
        circularSubAssignments: json['circular_sub_assignments'] != null
            ? SubAssignmentDataModel.fromJson(json["circular_sub_assignments"])
            : null,
        assignmentSubmissions: json['assignment_submissions'] != null
            ? AssignmentSubmissionDataModel.fromJson(
                json["assignment_submissions"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "circular_id": circularId,
        "course_module_id": courseModuleId,
        "title_en": titleEn,
        "title_bn": titleBn,
        "mark": mark,
        "pass_mark": passMark,
        "total_time": totalTime,
        "submission_type": submissionType,
        "extended_due_date": extendedDueDate,
        "assignment_start_time": assignmentStartTime,
        "assignment_end_time": assignmentEndTime,
        "description_en": descriptionEn,
        "description_bn": descriptionBn,
        "instructions_en": instructionsEn,
        "instructions_bn": instructionsBn,
        "type": type,
        "supporting_doc": supportingDoc,
        "assignment_request_count": assignmentRequestCount,
        "allowed": allowed,
        "circular_sub_assignments": circularSubAssignments?.toJson(),
        "assignment_submissions": assignmentSubmissions?.toJson(),
      };
}

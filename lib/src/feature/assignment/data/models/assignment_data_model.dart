import 'package:flutter/cupertino.dart';

@immutable
class AssignmentDataModel {
  final int id;
  final int courseId;
  final int courseModuleId;
  final String titleEn;
  final String titleBn;
  final int mark;
  final int passMark;
  final int totalTime;
  final String assignmentStartTime;
  final String assignmentEndTime;
  final String extendedDueDate;
  final String instructionsEn;
  final String instructionsBn;
  final String supportingDoc;
  final String submissionType;
  final bool isGroupAssignments;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String deletedAt;

  const AssignmentDataModel({
    required this.id,
    required this.courseId,
    required this.courseModuleId,
    required this.titleEn,
    required this.titleBn,
    required this.mark,
    required this.passMark,
    required this.totalTime,
    required this.assignmentStartTime,
    required this.assignmentEndTime,
    required this.extendedDueDate,
    required this.instructionsEn,
    required this.instructionsBn,
    required this.supportingDoc,
    required this.submissionType,
    required this.isGroupAssignments,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory AssignmentDataModel.fromJson(Map<String, dynamic> json) => AssignmentDataModel(
    id: json["id"]??-1,
    courseId: json["course_id"]??-1,
    courseModuleId: json["course_module_id"]??-1,
    titleEn: json["title_en"]??"",
    titleBn: json["title_bn"]??"",
    mark: json["mark"]??-1,
    passMark: json["pass_mark"]??-1,
    totalTime: json["total_time"]??-1,
    assignmentStartTime: json["assignment_start_time"]??"",
    assignmentEndTime: json["assignment_end_time"]??"",
    extendedDueDate: json["extended_due_date"]??"",
    instructionsEn: json["instructions_en"]??"",
    instructionsBn: json["instructions_bn"]??"",
    supportingDoc: json["supporting_doc"]??"",
    submissionType: json["submission_type"]??"",
    isGroupAssignments: json["is_group_assignments"]??false,
    status: json["status"]??-1,
    createdAt:json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
    deletedAt: json["deleted_at"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course_id": courseId,
    "course_module_id": courseModuleId,
    "title_en": titleEn,
    "title_bn": titleBn,
    "mark": mark,
    "pass_mark": passMark,
    "total_time": totalTime,
    "assignment_start_time": assignmentStartTime,
    "assignment_end_time": assignmentEndTime,
    "extended_due_date": extendedDueDate,
    "instructions_en": instructionsEn,
    "instructions_bn": instructionsBn,
    "supporting_doc": supportingDoc,
    "submission_type": submissionType,
    "is_group_assignments": isGroupAssignments,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

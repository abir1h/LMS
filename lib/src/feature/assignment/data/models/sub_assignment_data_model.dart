import 'package:flutter/material.dart';

@immutable
class SubAssignmentDataModel {
  final int id;
  final int circularAssignmentsId;
  final int parentId;
  final String traineesIds;
  final String titleEn;
  final String titleBn;
  final String instructionsEn;
  final String instructionsBn;
  final String supportingDoc;
  final int status;
  final String createdAt;
  final String updatedAt;

  const SubAssignmentDataModel({
    required this.id,
    required this.circularAssignmentsId,
    required this.parentId,
    required this.traineesIds,
    required this.titleEn,
    required this.titleBn,
    required this.instructionsEn,
    required this.instructionsBn,
    required this.supportingDoc,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubAssignmentDataModel.fromJson(Map<String, dynamic> json) =>
      SubAssignmentDataModel(
        id: json["id"] ?? -1,
        circularAssignmentsId: json["circular_assignments_id"] ?? -1,
        parentId: json["parent_id"] ?? -1,
        traineesIds: json["trainees_ids"] ?? "",
        titleEn: json["title_en"] ?? "",
        titleBn: json["title_bn"] ?? "",
        instructionsEn: json["instructions_en"] ?? "",
        instructionsBn: json["instructions_bn"] ?? "",
        supportingDoc: json["supporting_doc"] ?? "",
        status: json["status"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "circular_assignments_id": circularAssignmentsId,
        "parent_id": parentId,
        "trainees_ids": traineesIds,
        "title_en": titleEn,
        "title_bn": titleBn,
        "instructions_en": instructionsEn,
        "instructions_bn": instructionsBn,
        "supporting_doc": supportingDoc,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

import 'package:flutter/cupertino.dart';

@immutable
class AssignmentRequestModel {
  final String circularId;
  final String courseId;
  final String courseModuleId;
  final String circularAssignmentId;
  final String message;
  final int traineeId;
  final int status;
  final String updatedAt;
  final String createdAt;
  final int id;

  const AssignmentRequestModel({
    required this.circularId,
    required this.courseId,
    required this.courseModuleId,
    required this.circularAssignmentId,
    required this.message,
    required this.traineeId,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory AssignmentRequestModel.fromJson(Map<String, dynamic> json) => AssignmentRequestModel(
    circularId: json["circular_id"]??-1,
    courseId: json["course_id"]??-1,
    courseModuleId: json["course_module_id"]??-1,
    circularAssignmentId: json["circular_assignment_id"]??-1,
    message: json["message"]??"",
    traineeId: json["trainee_id"]??-1,
    status: json["status"]??-1,
    updatedAt: json["updated_at"]??"",
    createdAt: json["created_at"]??"",
    id: json["id"]??-1,
  );

  Map<String, dynamic> toJson() => {
    "circular_id": circularId,
    "course_id": courseId,
    "course_module_id": courseModuleId,
    "circular_assignment_id": circularAssignmentId,
    "message": message,
    "trainee_id": traineeId,
    "status": status,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}

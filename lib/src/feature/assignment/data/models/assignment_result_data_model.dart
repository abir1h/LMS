class AssignmentResultDataModel {
  final int id;
  final int assignmentSubmissionId;
  final int circularSubAssignmentId;
  final String traineesId;
  final int markObtained;
  final int evaluatedBy;
  final int status;
  final String createdAt;
  final String updatedAt;

  AssignmentResultDataModel({
    required this.id,
    required this.assignmentSubmissionId,
    required this.circularSubAssignmentId,
    required this.traineesId,
    required this.markObtained,
    required this.evaluatedBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AssignmentResultDataModel.fromJson(Map<String, dynamic> json) =>
      AssignmentResultDataModel(
        id: json["id"] ?? -1,
        assignmentSubmissionId: json["assignment_submission_id"] ?? -1,
        circularSubAssignmentId: json["circular_sub_assignment_id"] ?? -1,
        traineesId: json["trainees_id"] ?? "",
        markObtained: json["mark_obtained"] ?? 0,
        evaluatedBy: json["evaluated_by"] ?? -1,
        status: json["status"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assignment_submission_id": assignmentSubmissionId,
        "circular_sub_assignment_id": circularSubAssignmentId,
        "trainees_id": traineesId,
        "mark_obtained": markObtained,
        "evaluated_by": evaluatedBy,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

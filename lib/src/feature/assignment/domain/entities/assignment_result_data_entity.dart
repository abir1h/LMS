class AssignmentResultDataEntity {
  final int id;
  final int assignmentSubmissionId;
  final int circularSubAssignmentId;
  final String traineesId;
  final int markObtained;
  final int evaluatedBy;
  final int status;
  final String createdAt;
  final String updatedAt;

  AssignmentResultDataEntity({
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
}

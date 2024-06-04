class CollaborativeAssignmentResultDataEntity {
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

  CollaborativeAssignmentResultDataEntity({
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
}

class AssignmentSubmissionDataEntity {
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
  final String status;
  final String isResubmitted;
  final String createdAt;
  final String updatedAt;

  AssignmentSubmissionDataEntity({
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
  });
}
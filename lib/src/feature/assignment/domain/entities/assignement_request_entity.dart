class AssignmentRequestEntity {
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

  AssignmentRequestEntity({
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
}

class AttachmentDataEntity {
  final int id;
  final int assignmentSubmissionId;
  final String file;
  final String createdAt;
  final String updatedAt;

  AttachmentDataEntity({
    required this.id,
    required this.assignmentSubmissionId,
    required this.file,
    required this.createdAt,
    required this.updatedAt,
  });
}

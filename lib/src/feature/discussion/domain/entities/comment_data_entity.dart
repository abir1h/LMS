class CommentDataEntity {
  final int id;
  final int discussionId;
  final String description;
  final String attachment;
  int vote;
  final int createdBy;
  final int status;
  final String createdAt;
  final String updatedAt;
  final bool hasRestriction;
  final String restrictedBy;
  final String restrictionRemarks;
  final int report;
  final bool isVote;
  final bool isReport;
  final bool isSelf;

  CommentDataEntity({
    required this.id,
    required this.discussionId,
    required this.description,
    required this.attachment,
    required this.vote,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.hasRestriction,
    required this.restrictedBy,
    required this.restrictionRemarks,
    required this.report,
    required this.isVote,
    required this.isReport,
    required this.isSelf,
  });
}

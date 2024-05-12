import 'comment_data_entity.dart';

class DiscussionDataEntity {
  final int id;
  final int courseModuleId;
  final String contentType;
  final int contentId;
  final String description;
  final String attachment;
  int vote;
  final int createdBy;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int courseId;
  final int report;
  final bool hasRestriction;
  final String restrictedBy;
  final String restrictionRemarks;
  final bool isDeleted;
  final bool isVote;
  final bool isReport;
  final bool isSelf;
  final int cid;
  final String titleEn;
  final String titleBn;
  final List<CommentDataEntity> comments;

  DiscussionDataEntity({
    required this.id,
    required this.courseModuleId,
    required this.contentType,
    required this.contentId,
    required this.description,
    required this.attachment,
    required this.vote,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.courseId,
    required this.report,
    required this.hasRestriction,
    required this.restrictedBy,
    required this.restrictionRemarks,
    required this.isDeleted,
    required this.isVote,
    required this.isReport,
    required this.isSelf,
    required this.cid,
    required this.titleEn,
    required this.titleBn,
    required this.comments,
  });
}

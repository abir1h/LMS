import 'package:flutter/material.dart';

@immutable
class CommentDataModel {
  final int id;
  final int discussionId;
  final String description;
  final String attachment;
  final int vote;
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
  const CommentDataModel({
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

  factory CommentDataModel.fromJson(Map<String, dynamic> json) =>
      CommentDataModel(
        id: json["id"] ?? -1,
        discussionId: json["discussion_id"] ?? -1,
        description: json["description"] ?? "",
        attachment: json["attachment"] ?? "",
        vote: json["vote"] ?? -1,
        createdBy: json["created_by"] ?? -1,
        status: json["status"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        hasRestriction: json["has_restriction"] ?? false,
        restrictedBy: json["restricted_by"] ?? "",
        restrictionRemarks: json["restriction_remarks"] ?? "",
        report: json["report"] ?? -1,
        isVote: json["is_vote"] ?? false,
        isReport: json["is_report"] ?? false,
        isSelf: json["is_self"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "discussion_id": discussionId,
        "description": description,
        "attachment": attachment,
        "vote": vote,
        "created_by": createdBy,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "has_restriction": hasRestriction,
        "restricted_by": restrictedBy,
        "restriction_remarks": restrictionRemarks,
        "report": report,
        "is_vote": isVote,
        "is_report": isReport,
        "is_self": isSelf,
      };
}

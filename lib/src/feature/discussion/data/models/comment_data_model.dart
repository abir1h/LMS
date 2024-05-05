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
      };
}

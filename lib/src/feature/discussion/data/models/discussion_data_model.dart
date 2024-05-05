import 'package:flutter/material.dart';

import 'comment_data_model.dart';

@immutable
class DiscussionDataModel {
  final int id;
  final int courseModuleId;
  final String contentType;
  final int contentId;
  final String description;
  final String attachment;
  final int vote;
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
  final int cid;
  final String titleEn;
  final String titleBn;
  final List<CommentDataModel>? comments;

  const DiscussionDataModel({
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
    required this.cid,
    required this.titleEn,
    required this.titleBn,
    this.comments,
  });

  factory DiscussionDataModel.fromJson(Map<String, dynamic> json) =>
      DiscussionDataModel(
        id: json["id"] ?? -1,
        courseModuleId: json["course_module_id"] ?? -1,
        contentType: json["content_type"] ?? "",
        contentId: json["content_id"] ?? -1,
        description: json["description"] ?? "",
        attachment: json["attachment"] ?? "",
        vote: json["vote"] ?? -1,
        createdBy: json["created_by"] ?? -1,
        status: json["status"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        courseId: json["course_id"] ?? -1,
        report: json["report"] ?? -1,
        hasRestriction: json["has_restriction"] ?? false,
        restrictedBy: json["restricted_by"] ?? "",
        restrictionRemarks: json["restriction_remarks"] ?? "",
        isDeleted: json["is_deleted"] ?? false,
        cid: json["cid"] ?? -1,
        titleEn: json["title_en"] ?? "",
        titleBn: json["title_bn"] ?? "",
        comments: json["comments"] != null
            ? List<CommentDataModel>.from(
                (json["comments"]).map((x) => CommentDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_module_id": courseModuleId,
        "content_type": contentType,
        "content_id": contentId,
        "description": description,
        "attachment": attachment,
        "vote": vote,
        "created_by": createdBy,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "course_id": courseId,
        "report": report,
        "has_restriction": hasRestriction,
        "restricted_by": restrictedBy,
        "restriction_remarks": restrictionRemarks,
        "is_deleted": isDeleted,
        "cid": cid,
        "title_en": titleEn,
        "title_bn": titleBn,
        "comments":
            List<CommentDataModel>.from(comments!.map((x) => x.toJson())),
      };

  static List<DiscussionDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, DiscussionDataModel>(
            json.map((x) => DiscussionDataModel.fromJson(x)).toList())
        : [];
  }
}

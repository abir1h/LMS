import 'package:flutter/foundation.dart';

import 'comment_data_model.dart';
import 'user_data_model.dart';

@immutable
class DiscussionCommentsDataModel {
  final int id;
  final int courseModuleId;
  final String contentType;
  final int contentId;
  final String description;
  final String attachment;
  final int createdBy;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int commentsCount;
  final UserDataModel? user;
  final List<CommentDataModel> comments;

  const DiscussionCommentsDataModel({
    required this.id,
    required this.courseModuleId,
    required this.contentType,
    required this.contentId,
    required this.description,
    required this.attachment,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.commentsCount,
    this.user,
    required this.comments,
  });

  factory DiscussionCommentsDataModel.fromJson(Map<String, dynamic> json) =>
      DiscussionCommentsDataModel(
        id: json["id"],
        courseModuleId: json["course_module_id"],
        contentType: json["content_type"],
        contentId: json["content_id"],
        description: json["description"],
        attachment: json["attachment"],
        createdBy: json["created_by"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        commentsCount: json["comments_count"],
        user:
            json['user'] != null ? UserDataModel.fromJson(json['user']) : null,
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
        "created_by": createdBy,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "comments_count": commentsCount,
        "user": user!.toJson(),
        "comments":
            List<CommentDataModel>.from(comments.map((x) => x.toJson())),
      };
}

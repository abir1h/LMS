import 'package:flutter/foundation.dart';

import 'user_data_model.dart';

@immutable
class CommentDataModel {
  final int id;
  final int discussionId;
  final String description;
  final String attachment;
  final int createdBy;
  final int status;
  final String createdAt;
  final String updatedAt;
  final UserDataModel? user;

  const CommentDataModel({
    required this.id,
    required this.discussionId,
    required this.description,
    required this.attachment,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  factory CommentDataModel.fromJson(Map<String, dynamic> json) =>
      CommentDataModel(
        id: json["id"] ?? -1,
        discussionId: json["discussion_id"] ?? -1,
        description: json["description"] ?? "",
        attachment: json["attachment"] ?? "",
        createdBy: json["created_by"] ?? -1,
        status: json["status"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        user:
            json['user'] != null ? UserDataModel.fromJson(json['user']) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "discussion_id": discussionId,
        "description": description,
        "attachment": attachment,
        "created_by": createdBy,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user": user!.toJson(),
      };

  static List<CommentDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, CommentDataModel>(
            json.map((x) => CommentDataModel.fromJson(x)).toList())
        : [];
  }
}

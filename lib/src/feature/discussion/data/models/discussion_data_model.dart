import 'package:flutter/foundation.dart';

import 'user_data_model.dart';

@immutable
class DiscussionDataModel {
  final int id;
  final int courseModuleId;
  final String contentType;
  final int contentId;
  final String description;
  final String attachment;
  final int createdBy;
  final String status;
  final String createdAt;
  final String updatedAt;
  final UserDataModel? user;

  const DiscussionDataModel({
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
    this.user,
  });

  factory DiscussionDataModel.fromJson(Map<String, dynamic> json) =>
      DiscussionDataModel(
        id: json["id"] ?? -1,
        courseModuleId: json["course_module_id"] ?? -1,
        contentType: json["content_type"] ?? "",
        contentId: json["content_id"] ?? -1,
        description: json["description"] ?? "",
        attachment: json["attachment"] ?? "",
        createdBy: json["created_by"] ?? -1,
        status: json["status"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        user:
            json['user'] != null ? UserDataModel.fromJson(json['user']) : null,
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
        "user": user!.toJson(),
      };
  static List<DiscussionDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, DiscussionDataModel>(
            json.map((x) => DiscussionDataModel.fromJson(x)).toList())
        : [];
  }
}

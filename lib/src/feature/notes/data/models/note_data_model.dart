import 'package:flutter/cupertino.dart';

import 'content_data_model.dart';

@immutable
class NoteDataModel {
  final int id;
  final int courseModuleId;
  final int contentId;
  final String contentType;
  final String title;
  final String description;
  final int createdBy;
  final int status;
  final String createdAt;
  final ContentDataModel? content;

  const NoteDataModel({
    required this.id,
    required this.courseModuleId,
    required this.contentId,
    required this.contentType,
    required this.title,
    required this.description,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.content,
  });

  factory NoteDataModel.fromJson(Map<String, dynamic> json) => NoteDataModel(
        id: json["id"] ?? -1,
        courseModuleId: json["course_module_id"] ?? -1,
        contentId: json["content_id"] ?? -1,
        contentType: json["content_type"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        createdBy: json["created_by"] ?? "",
        status: json["status"] ?? -1,
        createdAt: json["created_at"] ?? "",
        content: json['content'] != null
            ? ContentDataModel.fromJson(json['content'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_module_id": courseModuleId,
        "content_id": contentId,
        "content_type": contentType,
        "title": title,
        "description": description,
        "created_by": createdBy,
        "status": status,
        "created_at": createdAt,
        "content": content!.toJson()
      };
  static List<NoteDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, NoteDataModel>(
            json.map((x) => NoteDataModel.fromJson(x)).toList())
        : [];
  }
}

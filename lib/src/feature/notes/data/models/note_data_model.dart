import 'package:flutter/cupertino.dart';

@immutable
class NoteDataModel {
  int? id;
  int? courseModuleId;
  int? contentId;
  String? contentType;
  String title;
  String description;
  String? attachment;
  int? createdBy;
  int status;
  String? createdAt;
  String? updatedAt;
  String? contentTitleEn;
  String? contentTitleBn;

  NoteDataModel({
    this.id,
    this.courseModuleId,
    this.contentId,
    this.contentType,
    required this.title,
    required this.description,
    this.attachment,
    this.createdBy,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.contentTitleEn,
    this.contentTitleBn,
  });

  factory NoteDataModel.fromJson(Map<String, dynamic> json) => NoteDataModel(
        id: json["id"] ?? -1,
        courseModuleId: json["course_module_id"] ?? -1,
        contentId: json["content_id"] ?? -1,
        contentType: json["content_type"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        attachment: json["attachment"] ?? "",
        createdBy: json["created_by"] ?? "",
        status: json["status"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        contentTitleEn: json["content_title_en"] ?? "",
        contentTitleBn: json["content_title_bn"] ?? "",
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["id"] = id;
    if (courseModuleId != null) {
      data["course_module_id"] = courseModuleId;
    }
    data["title"] = title;
    data["description"] = description;
    data["status"] = status;

    if (updatedAt != null) {
      data["updated_at"] = updatedAt;
    }
    if (createdAt != null) {
      data["created_at"] = createdAt;
    }
    if (createdBy != null) {
      data["created_by"] = createdBy;
    }
    if (createdBy != null) {
      data["created_by"] = createdBy;
    }
    if (attachment != null) {
      data["attachment"] = attachment;
    }
    if (updatedAt != null) {
      data["updated_at"] = updatedAt;
    }
    if (contentTitleEn != null) {
      data["content_title_en"] = contentTitleEn;
    }
    if (contentTitleBn != null) {
      data["content_title_bn"] = contentTitleBn;
    }
    if (contentTitleBn != null) {
      data["content_title_bn"] = contentTitleBn;
    }
    if (contentId != null) {
      data["content_id"] = contentId;
    }
    if (contentType != null) {
      data["content_type"] = contentType;
    }
    return data;
  }

  static List<NoteDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, NoteDataModel>(
            json.map((x) => NoteDataModel.fromJson(x)).toList())
        : [];
  }
}

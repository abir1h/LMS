import 'content_data_entity.dart';

class NoteDataEntity {
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

  NoteDataEntity({
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
}

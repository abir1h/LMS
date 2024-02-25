import 'content_data_entity.dart';

class NoteDataEntity {
  final int id;
  final int courseModuleId;
  final int contentId;
  final String contentType;
  final String title;
  final String description;
  final int createdBy;
  final int status;
  final String createdAt;
  final ContentDataEntity content;

  const NoteDataEntity({
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
}

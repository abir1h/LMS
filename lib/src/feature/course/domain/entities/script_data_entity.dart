class ScriptDataEntity {
  final int id;
  final int courseId;
  final int courseModuleId;
  final String titleEn;
  final String titleBn;
  final String descriptionEn;
  final String descriptionBn;
  final String type;
  final String thumbnail;
  final String file;
  final int readingTime;
  final String url;
  final int status;

  ScriptDataEntity({
    required this.id,
    required this.courseId,
    required this.courseModuleId,
    required this.titleEn,
    required this.titleBn,
    required this.descriptionEn,
    required this.descriptionBn,
    required this.type,
    required this.thumbnail,
    required this.file,
    required this.readingTime,
    required this.url,
    required this.status,
  });
}

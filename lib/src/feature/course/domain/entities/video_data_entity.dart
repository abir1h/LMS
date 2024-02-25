class VideoDataEntity {
  final int id;
  final int courseId;
  final int courseModuleId;
  final String titleEn;
  final String titleBn;
  final String type;
  final String url;
  final String transcriptEn;
  final String transcriptBn;
  final String category;
  final String history;

  VideoDataEntity({
    required this.id,
    required this.courseId,
    required this.courseModuleId,
    required this.titleEn,
    required this.titleBn,
    required this.type,
    required this.url,
    required this.transcriptEn,
    required this.transcriptBn,
    required this.category,
    required this.history,
  });
}

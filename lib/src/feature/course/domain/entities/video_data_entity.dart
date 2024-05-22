class VideoDataEntity {
  final int id;
  final int circularId;
  final int courseId;
  final int courseModuleId;
  final String titleEn;
  final String titleBn;
  final String transcriptEn;
  final String transcriptBn;
  final int sort;
  final int message;
  final int totalDuration;
  final String category;
  final String videoUrl;
  final String createdAt;
  final String updatedAt;
  VideoDataEntity({
    required this.id,
    required this.circularId,
    required this.courseId,
    required this.courseModuleId,
    required this.titleEn,
    required this.titleBn,
    required this.transcriptEn,
    required this.transcriptBn,
    required this.sort,
    required this.message,
    required this.totalDuration,
    required this.category,
    required this.videoUrl,
    required this.createdAt,
    required this.updatedAt,

  });
}

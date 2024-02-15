class CourseContentDataEntity {
  final String contentType;
  final int contentId;
  final int sort;
  final String titleEn;
  final String titleBn;
  final bool isCompleted;
  final String lastWatchTime;
  CourseContentDataEntity({
    required this.contentType,
    required this.contentId,
    required this.sort,
    required this.titleEn,
    required this.titleBn,
    required this.isCompleted,
    required this.lastWatchTime
  });
}

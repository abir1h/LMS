class CourseContentDataEntity {
  final String contentTitleEn;
  final String contentTitleBn;
  final String contentType;
  final int contentId;
  final int sort;
  final bool isCompleted;
  final String lastWatchTime;
  CourseContentDataEntity(
      {required this.contentTitleEn,
      required this.contentTitleBn,
      required this.contentType,
      required this.contentId,
      required this.sort,
      required this.isCompleted,
      required this.lastWatchTime});
}

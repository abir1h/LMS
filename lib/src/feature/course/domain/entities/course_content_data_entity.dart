class CourseContentDataEntity {
  final String contentTitleEn;
  final String contentTitleBn;
  final String contentType;
  final int contentId;
  final int sort;
  final String schedule;
  final bool isCompleted;
   int lastWatchTime;
  CourseContentDataEntity(
      {required this.contentTitleEn,
      required this.contentTitleBn,
      required this.contentType,
      required this.contentId,
      required this.sort,
      required this.schedule,
      required this.isCompleted,
      required this.lastWatchTime});
}

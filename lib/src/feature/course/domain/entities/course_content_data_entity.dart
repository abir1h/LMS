class CourseContentDataEntity {
  final String contentType;
  final int contentId;
  final int sort;
  final String titleEn;
  final String titleBn;

  CourseContentDataEntity({
    required this.contentType,
    required this.contentId,
    required this.sort,
    required this.titleEn,
    required this.titleBn,
  });
}

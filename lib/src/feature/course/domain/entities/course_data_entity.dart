class CourseDataEntity {
  final int id;
  final String code;
  final String nameEn;
  final String nameBn;
  final int circularId;
  final String startDate;
  final String endDate;
  final String publishDate;
  final int circularStatus;
  final int courseProgress;

  CourseDataEntity({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.circularId,
    required this.startDate,
    required this.endDate,
    required this.publishDate,
    required this.circularStatus,
    required this.courseProgress,
  });
}

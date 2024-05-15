class WeeklyViewDataEntity {
  final int id;
  final int courseId;
  final int circularId;
  final String code;
  final String nameEn;
  final String nameBn;
  final String startDate;
  final String endDate;
  final int sort;
  final String learningOutcomeEn;
  final String learningOutcomeBn;
  final bool isModified;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int coursediscussionsCount;
  final String latestTime;

  WeeklyViewDataEntity({
    required this.id,
    required this.courseId,
    required this.circularId,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.startDate,
    required this.endDate,
    required this.sort,
    required this.learningOutcomeEn,
    required this.learningOutcomeBn,
    required this.isModified,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.coursediscussionsCount,
    required this.latestTime,
  });
}

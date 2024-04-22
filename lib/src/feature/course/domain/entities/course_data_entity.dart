class CourseDataEntity {
  final int id;
  final String code;
  final String nameEn;
  final String nameBn;
  final int circularId;
  final String referenceNumber;
  final String startDate;
  final String endDate;
  final String publishDate;
  final String flag;
  final String url;
  final int circularStatus;
  final int courseProgress;
  final int batchId;
  final String batchNameEn;
  final String batchNameBn;
  final int batchStatus;
  final int courseModulesCount;
  final int blendedClassesCount;
  final int physicalClassesCount;
  final int liveClassesCount;
  final int batchProgress;
  final int totalTimeSpent;
  CourseDataEntity({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.circularId,
    required this.referenceNumber,
    required this.startDate,
    required this.endDate,
    required this.publishDate,
    required this.flag,
    required this.url,
    required this.circularStatus,
    required this.courseProgress,
    required this.batchId,
    required this.batchNameEn,
    required this.batchNameBn,
    required this.batchStatus,
    required this.courseModulesCount,
    required this.blendedClassesCount,
    required this.physicalClassesCount,
    required this.liveClassesCount,
    required this.batchProgress,
    required this.totalTimeSpent,
  });
}

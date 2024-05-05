class CircularDataEntity {
  final int id;
  final int batchId;
  final int courseId;
  final String referenceNumber;
  final String nameEn;
  final String nameBn;
  final int status;
  final String startDate;
  final String endDate;
  final String courseNameEn;
  final String courseNameBn;
  final String code;
  final String batchNameEn;
  final String batchNameBn;
  final int circularTrainersCount;

  CircularDataEntity({
    required this.id,
    required this.batchId,
    required this.courseId,
    required this.referenceNumber,
    required this.nameEn,
    required this.nameBn,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.courseNameEn,
    required this.courseNameBn,
    required this.code,
    required this.batchNameEn,
    required this.batchNameBn,
    required this.circularTrainersCount,
  });
}

class ResultDataEntity {
  final int id;
  final int traineeId;
  final int circularAssessmentId;
  final String startTime;
  final String endTime;
  final String completionTime;
  final int answeredQuestion;
  final int totalMark;
  final int availedMark;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  ResultDataEntity({
    required this.id,
    required this.traineeId,
    required this.circularAssessmentId,
    required this.startTime,
    required this.endTime,
    required this.completionTime,
    required this.answeredQuestion,
    required this.totalMark,
    required this.availedMark,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });
}

class ContentReadDataEntity {
  final int id;
  final int circularId;
  final int courseId;
  final String contentType;
  final int contentId;
  final int traineeId;
  final bool isCompleted;
  final String lastWatchTime;
  final String createdAt;
  final String updatedAt;
  final String attendanceType;

  ContentReadDataEntity({
    required this.id,
    required this.circularId,
    required this.courseId,
    required this.contentType,
    required this.contentId,
    required this.traineeId,
    required this.isCompleted,
    required this.lastWatchTime,
    required this.createdAt,
    required this.updatedAt,
    required this.attendanceType,
  });
}

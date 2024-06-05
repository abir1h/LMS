class VideoActivityDataEntity {
  final int id;
  final int traineeId;
  final int circularVideoId;
   int lastViewTime;
  final List<int> questionsSeen;

  VideoActivityDataEntity({
    required this.id,
    required this.traineeId,
    required this.circularVideoId,
    required this.lastViewTime,
    required this.questionsSeen,
  });
}

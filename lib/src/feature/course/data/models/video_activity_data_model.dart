class VideoActivityDataModel {
  final int id;
  final int traineeId;
  final int circularVideoId;
  final int lastViewTime;
  final List<int> questionsSeen;

  VideoActivityDataModel({
    required this.id,
    required this.traineeId,
    required this.circularVideoId,
    required this.lastViewTime,
    required this.questionsSeen,
  });

  factory VideoActivityDataModel.fromJson(Map<String, dynamic> json) =>
      VideoActivityDataModel(
        id: json["id"] ?? -1,
        traineeId: json["trainee_id"] ?? -1,
        circularVideoId: json["circular_video_id"] ?? -1,
        lastViewTime: json["last_view_time"] ?? 0,
        questionsSeen:
            List<int>.from(json["questions_seen"].map((x) => x)) ?? [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trainee_id": traineeId,
        "circular_video_id": circularVideoId,
        "last_view_time": lastViewTime,
        "questions_seen": List<dynamic>.from(questionsSeen.map((x) => x)),
      };
}

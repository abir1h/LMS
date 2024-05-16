import 'package:flutter/cupertino.dart';

@immutable
class VideoChoiceDataModel {
  final int id;
  final String choiceText;
  final bool isCorrect;
  final int questionId;

  const VideoChoiceDataModel({
    required this.id,
    required this.choiceText,
    required this.isCorrect,
    required this.questionId,
  });

  factory VideoChoiceDataModel.fromJson(Map<String, dynamic> json) =>
      VideoChoiceDataModel(
          id: json["id"] ?? -1,
          choiceText: json["choice_text"] ?? "",
          isCorrect: json["is_correct"] ?? false,
          questionId: json["question_id"] ?? -1);

  Map<String, dynamic> toJson() => {
        "id": id,
        "choice_text": choiceText,
        "is_correct": isCorrect,
        "question_id": questionId,
      };
  static List<VideoChoiceDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, VideoChoiceDataModel>(
            json.map((x) => VideoChoiceDataModel.fromJson(x)).toList())
        : [];
  }
}

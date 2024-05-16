class VideoChoiceDataEntity {
  final int id;
  final String choiceText;
  final bool isCorrect;
  final int questionId;

  VideoChoiceDataEntity({
    required this.id,
    required this.choiceText,
    required this.isCorrect,
    required this.questionId,
  });
}
class VideoChoiceDataEntity {
  final int id;
  final String choiceText;
  final bool isCorrect;
  final int questionId;
  bool isSelected;

  VideoChoiceDataEntity({
    required this.id,
    required this.choiceText,
    required this.isCorrect,
    required this.questionId,
    this.isSelected = false,
  });
}
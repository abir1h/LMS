class OptionDataEntity {
  final int id;
  final int circularQuestionId;
  final String optionKey;
  final String optionValue;
  bool isSelected;
  final String optionImg;
  final int sort;
  String userInput;
  String userCorrectValue;
  String userCorrectInput;

  OptionDataEntity({
    required this.id,
    required this.circularQuestionId,
    required this.optionKey,
    required this.optionValue,
    this.isSelected = false,
    required this.optionImg,
    required this.sort,
    required this.userInput,
    required this.userCorrectValue,
    required this.userCorrectInput,
  });
}

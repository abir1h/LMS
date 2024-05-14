class OptionDataEntity {
  final int id;
  final int circularQuestionId;
  final String optionKey;
  final String optionValue;
  final String optionImg;
  final int sort;
  String userInput;
  bool userCorrectValue;
  String userCorrectInput;

  OptionDataEntity({
    required this.id,
    required this.circularQuestionId,
    required this.optionKey,
    required this.optionValue,
    required this.optionImg,
    required this.sort,
    required this.userInput,
    required this.userCorrectValue,
    required this.userCorrectInput,
  });
}

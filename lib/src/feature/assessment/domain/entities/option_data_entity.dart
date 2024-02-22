class OptionDataEntity {
  final int id;
  final int questionId;
  final String optionKey;
  final String optionValue;
  final String optionImg;
  final int sort;

  OptionDataEntity({
    required this.id,
    required this.questionId,
    required this.optionKey,
    required this.optionValue,
    required this.optionImg,
    required this.sort,
  });
}

import 'package:flutter/cupertino.dart';

@immutable
class OptionDataModel {
  final int id;
  final int circularQuestionId;
  final String optionKey;
  final String optionValue;
  final String optionImg;
  final int sort;
  final String userInput;
  final bool userCorrectValue;
  final String userCorrectInput;

  const OptionDataModel({
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

  factory OptionDataModel.fromJson(Map<String, dynamic> json) =>
      OptionDataModel(
        id: json["id"] ?? -1,
        circularQuestionId: json["circular_question_id"] ?? -1,
        optionKey: json["option_key"] ?? "",
        optionValue: json["option_value"] ?? "",
        optionImg: json["option_img"] ?? "",
        sort: json["sort"] ?? -1,
        userInput: json["user_input"] ?? "",
        userCorrectValue: json["user_correct_value"] ?? false,
        userCorrectInput: json["user_correct_input"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "circular_question_id": circularQuestionId,
        "option_key": optionKey,
        "option_value": optionValue,
        "option_img": optionImg,
        "sort": sort,
        "user_input": userInput,
        "user_correct_value": userCorrectValue,
        "user_correct_input": userCorrectInput,
      };
  static List<OptionDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, OptionDataModel>(
            json.map((x) => OptionDataModel.fromJson(x)).toList())
        : [];
  }
}

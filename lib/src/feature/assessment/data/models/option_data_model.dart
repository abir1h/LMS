import 'package:flutter/cupertino.dart';

@immutable
class OptionDataModel {
  final int id;
  final int questionId;
  final String optionKey;
  final String optionValue;
  final String optionImg;
  final int sort;

  const OptionDataModel({
    required this.id,
    required this.questionId,
    required this.optionKey,
    required this.optionValue,
    required this.optionImg,
    required this.sort,
  });

  factory OptionDataModel.fromJson(Map<String, dynamic> json) => OptionDataModel(
    id: json["id"]??-1,
    questionId: json["question_id"]??-1,
    optionKey: json["option_key"]??"",
    optionValue: json["option_value"]??"",
    optionImg: json["option_img"]??"",
    sort: json["sort"]??-1,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_id": questionId,
    "option_key": optionKey,
    "option_value": optionValue,
    "option_img": optionImg,
    "sort": sort,
  };  static List<OptionDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, OptionDataModel>(
        json.map((x) => OptionDataModel.fromJson(x)).toList())
        : [];
  }
}

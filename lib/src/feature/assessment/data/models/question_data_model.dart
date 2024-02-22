import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'Option_data_model.dart';
import 'question_type_data_model.dart';

@immutable
class QuestionDataModel {
  final int id;
  final int courseId;
  final int courseAssessmentId;
  final String question;
  final String questionImg;
  final String supportingNotesEn;
  final String mark;
  final String negativeMark;
  final QuestionTypeDataModel? questionType;
  final int typeId;
  final List<OptionDataModel> options;

  const QuestionDataModel({
    required this.id,
    required this.courseId,
    required this.courseAssessmentId,
    required this.question,
    required this.questionImg,
    required this.supportingNotesEn,
    required this.mark,
    required this.negativeMark,
    required this.questionType,
    required this.typeId,
    required this.options,
  });

  factory QuestionDataModel.fromJson(Map<String, dynamic> json) =>
      QuestionDataModel(
        id: json["id"],
        courseId: json["course_id"],
        courseAssessmentId: json["course_assessment_id"],
        question: json["question"],
        questionImg: json["question_img"],
        supportingNotesEn: json["supporting_notes_en"],
        mark: json["mark"],
        negativeMark: json["negative_mark"],
        questionType: json['question_type'] != null
            ? QuestionTypeDataModel.fromJson(json['question_type'])
            : null,
        typeId: json["type_id"],
        options: json["options"] != null
            ? List<OptionDataModel>.from(
                (json["options"]).map((x) => OptionDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "course_assessment_id": courseAssessmentId,
        "question": question,
        "question_img": questionImg,
        "supporting_notes_en": supportingNotesEn,
        "mark": mark,
        "negative_mark": negativeMark,
        "question_type": questionType?.toJson(),
        "type_id": typeId,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
  static List<QuestionDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, QuestionDataModel>(
            json.map((x) => QuestionDataModel.fromJson(x)).toList())
        : [];
  }
}

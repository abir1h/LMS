import 'package:flutter/foundation.dart';
import 'question_type_data_model.dart';
import 'option_data_model.dart';

@immutable
class QuestionDataModel {
  final int id;
  final int circularCourseId;
  final int circularId;
  final int parentQuestionId;
  final int circularAssessmentId;
  final String question;
  final String questionImg;
  final String supportingNotesEn;
  final String explanation;
  final String supportingNotesBn;
  final String mark;
  final String negativeMark;
  final int createdBy;
  final QuestionTypeDataModel? questionType;
  final int typeId;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final List<OptionDataModel> options;

  const QuestionDataModel({
    required this.id,
    required this.circularCourseId,
    required this.circularId,
    required this.parentQuestionId,
    required this.circularAssessmentId,
    required this.question,
    required this.questionImg,
    required this.supportingNotesEn,
    required this.explanation,
    required this.supportingNotesBn,
    required this.mark,
    required this.negativeMark,
    required this.createdBy,
    required this.questionType,
    required this.typeId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.options,
  });

  factory QuestionDataModel.fromJson(Map<String, dynamic> json) =>
      QuestionDataModel(
        id: json["id"] ?? -1,
        circularCourseId: json["circular_course_id"] ?? -1,
        circularId: json["circular_id"] ?? -1,
        parentQuestionId: json["parent_question_id"] ?? -1,
        circularAssessmentId: json["circular_assessment_id"] ?? -1,
        question: json["question"] ?? "",
        questionImg: json["question_img"] ?? "",
        supportingNotesEn: json["supporting_notes_en"] ?? "",
        explanation: json["explanation"] ?? "",
        supportingNotesBn: json["supporting_notes_bn"] ?? "",
        mark: json["mark"] ?? -1,
        negativeMark: json["negative_mark"] ?? -1,
        createdBy: json["created_by"] ?? -1,
        questionType: json['question_type'] != null
            ? QuestionTypeDataModel.fromJson(json['question_type'])
            : null,
        typeId: json["type_id"] ?? -1,
        status: json["status"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
        options: json["options"] != null
            ? List<OptionDataModel>.from(
                (json["options"]).map((x) => OptionDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "circular_course_id": circularCourseId,
        "circular_id": circularId,
        "parent_question_id": parentQuestionId,
        "circular_assessment_id": circularAssessmentId,
        "question": question,
        "question_img": questionImg,
        "supporting_notes_en": supportingNotesEn,
        "explanation": explanation,
        "supporting_notes_bn": supportingNotesBn,
        "mark": mark,
        "negative_mark": negativeMark,
        "created_by": createdBy,
        "question_type": questionType?.toJson(),
        "type_id": typeId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
  static List<QuestionDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, QuestionDataModel>(
            json.map((x) => QuestionDataModel.fromJson(x)).toList())
        : [];
  }
}

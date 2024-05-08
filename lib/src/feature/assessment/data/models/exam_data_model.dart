import 'package:flutter/foundation.dart';
import 'assessment_data_model.dart';
import 'question_data_model.dart';

@immutable
class ExamDataModel {
  final int examResultId;
  final AssessmentDataModel? assessment;
  final List<QuestionDataModel> questions;

  const ExamDataModel({
    required this.examResultId,
    required this.assessment,
    required this.questions,
  });

  factory ExamDataModel.fromJson(Map<String, dynamic> json) => ExamDataModel(
        examResultId: json["exam_result_id"] ?? -1,
        assessment: json['assessment'] != null
            ? AssessmentDataModel.fromJson(json['assessment'])
            : null,
        questions: json["questions"] != null
            ? List<QuestionDataModel>.from(
                (json["questions"]).map((x) => QuestionDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "exam_result_id": examResultId,
        "assessment": assessment?.toJson(),
        "questions":
            List<QuestionDataModel>.from(questions.map((x) => x.toJson())),
      };
}

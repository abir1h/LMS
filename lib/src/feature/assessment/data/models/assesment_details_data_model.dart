import 'package:flutter/cupertino.dart';
import 'question_data_model.dart';

@immutable
class AssesmentDataModel {
  final int id;
  final int courseId;
  final int courseModuleId;
  final String assessmentTitleEn;
  final String assessmentTitleBn;
  final int totalMark;
  final int passMark;
  final int totalTime;
  final String tries;
  final int isHorizontal;
  final int isCertificationAssessment;
  final List<QuestionDataModel> questions;

  const AssesmentDataModel({
    required this.id,
    required this.courseId,
    required this.courseModuleId,
    required this.assessmentTitleEn,
    required this.assessmentTitleBn,
    required this.totalMark,
    required this.passMark,
    required this.totalTime,
    required this.tries,
    required this.isHorizontal,
    required this.isCertificationAssessment,
    required this.questions,
  });

  factory AssesmentDataModel.fromJson(Map<String, dynamic> json) =>
      AssesmentDataModel(
        id: json["id"] ?? -1,
        courseId: json["course_id"] ?? -1,
        courseModuleId: json["course_module_id"] ?? -1,
        assessmentTitleEn: json["assessment_title_en"] ?? "",
        assessmentTitleBn: json["assessment_title_bn"] ?? "",
        totalMark: json["total_mark"] ?? -1,
        passMark: json["pass_mark"] ?? -1,
        totalTime: json["total_time"] ?? -1,
        tries: json["tries"] ?? -1,
        isHorizontal: json["is_horizontal"] ?? -1,
        isCertificationAssessment: json["is_certification_assessment"] ?? false,
        questions: json["questions"] != null
            ? List<QuestionDataModel>.from(
                (json["questions"]).map((x) => QuestionDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "course_module_id": courseModuleId,
        "assessment_title_en": assessmentTitleEn,
        "assessment_title_bn": assessmentTitleBn,
        "total_mark": totalMark,
        "pass_mark": passMark,
        "total_time": totalTime,
        "tries": tries,
        "is_horizontal": isHorizontal,
        "is_certification_assessment": isCertificationAssessment,
        "questions": List<QuestionDataModel>.from(questions.map((x) => x.toJson())),
      };
}


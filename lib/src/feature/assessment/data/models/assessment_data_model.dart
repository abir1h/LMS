import 'package:flutter/foundation.dart';
import 'question_data_model.dart';

@immutable
class AssessmentDataModel {
  final int id;
  final int courseId;
  final int circularId;
  final int parentAssessmentId;
  final int courseModuleId;
  final String titleEn;
  final String titleBn;
  final int totalMark;
  final int passMark;
  final int negativeMark;
  final int totalTime;
  final int tries;
  final bool isCertificationAssessment;
  final bool isHorizontal;
  final bool status;
  final int createdBy;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final String assessmentInstruction;
  final String startDate;
  final String endDate;
  final int noOfQuestion;
  final List<QuestionDataModel> questions;

  const AssessmentDataModel({
    required this.id,
    required this.courseId,
    required this.circularId,
    required this.parentAssessmentId,
    required this.courseModuleId,
    required this.titleEn,
    required this.titleBn,
    required this.totalMark,
    required this.passMark,
    required this.negativeMark,
    required this.totalTime,
    required this.tries,
    required this.isCertificationAssessment,
    required this.isHorizontal,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.assessmentInstruction,
    required this.startDate,
    required this.endDate,
    required this.noOfQuestion,
    required this.questions,
  });

  factory AssessmentDataModel.fromJson(Map<String, dynamic> json) =>
      AssessmentDataModel(
        id: json["id"] ?? -1,
        courseId: json["course_id"] ?? -1,
        circularId: json["circular_id"] ?? -1,
        parentAssessmentId: json["parent_assessment_id"] ?? -1,
        courseModuleId: json["course_module_id"] ?? -1,
        titleEn: json["title_en"] ?? "",
        titleBn: json["title_bn"] ?? "",
        totalMark: json["total_mark"] ?? 0,
        passMark: json["pass_mark"] ?? 0,
        negativeMark: json["negative_mark"] ?? 0,
        totalTime: json["total_time"] ?? 0,
        tries: json["tries"] ?? 0,
        isCertificationAssessment: json["is_certification_assessment"] ?? false,
        isHorizontal: json["is_horizontal"] ?? false,
        status: json["status"] ?? false,
        createdBy: json["created_by"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
        assessmentInstruction: json["assessment_instruction"] ?? "",
        startDate: json["start_date"] ?? "",
        endDate: json["end_date"] ?? "",
        noOfQuestion: json["no_of_question"] ?? 0,
        questions: json["questions"] != null
            ? List<QuestionDataModel>.from(
                (json["questions"]).map((x) => QuestionDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "circular_id": circularId,
        "parent_assessment_id": parentAssessmentId,
        "course_module_id": courseModuleId,
        "title_en": titleEn,
        "title_bn": titleBn,
        "total_mark": totalMark,
        "pass_mark": passMark,
        "negative_mark": negativeMark,
        "total_time": totalTime,
        "tries": tries,
        "is_certification_assessment": isCertificationAssessment,
        "is_horizontal": isHorizontal,
        "status": status,
        "created_by": createdBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "assessment_instruction": assessmentInstruction,
        "start_date": startDate,
        "end_date": endDate,
        "no_of_question": noOfQuestion,
        "questions":
            List<QuestionDataModel>.from(questions.map((x) => x.toJson())),
      };
}

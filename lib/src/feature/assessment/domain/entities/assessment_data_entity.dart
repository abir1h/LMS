import 'question_data_entity.dart';

class AssessmentDataEntity {
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
  final List<QuestionDataEntity> questions;


  const AssessmentDataEntity({
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
    required this.questions,
  });
}

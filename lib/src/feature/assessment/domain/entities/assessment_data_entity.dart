import 'question_data_entity.dart';

class AssessmentDataEntity {
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
  final List<QuestionDataEntity> questions;

  const AssessmentDataEntity({
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
}

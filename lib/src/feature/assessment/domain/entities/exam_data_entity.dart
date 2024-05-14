import 'assessment_data_entity.dart';
import 'question_data_entity.dart';

class ExamDataEntity {
  final int examResultId;
  final AssessmentDataEntity? assessment;
  final List<QuestionDataEntity> questions;

  const ExamDataEntity(
      {required this.examResultId,
      required this.assessment,
      required this.questions});
}

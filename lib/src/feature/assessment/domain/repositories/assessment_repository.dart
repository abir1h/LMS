import '../../../shared/domain/entities/response_entity.dart';

abstract class AssessmentRepository {
  Future<ResponseEntity> getAssessmentDetails(int courseContentId);
  Future<ResponseEntity> getQuestionType();
  Future<ResponseEntity> startExam(int circularAssessmentId);
}

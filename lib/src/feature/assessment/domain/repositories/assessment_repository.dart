import '../../../shared/domain/entities/response_entity.dart';
import '../entities/exam_data_entity.dart';

abstract class AssessmentRepository {
  Future<ResponseEntity> getAssessmentDetails(int courseContentId);
  Future<ResponseEntity> getQuestionType();
  Future<ResponseEntity> startExam(int circularAssessmentId);
  Future<ResponseEntity> submitExam(ExamDataEntity examDataEntity);
  Future<ResponseEntity> requestExam(int circularAssessmentId, String remarks);
}

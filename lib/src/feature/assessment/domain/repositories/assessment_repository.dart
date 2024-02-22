import '../../../shared/domain/entities/response_entity.dart';

abstract class AssessmentRepository {
  Future<ResponseEntity> getAssessmentDetails(String assessmentId);
}

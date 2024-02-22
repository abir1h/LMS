import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/assessment_repository.dart';

class AssessmentUseCase {
  final AssessmentRepository _assessmentRepository;
  AssessmentUseCase({required AssessmentRepository assessmentRepository})
      : _assessmentRepository = assessmentRepository;

  Future<ResponseEntity> getAssessmentDetailsUseCase(
      int assessmentId) async {
    final response = _assessmentRepository.getAssessmentDetails(assessmentId);
    return response;
  }
}

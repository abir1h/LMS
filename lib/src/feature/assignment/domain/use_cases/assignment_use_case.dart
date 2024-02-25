import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/assignment_repository.dart';

class AssignmentUseCase {
  final AssignmentRepository _assignmentRepository;
  AssignmentUseCase({required AssignmentRepository assignmentRepository})
      : _assignmentRepository = assignmentRepository;

  Future<ResponseEntity> getAssessmentDetailsUseCase(int assignmentId) async {
    final response = _assignmentRepository.getAssignmentDetails(assignmentId);
    return response;
  }
}

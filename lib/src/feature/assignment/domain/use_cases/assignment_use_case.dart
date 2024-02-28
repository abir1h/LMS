import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/assignment_repository.dart';

class AssignmentUseCase {
  final AssignmentRepository _assignmentRepository;
  AssignmentUseCase({required AssignmentRepository assignmentRepository})
      : _assignmentRepository = assignmentRepository;

  Future<ResponseEntity> getAssignmentDetailsUseCase(
      int courseContentId) async {
    final response =
        _assignmentRepository.getAssignmentDetails(courseContentId);
    return response;
  }
}

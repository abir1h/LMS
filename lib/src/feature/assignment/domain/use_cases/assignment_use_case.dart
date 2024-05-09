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

  Future<ResponseEntity> storeAssignmentUseCase(
      int assignmentId,
      int subAssignmentId,
      int courseId,
      int circularId,
      String answer,
      String filePath) async {
    final response = _assignmentRepository.storeAssignment(
        assignmentId, subAssignmentId, courseId, circularId, answer, filePath);
    return response;
  }

  Future<ResponseEntity> updateAssignmentUseCase(
      int assignmentId,
      int subAssignmentId,
      int courseId,
      int circularId,
      String answer,
      String filePath) async {
    final response = _assignmentRepository.updateAssignment(
        assignmentId, subAssignmentId, courseId, circularId, answer, filePath);
    return response;
  }
}

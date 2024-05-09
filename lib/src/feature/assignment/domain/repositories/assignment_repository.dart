import '../../../shared/domain/entities/response_entity.dart';

abstract class AssignmentRepository {
  Future<ResponseEntity> getAssignmentDetails(int courseContentId);
  Future<ResponseEntity> storeAssignment(int assignmentId, int subAssignmentId,
      int courseId, int circularId, String answer, String filePath);
  Future<ResponseEntity> updateAssignment(int assignmentId, int subAssignmentId,
      int courseId, int circularId, String answer, String filePath);
}

import '../../../shared/domain/entities/response_entity.dart';

abstract class AssignmentRepository {
  Future<ResponseEntity> getAssignmentDetails(int assignmentId);
}

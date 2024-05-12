import 'dart:io';

import '../../../shared/domain/entities/response_entity.dart';

abstract class AssignmentRepository {
  Future<ResponseEntity> getAssignmentDetails(int courseContentId);
  Future<ResponseEntity> storeAssignment(int assignmentId, int subAssignmentId,
      int courseId, int circularId, String answer, List<File> files);
  Future<ResponseEntity> updateAssignment(
      int submissionId,
      int assignmentId,
      int subAssignmentId,
      int courseId,
      int circularId,
      String answer,
      List<File> files);
}

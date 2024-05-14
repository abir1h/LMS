import 'dart:io';

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
      List<File> files) async {
    final response = _assignmentRepository.storeAssignment(
        assignmentId, subAssignmentId, courseId, circularId, answer, files);
    return response;
  }

  Future<ResponseEntity> updateAssignmentUseCase(
      int submissionId,
      int assignmentId,
      int subAssignmentId,
      int courseId,
      int circularId,
      String answer,
      List<File> files) async {
    final response = _assignmentRepository.updateAssignment(submissionId,
        assignmentId, subAssignmentId, courseId, circularId, answer, files);
    return response;
  }  Future<ResponseEntity> requestAssignmentUseCase(
      int circularId,
      int courseId,
      int circularAssignmentId,
      int courseModuleId,
      String message,) async {
    final response = _assignmentRepository.requestAssignment(circularId,
        courseId, circularAssignmentId, courseModuleId, message);
    return response;
  }
}

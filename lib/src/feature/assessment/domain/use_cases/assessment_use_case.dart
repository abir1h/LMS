import 'package:lms/src/feature/assessment/domain/entities/exam_data_entity.dart';

import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/assessment_repository.dart';

class AssessmentUseCase {
  final AssessmentRepository _assessmentRepository;
  AssessmentUseCase({required AssessmentRepository assessmentRepository})
      : _assessmentRepository = assessmentRepository;

  Future<ResponseEntity> getAssessmentDetailsUseCase(
      int courseContentId) async {
    final response =
        _assessmentRepository.getAssessmentDetails(courseContentId);
    return response;
  }

  Future<ResponseEntity> getQuestionTypeUseCase() async {
    final response = _assessmentRepository.getQuestionType();
    return response;
  }

  Future<ResponseEntity> startExamUseCase(int circularAssessmentId) async {
    final response = _assessmentRepository.startExam(circularAssessmentId);
    return response;
  }

  Future<ResponseEntity> submitExamUseCase(
      ExamDataEntity examDataEntity) async {
    final response = _assessmentRepository.submitExam(examDataEntity);
    return response;
  }

  Future<ResponseEntity> requestExamUseCase(
      int circularAssessmentId, String remarks) async {
    final response =
        _assessmentRepository.requestExam(circularAssessmentId, remarks);
    return response;
  }
}

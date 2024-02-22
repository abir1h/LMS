import '../../data/data_sources/remote/assessment_data_source.dart';
import '../../data/repositories/assessment_repository_imp.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/use_cases/assessment_use_case.dart';

mixin class AssessmentService {
  AssessmentService._();

  final AssessmentUseCase _assessmentUseCase = AssessmentUseCase(
      assessmentRepository: AssessmentRepositoryImp(
          assessmentRemoteDataSource: AssessmentRemoteDataSourceImp()));

  Future<ResponseEntity> getAssessmentDetails(int assessmentId) async {
    ResponseEntity responseEntity =
        await _assessmentUseCase.getAssessmentDetailsUseCase(assessmentId);
    return responseEntity;
  }
}

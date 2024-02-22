import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../shared/data/models/response_model.dart';
import '../../domain/repositories/assessment_repository.dart';
import '../data_sources/remote/assessment_data_source.dart';

class AssessmentRepositoryImp extends AssessmentRepository {
  final AssessmentRemoteDataSource assessmentRemoteDataSource;
  AssessmentRepositoryImp({required this.assessmentRemoteDataSource});

  @override
  Future<ResponseEntity> getAssessmentDetails(String assessmentId) async{
    // ResponseModel responseModel =
    // (await assessmentRemoteDataSource.getAssessmentDetailsAction(assessmentId));
    // return ResponseModelToEntityMapper<AssessmentDataEntity, AssessmentDataModel>()
    //     .toEntityFromModel(
    // responseModel, (AssessmentDataModel model) => model.toAssessmentDataEntity);
    throw UnimplementedError();
  }

}

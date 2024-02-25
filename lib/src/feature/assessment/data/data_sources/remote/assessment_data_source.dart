import '../../models/assessment_data_model.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';

abstract class AssessmentRemoteDataSource {
  Future<ResponseModel> getAssessmentDetailsAction(int assessmentId);
}

class AssessmentRemoteDataSourceImp extends AssessmentRemoteDataSource {
  @override
  Future<ResponseModel> getAssessmentDetailsAction(int assessmentId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getAssessment}/$assessmentId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AssessmentDataModel.fromJson(json));
    return responseModel;
  }
}
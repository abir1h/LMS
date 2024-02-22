import '../../../../shared/data/models/response_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';

abstract class AssessmentRemoteDataSource {
  Future<ResponseModel> getAssessmentDetailsAction(String assessmentId);
}

class AssessmentRemoteDataSourceImp extends AssessmentRemoteDataSource {

  @override
  Future<ResponseModel> getAssessmentDetailsAction(String assessmentId) async{
    // final responseJson = await Server.instance.getRequestForAuth(
    //     url: "${ApiCredential.getToken}?username=$username&token=$eMISToken");
    // ResponseModel responseModel = ResponseModel.fromJson(
    //     responseJson, (dynamic json) => AuthDataModel.fromJson(json));
    // return responseModel;
    throw UnimplementedError();
  }

}

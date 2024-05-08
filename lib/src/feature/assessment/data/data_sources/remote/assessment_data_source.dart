import '../../models/question_type_data_model.dart';
import '../../models/assessment_data_model.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';

abstract class AssessmentRemoteDataSource {
  Future<ResponseModel> getAssessmentDetailsAction(int courseContentId);
  Future<ResponseModel> getQuestionTypeAction();
}

class AssessmentRemoteDataSourceImp extends AssessmentRemoteDataSource {
  @override
  Future<ResponseModel> getAssessmentDetailsAction(int courseContentId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getAssessment}/$courseContentId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AssessmentDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getQuestionTypeAction() async{
    final responseJson = await Server.instance
        .getRequest(url: ApiCredential.getAssessmentQuestionType);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => QuestionTypeDataModel.listFromJson(json));
    return responseModel;
  }
}

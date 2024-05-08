import '../../models/exam_data_model.dart';
import '../../models/question_type_data_model.dart';
import '../../models/assessment_data_model.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';

abstract class AssessmentRemoteDataSource {
  Future<ResponseModel> getAssessmentDetailsAction(int courseContentId);
  Future<ResponseModel> getQuestionTypeAction();
  Future<ResponseModel> startExamAction(int circularAssessmentId);
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
  Future<ResponseModel> getQuestionTypeAction() async {
    final responseJson = await Server.instance
        .getRequest(url: ApiCredential.getAssessmentQuestionType);
    ResponseModel responseModel = ResponseModel.fromJson(responseJson,
        (dynamic json) => QuestionTypeDataModel.listFromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> startExamAction(int circularAssessmentId) async {
    Map<String, dynamic> data = {
      "circular_assessment_id": circularAssessmentId,
    };
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.startExam, postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => ExamDataModel.fromJson(json));
    return responseModel;
  }
}

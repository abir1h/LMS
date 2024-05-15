import 'dart:developer';

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
  Future<ResponseModel> submitExamAction(ExamDataModel examDataModel);
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

  // @override
  // Future<ResponseModel> submitExamAction(ExamDataModel examDataModel) async {
  //   Map<String, dynamic> data = examDataModel.toJson();
  //   data["submission_type"] = "Manual";
  //   data["assessment_id"] = examDataModel.assessment!.id;
  //   final responseJson = await Server.instance
  //       .postRequest(url: ApiCredential.submitExam, postData: data);
  //   ResponseModel responseModel = ResponseModel.fromJson(
  //       responseJson, (dynamic json) => ExamDataModel.fromJson(json));
  //   return responseModel;
  // }

  @override
  Future<ResponseModel> submitExamAction(ExamDataModel examDataModel) async {
    Map<String, dynamic> data = {
      "exam_result_id": examDataModel.examResultId,
      "submission_type": "Manual",
      "assessment_id": examDataModel.assessment!.id,
      "questions": examDataModel.assessment?.questions
          .map((e) => e.questionType!.id != 6
              ? {
                  "question_id": e.id,
                  "type_id": e.questionType!.id,
                  "options": e.options
                      .map((v) =>
                          e.questionType!.id == 2 || e.questionType!.id == 5
                              ? {
                                  "option_id": v.id,
                                  "user_correct_value": v.userCorrectValue,
                                }
                              : e.questionType!.id == 3
                                  ? {
                                      "option_id": v.id,
                                      "user_correct_input": v.userCorrectInput,
                                    }
                                  : e.questionType!.id == 4
                                      ? {
                                          "option_id": v.id,
                                          "user_input": v.userInput,
                                        }
                                      : {
                                          "option_id": v.id,
                                          "user_input": v.userInput,
                                        })
                      .toList()
                }
              : {
                  "question_id": e.id,
                  "type_id": e.questionType!.id,
                  "user_input": e.userInput,
                })
          .toList()
    };
    log(data.toString());
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.submitExam, postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => ExamDataModel.fromJson(json));
    return responseModel;
  }
}

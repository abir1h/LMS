import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/assignment_data_model.dart';

abstract class AssignmentRemoteDataSource {
  Future<ResponseModel> getAssignmentDetailsAction(int courseContentId);
  Future<ResponseModel> storeAssignmentAction(
      int assignmentId,
      int subAssignmentId,
      int courseId,
      int circularId,
      String answer,
      String filePath);
  Future<ResponseModel> updateAssignmentAction(
      int assignmentId,
      int subAssignmentId,
      int courseId,
      int circularId,
      String answer,
      String filePath);
}

class AssignmentRemoteDataSourceImp extends AssignmentRemoteDataSource {
  @override
  Future<ResponseModel> getAssignmentDetailsAction(int courseContentId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getAssignment}/$courseContentId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AssignmentDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> storeAssignmentAction(
      int assignmentId,
      int subAssignmentId,
      int courseId,
      int circularId,
      String answer,
      String filePath) async {
    Map<String, dynamic> data = {
      "circular_assignment_id": assignmentId,
      "circular_sub_assignment_id": subAssignmentId,
      "course_id": courseId,
      "circular_id": circularId,
      "answer": answer,
      "file[]": filePath,
    };
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.createAssignment, postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AssignmentDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> updateAssignmentAction(
      int assignmentId,
      int subAssignmentId,
      int courseId,
      int circularId,
      String answer,
      String filePath) async {
    Map<String, dynamic> data = {
      "circular_assignment_id": assignmentId,
      "circular_sub_assignment_id": subAssignmentId,
      "course_id": courseId,
      "circular_id": circularId,
      "answer": answer,
      "file[]": filePath,
    };
    final responseJson = await Server.instance.postRequest(
        url: "${ApiCredential.createAssignment}/$assignmentId", postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AssignmentDataModel.fromJson(json));
    return responseModel;
  }
}

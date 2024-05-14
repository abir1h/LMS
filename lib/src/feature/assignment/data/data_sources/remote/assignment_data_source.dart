import 'dart:convert';
import 'dart:io';

import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/assignment_data_model.dart';
import '../../models/assignment_request_model.dart';

abstract class AssignmentRemoteDataSource {
  Future<ResponseModel> getAssignmentDetailsAction(int courseContentId);
  Future<ResponseModel> storeAssignmentAction(
      int assignmentId,
      int subAssignmentId,
      int courseId,
      int circularId,
      String answer,
      List<File> files);
  Future<ResponseModel> updateAssignmentAction(
      int submissionId,
      int assignmentId,
      int subAssignmentId,
      int courseId,
      int circularId,
      String answer,
      List<File> files);
  Future<ResponseModel> requestAssignmentAction(
    int circularId,
    int courseId,
    int circularAssignmentId,
    int courseModuleId,
    String message,
  );
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

  // @override
  // Future<ResponseModel> storeAssignmentAction(
  //     int assignmentId,
  //     int subAssignmentId,
  //     int courseId,
  //     int circularId,
  //     String answer,
  //     List<File> files) async {
  //   Map<String, dynamic> data = {
  //     "circular_assignment_id": assignmentId,
  //     "circular_sub_assignment_id": subAssignmentId,
  //     "course_id": courseId,
  //     "circular_id": circularId,
  //     "answer": answer,
  //     "file[]": files,
  //   };
  //   final responseJson = await Server.instance
  //       .postRequest(url: ApiCredential.createAssignment, postData: data);
  //   ResponseModel responseModel = ResponseModel.fromJson(
  //       responseJson, (dynamic json) => AssignmentDataModel.fromJson(json));
  //   return responseModel;
  // }

  @override
  Future<ResponseModel> storeAssignmentAction(
      int assignmentId,
      int subAssignmentId,
      int courseId,
      int circularId,
      String answer,
      List<File> files) async {
    Map<String, String> data = {
      "circular_assignment_id": json.encode(assignmentId),
      "circular_sub_assignment_id": json.encode(subAssignmentId),
      "course_id": json.encode(courseId),
      "circular_id": json.encode(circularId),
      "answer": answer,
    };
    final responseJson = await Server.instance.postRequestWithFile(
        url: ApiCredential.createAssignment, postData: data, files: files);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AssignmentDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> updateAssignmentAction(
      int submissionId,
      int assignmentId,
      int subAssignmentId,
      int courseId,
      int circularId,
      String answer,
      List<File> files) async {
    Map<String, String> data = {
      "circular_assignment_id": json.encode(assignmentId),
      "circular_sub_assignment_id": json.encode(subAssignmentId),
      "course_id": json.encode(courseId),
      "circular_id": json.encode(circularId),
      "answer": "answer",
    };
    data["_method"] = "PUT";
    final responseJson = await Server.instance.postRequestWithFile(
        url: "${ApiCredential.createAssignment}/$submissionId",
        postData: data,
        files: files);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AssignmentDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> requestAssignmentAction(int circularId, int courseId,
      int circularAssignmentId, int courseModuleId, String message) async {
    Map<String, String> data = {
      "circular_id": circularId.toString(),
      "course_id": courseId.toString(),
      "circular_assignment_id": circularAssignmentId.toString(),
      "course_module_id": courseModuleId.toString(),
      "message": message,
    };
    final responseJson = await Server.instance.postRequest(
      url: ApiCredential.requestAssignment,
      postData: data,
    );
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AssignmentRequestModel.fromJson(json));
    return responseModel;
  }
}

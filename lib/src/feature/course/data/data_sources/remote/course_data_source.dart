import '../../models/blended_class_data_model.dart';
import '../../models/course_details_data_model.dart';
import '../../models/all_course_data_model.dart';
import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/script_data_model.dart';
import '../../models/video_data_model.dart';

abstract class CourseRemoteDataSource {
  Future<ResponseModel> getCoursesAction(String courseStatus);
  Future<ResponseModel> getCourseDetailsAction(int courseId);
  Future<ResponseModel> getScriptDetailsAction(int courseContentId);
  Future<ResponseModel> getBlendedClassAction(int courseContentId);
  Future<ResponseModel> getVideoDetailsAction(int courseContentId);
}

class CourseRemoteDataSourceImp extends CourseRemoteDataSource {
  @override
  Future<ResponseModel> getCoursesAction(String courseStatus) async {
    final responseJson = await Server.instance.getRequest(
        url: "${ApiCredential.getCourse}?circular_status=$courseStatus");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AllCourseDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getCourseDetailsAction(int courseId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getCourse}/$courseId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => CourseDetailsDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getScriptDetailsAction(int courseContentId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getScript}/$courseContentId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => ScriptDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getBlendedClassAction(int courseContentId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getBlendedClass}/$courseContentId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BlendedClassDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getVideoDetailsAction(int courseContentId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getVideo}/$courseContentId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => VideoDataModel.fromJson(json));
    return responseModel;
  }
}

import '../../models/course_details_data_model.dart';
import '../../models/all_course_data_model.dart';
import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class CourseRemoteDataSource {
  Future<ResponseModel> getCoursesAction();
  Future<ResponseModel> getCourseDetailsAction(int courseId);
}

class CourseRemoteDataSourceImp extends CourseRemoteDataSource {
  @override
  Future<ResponseModel> getCoursesAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.getCourse);
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
}

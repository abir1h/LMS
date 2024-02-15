
import '../../../../shared/data/models/response_model.dart';

abstract class CourseRemoteDataSource {
  Future<ResponseModel> getCoursesAction();
}

class CourseRemoteDataSourceImp extends CourseRemoteDataSource {
  // @override
  // Future<ResponseModel> getAuthorsAction() async {
  //   final responseJson =
  //   await Server.instance.getRequest(url: ApiCredential.getAuthors);
  //   ResponseModel responseModel = ResponseModel.fromJson(responseJson,
  //           (dynamic json) => PaginatedAuthorDataModel.fromJson(json));
  //   return responseModel;
  // }
  //
  // @override
  // Future<ResponseModel> getBookByAuthorsAction(int authorId) async {
  //   final responseJson = await Server.instance
  //       .getRequest(url: "${ApiCredential.getBookByAuthors}/$authorId");
  //   ResponseModel responseModel = ResponseModel.fromJson(
  //       responseJson, (dynamic json) => BookDataModel.listFromJson(json));
  //   return responseModel;
  // }

  @override
  Future<ResponseModel> getCoursesAction() {
    throw UnimplementedError();
  }
}

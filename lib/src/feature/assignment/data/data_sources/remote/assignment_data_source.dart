import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/assignment_data_model.dart';

abstract class AssignmentRemoteDataSource {
  Future<ResponseModel> getAssignmentDetailsAction(int courseContentId);
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
}

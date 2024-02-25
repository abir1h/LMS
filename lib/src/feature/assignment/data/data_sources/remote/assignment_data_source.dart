import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/assignment_data_model.dart';

abstract class AssignmentRemoteDataSource {
  Future<ResponseModel> getAssignmentDetailsAction(int assignmentId);
}

class AssessmentRemoteDataSourceImp extends AssignmentRemoteDataSource {
  @override
  Future<ResponseModel> getAssignmentDetailsAction(int assignmentId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getAssignment}/$assignmentId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AssignmentDataModel.fromJson(json));
    return responseModel;
  }
}

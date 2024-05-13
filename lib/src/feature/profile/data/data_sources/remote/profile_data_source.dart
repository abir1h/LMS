import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/all_progress_data_model.dart';
import '../../models/profile_data_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ResponseModel> userProfileInformationAction();
  Future<ResponseModel> getUserProfileInformationAction();
}

class ProfileRemoteDataSourceImp extends ProfileRemoteDataSource {
  @override
  Future<ResponseModel> userProfileInformationAction() async {
    final responseJson =
        await Server.instance.getRequestForAuth(url: ApiCredential.userProfile);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => ProfileDataModel.fromJson(json));
    return responseModel;
  }

  Future<ResponseModel> getUserProfileInformationAction() async {
    String url = "${ApiCredential.getProfile}";

    final responseJson = await Server.instance.getRequest(url: url);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AllProgressDataModel.fromJson(json));

    return responseModel;
  }
}

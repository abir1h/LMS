import '../../models/certificate_data_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/all_progress_data_model.dart';
import '../../models/profile_data_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ResponseModel> getUserProfileInformationAction();
  Future<ResponseModel> getCertificateAction();
}

class ProfileRemoteDataSourceImp extends ProfileRemoteDataSource {

  @override
  Future<ResponseModel> getUserProfileInformationAction() async {
    String url = ApiCredential.getProfile;

    final responseJson = await Server.instance.getRequest(url: url);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AllProgressDataModel.fromJson(json));

    return responseModel;
  }

  @override
  Future<ResponseModel> getCertificateAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.getCertificate);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => CertificateDataModel.fromJson(json));
    return responseModel;
  }
}

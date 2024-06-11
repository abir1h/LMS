import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class NotificationRemoteDataSource {
  Future<ResponseModel> updateFCMTokenAction(String token);
  Future<ResponseModel> updateUserFCMTokenAction(
      String eMISUserId, String token);
}

class NotificationRemoteDataSourceImp extends NotificationRemoteDataSource {
  @override
  Future<ResponseModel> updateFCMTokenAction(String token) async {
    Map<String, dynamic> data = {
      "token": token,
    };
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.fcmUpdate, postData: data);
    ResponseModel responseModel =
        ResponseModel.fromJson(responseJson, (dynamic json) => null);
    return responseModel;
  }

  @override
  Future<ResponseModel> updateUserFCMTokenAction(
      String eMISUserId, String token) async {
    Map<String, dynamic> data = {
      "fcm_id": token,
    };
    final responseJson = await Server.instance.putRequest(
        url: "${ApiCredential.fcmUpdateUser}/$eMISUserId", postData: data);
    ResponseModel responseModel =
        ResponseModel.fromJson(responseJson, (dynamic json) => null);
    return responseModel;
  }
}

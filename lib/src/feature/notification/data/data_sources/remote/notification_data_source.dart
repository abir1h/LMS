import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class NotificationRemoteDataSource {
  Future<ResponseModel> updateFCMToken(String token);
}

class NotificationRemoteDataSourceImp extends NotificationRemoteDataSource {
  @override
  Future<ResponseModel> updateFCMToken(String token) async {
    Map<String, dynamic> data = {
      "token": token,
    };
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.fcmUpdate, postData: data);
    ResponseModel responseModel =
        ResponseModel.fromJson(responseJson, (dynamic json) => null);
    return responseModel;
  }
}

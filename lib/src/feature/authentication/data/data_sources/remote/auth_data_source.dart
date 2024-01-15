import 'dart:convert';

import '../../../../shared/data/models/response_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../models/auth_data_model.dart';

abstract class AuthRemoteDataSource {
  Future<ResponseModel> getTokenAction(String username, String eMISToken);
  Future<ResponseModel> getEMISLinkAction();
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  @override
  Future<ResponseModel> getTokenAction(
      String username, String eMISToken) async {
    final responseJson = await ApiService().getRequest(
        "${ApiCredential.getToken}?username=$username&token=$eMISToken");
    ResponseModel responseModel = ResponseModel.fromJson(
        json.decode(responseJson),
        (dynamic json) => AuthDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getEMISLinkAction() async {
    final responseJson =
        await ApiService().getRequest(ApiCredential.getEMISLink);
    ResponseModel responseModel = ResponseModel.fromJson(
        json.decode(responseJson),
        (dynamic json) => AuthDataModel.fromJson(json));
    return responseModel;
  }
}

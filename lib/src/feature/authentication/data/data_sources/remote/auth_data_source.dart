import 'dart:convert';

import '../../models/auth_response_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> userLoginAction(String pdsID, String password);
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  @override
  Future<AuthResponseModel> userLoginAction(
      String pdsID, String password) async {
    Map userData = {"pdsid": pdsID, "password": password};
    final responseJson =
        await ApiService().postRequest(ApiCredential.userLogin, userData);
    AuthResponseModel authResponseModel =
        AuthResponseModel.fromJson(json.decode(responseJson));
    return authResponseModel;
  }
}

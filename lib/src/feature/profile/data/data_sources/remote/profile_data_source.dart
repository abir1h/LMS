import 'dart:convert';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../models/profile_response_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileResponseModel> userProfileInformationAction();
}

class ProfileRemoteDataSourceImp extends ProfileRemoteDataSource {
  @override
  Future<ProfileResponseModel> userProfileInformationAction() async {
    Map dataMap = {
      "data": {
        "name": "John Doe",
        "email": "john.doe@example.com",
        "pdsid": "ABC123",
        "designation": "Manager",
        "subject": "Science",
        "institution": "Example University",
        "mobile": "+1234567890",
        "zila": "Example City",
        "type": "Regular"
      },
      "message": "string"
    };
    // final responseJson =
    //     await ApiService().getRequest(ApiCredential.userProfile);
    // ProfileResponseModel profileResponseModel =
    //     ProfileResponseModel.fromJson(json.decode(responseJson));

    ProfileResponseModel profileResponseModel =
    ProfileResponseModel.fromJson(json.decode(jsonEncode(dataMap)));

    return profileResponseModel;
  }
}

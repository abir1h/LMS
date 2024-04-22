import 'dart:convert';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/dashboard_data_model.dart';
import '../../models/dashboard_response_model.dart';

abstract class DashboardRemoteDataSource {
  // Future<DashboardResponseModel> userDashboardAction();
  Future<ResponseModel> userDashboardAction();
}

class DashboardRemoteDataSourceImp extends DashboardRemoteDataSource {
  @override
  Future<ResponseModel> userDashboardAction() async {
    // Map data = {
    //   "data": {
    //     "currentModule": {
    //       "course_title": "string",
    //       "course_title_bn": "string",
    //       "completion": "string"
    //     },
    //     "curriculam": {
    //       "ongoing": 0,
    //       "completed": 0
    //     },
    //     "discussions": 0,
    //     "notices_count": 0,
    //     "activity_duration": {
    //       "x": [0, 1, 2],
    //       "y": [0, 3, 4]
    //     },
    //     "noticeboard": [
    //       "Notice"
    //     ]
    //   },
    //   "message": "string"
    // };
    //
    // // final responseJson =
    // //     await ApiService().getRequest(ApiCredential.userDashboard);
    // // DashboardResponseModel dashboardResponseModel =
    // //     DashboardResponseModel.fromJson(json.decode(responseJson));
    //
    // DashboardResponseModel dashboardResponseModel =
    // DashboardResponseModel.fromJson(json.decode(jsonEncode(data)));
    // return dashboardResponseModel;

    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.userDashboard);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DashboardDataModel.fromJson(json));
    return responseModel;
  }
}

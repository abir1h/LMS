import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/all_circular_data_model.dart';
import '../../models/circular_details_data_model.dart';

abstract class CircularRemoteDataSource {
  Future<ResponseModel> getCircularsAction();
  Future<ResponseModel> getCircularDetailsAction(int circularId);
}

class CircularRemoteDataSourceImp extends CircularRemoteDataSource {
  @override
  Future<ResponseModel> getCircularsAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.getCircular);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AllCircularDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getCircularDetailsAction(int circularId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getCircular}/$circularId");
    ResponseModel responseModel = ResponseModel.fromJson(responseJson,
        (dynamic json) => CircularDetailsDataModel.fromJson(json));
    return responseModel;
  }
}

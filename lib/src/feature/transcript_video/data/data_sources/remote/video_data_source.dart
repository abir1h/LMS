import '../../../../course/data/models/video_activity_data_model.dart';
import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class VideoRemoteDataSource {
  Future<ResponseModel> videoActivityAction(
      int circularVideoId, int lastWatchTime, List<int> questionSeenList);
}

class VideoRemoteDataSourceImp extends VideoRemoteDataSource {
  @override
  Future<ResponseModel> videoActivityAction(int circularVideoId,
      int lastWatchTime, List<int> questionSeenList) async {
    Map<String, dynamic> data = {
      "circular_video_id": circularVideoId,
      "last_view_time": lastWatchTime,
      "questions_seen": questionSeenList,
    };
    final responseJson = await Server.instance.postRequest(
      url: ApiCredential.videoActivity,
      postData: data,
    );
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => VideoActivityDataModel.fromJson(json));
    return responseModel;
  }
}

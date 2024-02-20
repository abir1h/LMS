import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/discussion_comments_data_model.dart';
import '../../models/discussion_data_model.dart';

abstract class DiscussionRemoteDataSource {
  Future<ResponseModel> getDiscussionsAction();
  Future<ResponseModel> getDiscussionDetailsAction(int discussionId);
  Future<ResponseModel> getDiscussionCommentsAction(int discussionId);
}

class DiscussionRemoteDataSourceImp extends DiscussionRemoteDataSource {
  @override
  Future<ResponseModel> getDiscussionsAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.getDiscussion);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DiscussionDataModel.listFromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getDiscussionDetailsAction(int discussionId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getDiscussion}/$discussionId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DiscussionDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getDiscussionCommentsAction(int discussionId) async {
    final responseJson = await Server.instance.getRequest(
        url: "${ApiCredential.getDiscussionComments}/$discussionId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DiscussionCommentsDataModel.fromJson(json));
    return responseModel;
  }
}

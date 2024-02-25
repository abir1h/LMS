import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/comment_data_model.dart';
import '../../models/discussion_comments_data_model.dart';
import '../../models/discussion_data_model.dart';

abstract class DiscussionRemoteDataSource {
  Future<ResponseModel> getDiscussionsByContentAction(
      int contentId, String contentType);
  Future<ResponseModel> getDiscussionDetailsAction(int discussionId);
  Future<ResponseModel> createDiscussionAction(
      DiscussionDataModel discussionDataModel);
  Future<ResponseModel> updateDiscussionAction(
      DiscussionDataModel discussionDataModel);
  Future<ResponseModel> deleteDiscussionAction(int discussionId);
  Future<ResponseModel> getDiscussionCommentsAction(int discussionId);
  Future<ResponseModel> createCommentAction(CommentDataModel commentDataModel);
  Future<ResponseModel> updateCommentAction(CommentDataModel commentDataModel);
}

class DiscussionRemoteDataSourceImp extends DiscussionRemoteDataSource {
  @override
  Future<ResponseModel> getDiscussionsByContentAction(
      int contentId, String contentType) async {
    final responseJson = await Server.instance.getRequest(
        url:
            "${ApiCredential.getDiscussion}?content_id=$contentId&content_type=$contentType");
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
  Future<ResponseModel> createDiscussionAction(
      DiscussionDataModel discussionDataModel) async {
    final responseJson = await Server.instance.postRequest(
        url: ApiCredential.getDiscussion,
        postData: discussionDataModel.toJson());
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DiscussionDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> updateDiscussionAction(
      DiscussionDataModel discussionDataModel) async {
    Map<String, dynamic> data = discussionDataModel.toJson();
    data["_method"] = "PUT";
    final responseJson = await Server.instance.postRequest(
        url: "${ApiCredential.getDiscussion}/${discussionDataModel.id}",
        postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DiscussionDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> deleteDiscussionAction(int discussionId) async {
    final responseJson = await Server.instance
        .deleteRequest(url: "${ApiCredential.getDiscussion}/$discussionId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DiscussionDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getDiscussionCommentsAction(int discussionId) async {
    final responseJson = await Server.instance.getRequest(
        url: "${ApiCredential.getDiscussionComments}/$discussionId");
    ResponseModel responseModel = ResponseModel.fromJson(responseJson,
        (dynamic json) => DiscussionCommentsDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> createCommentAction(
      CommentDataModel commentDataModel) async {
    final responseJson = await Server.instance.postRequest(
        url: ApiCredential.getComments, postData: commentDataModel.toJson());
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => CommentDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> updateCommentAction(
      CommentDataModel commentDataModel) async {
    Map<String, dynamic> data = commentDataModel.toJson();
    data["_method"] = "PUT";
    final responseJson = await Server.instance.postRequest(
        url: "${ApiCredential.getComments}/${commentDataModel.id}",
        postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => CommentDataModel.fromJson(json));
    return responseModel;
  }
}

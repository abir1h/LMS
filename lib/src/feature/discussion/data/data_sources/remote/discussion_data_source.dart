import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/comment_data_model.dart';
import '../../models/discussion_comments_data_model.dart';
import '../../models/discussion_data_model.dart';

abstract class DiscussionRemoteDataSource {
  Future<ResponseModel> getDiscussionsByContentAction(
      int courseId, int courseModuleId, int contentId, String contentType);
  Future<ResponseModel> getDiscussionDetailsAction(int discussionId);
  Future<ResponseModel> createDiscussionAction(int courseId, int courseModuleId,
      int contentId, String contentType, String description);
  Future<ResponseModel> updateDiscussionAction(
      DiscussionDataModel discussionDataModel);
  Future<ResponseModel> deleteDiscussionAction(int discussionId);
  Future<ResponseModel> getDiscussionCommentsAction(int discussionId);
  Future<ResponseModel> createCommentAction(
      int discussionId, String description);
  Future<ResponseModel> updateCommentAction(CommentDataModel commentDataModel);
}

class DiscussionRemoteDataSourceImp extends DiscussionRemoteDataSource {
  @override
  Future<ResponseModel> getDiscussionsByContentAction(int courseId,
      int courseModuleId, int contentId, String contentType) async {
    final responseJson = await Server.instance.getRequest(
        url:
            "${ApiCredential.getDiscussion}?course_id=$courseId&course_module_id=$courseModuleId&content_id=$contentId&content_type=$contentType");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DiscussionDataModel.listFromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getDiscussionDetailsAction(int discussionId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getDiscussionDetails}/$discussionId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DiscussionDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> createDiscussionAction(int courseId, int courseModuleId,
      int contentId, String contentType, String description) async {
    Map<String, dynamic> data = {
      "course_id": courseId,
      "course_module_id": courseModuleId,
      "content_id": contentId,
      "content_type": contentType,
      "description": description,
    };
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.createDiscussion, postData: data);
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
      int discussionId, String description) async {
    Map<String, dynamic> data = {
      "discussion_id": discussionId,
      "description": description,
    };
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.createComment, postData: data);
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
        url: "${ApiCredential.createComment}/${commentDataModel.id}",
        postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => CommentDataModel.fromJson(json));
    return responseModel;
  }
}

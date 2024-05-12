import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/comment_data_model.dart';
import '../../models/discussion_comments_data_model.dart';
import '../../models/discussion_data_model.dart';

abstract class DiscussionRemoteDataSource {
  Future<ResponseModel> getDiscussionsAction(int courseId);
  Future<ResponseModel> getDiscussionsByContentAction(
      int courseId, int courseModuleId, int contentId, String contentType);
  Future<ResponseModel> getDiscussionDetailsAction(int discussionId);
  Future<ResponseModel> createDiscussionAction(int courseId, int courseModuleId,
      int contentId, String contentType, String description);
  Future<ResponseModel> updateDiscussionAction(
      int discussionId, String description);
  Future<ResponseModel> deleteDiscussionAction(int discussionId);
  Future<ResponseModel> voteDiscussionAction(int discussionId);
  Future<ResponseModel> reportDiscussionAction(
      int discussionId, String remarks);
  Future<ResponseModel> getDiscussionCommentsAction(int discussionId);
  Future<ResponseModel> createCommentAction(
      int discussionId, String description);
  Future<ResponseModel> updateCommentAction(int commentId, String description);
  Future<ResponseModel> deleteCommentAction(int commentId);
  Future<ResponseModel> voteCommentAction(int commentId);
  Future<ResponseModel> reportCommentAction(int commentId, String remarks);
}

class DiscussionRemoteDataSourceImp extends DiscussionRemoteDataSource {
  @override
  Future<ResponseModel> getDiscussionsAction(int courseId) async {
    final responseJson = await Server.instance.getRequest(
        url: "${ApiCredential.getAllDiscussion}?course_id=$courseId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DiscussionDataModel.listFromJson(json));
    return responseModel;
  }

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
        .getRequest(url: "${ApiCredential.discussion}/$discussionId");
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
        .postRequest(url: ApiCredential.discussion, postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DiscussionDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> updateDiscussionAction(
      int discussionId, String description) async {
    Map<String, dynamic> data = {
      "description": description,
    };
    // data["_method"] = "PUT";
    final responseJson = await Server.instance.putRequest(
        url: "${ApiCredential.discussion}/$discussionId", postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DiscussionDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> deleteDiscussionAction(int discussionId) async {
    final responseJson = await Server.instance
        .deleteRequest(url: "${ApiCredential.discussion}/$discussionId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DiscussionDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> voteDiscussionAction(int discussionId) async {
    Map<String, dynamic> data = {
      "discussion_id": discussionId,
    };
    // data["_method"] = "PUT";
    final responseJson = await Server.instance
        .putRequest(url: ApiCredential.voteDiscussion, postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DiscussionDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> reportDiscussionAction(
      int discussionId, String remarks) async {
    Map<String, dynamic> data = {
      "discussion_id": discussionId,
      "remarks": remarks,
    };
    // data["_method"] = "PUT";
    final responseJson = await Server.instance
        .putRequest(url: ApiCredential.reportDiscussion, postData: data);
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
      int commentId, String description) async {
    Map<String, dynamic> data = {
      "description": description,
    };
    final responseJson = await Server.instance.putRequest(
        url: "${ApiCredential.createComment}/$commentId", postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => CommentDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> deleteCommentAction(int commentId) async {
    final responseJson = await Server.instance
        .deleteRequest(url: "${ApiCredential.createComment}/$commentId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => CommentDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> voteCommentAction(int commentId) async {
    Map<String, dynamic> data = {
      "comment_id": commentId,
    };
    // data["_method"] = "PUT";
    final responseJson = await Server.instance
        .putRequest(url: ApiCredential.voteComment, postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => CommentDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> reportCommentAction(
      int commentId, String remarks) async {
    Map<String, dynamic> data = {
      "comment_id": commentId,
      "remarks": remarks,
    };
    // data["_method"] = "PUT";
    final responseJson = await Server.instance
        .putRequest(url: ApiCredential.reportComment, postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => CommentDataModel.fromJson(json));
    return responseModel;
  }
}

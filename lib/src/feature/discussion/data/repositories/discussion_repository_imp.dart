import '../mapper/comment_data_mapper.dart';
import '../models/comment_data_model.dart';
import '../../domain/entities/comment_data_entity.dart';
import '../mapper/discussion_comments_data_mapper.dart';
import '../../domain/entities/discussion_comments_data_entity.dart';
import '../mapper/discussion_data_mapper.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/entities/discussion_data_entity.dart';
import '../../domain/repositories/discussion_repository.dart';
import '../data_sources/remote/discussion_data_source.dart';
import '../models/discussion_comments_data_model.dart';
import '../models/discussion_data_model.dart';

class DiscussionRepositoryImp extends DiscussionRepository {
  final DiscussionRemoteDataSource discussionRemoteDataSource;
  DiscussionRepositoryImp({required this.discussionRemoteDataSource});

  @override
  Future<ResponseEntity> getDiscussionsByContent(int courseId,
      int courseModuleId, int contentId, String contentType) async {
    ResponseModel responseModel =
        (await discussionRemoteDataSource.getDiscussionsByContentAction(
            courseId, courseModuleId, contentId, contentType));
    return ResponseModelToEntityMapper<List<DiscussionDataEntity>,
            List<DiscussionDataModel>>()
        .toEntityFromModel(
            responseModel,
            (List<DiscussionDataModel> models) =>
                List<DiscussionDataModel>.from(models)
                    .map((e) => e.toDiscussionDataEntity)
                    .toList());
  }

  @override
  Future<ResponseEntity> getDiscussionDetails(int discussionId) async {
    ResponseModel responseModel = (await discussionRemoteDataSource
        .getDiscussionDetailsAction(discussionId));
    return ResponseModelToEntityMapper<DiscussionDataEntity,
            DiscussionDataModel>()
        .toEntityFromModel(responseModel,
            (DiscussionDataModel model) => model.toDiscussionDataEntity);
  }

  @override
  Future<ResponseEntity> createDiscussion(int courseId, int courseModuleId,
      int contentId, String contentType, String description) async {
    ResponseModel responseModel =
        (await discussionRemoteDataSource.createDiscussionAction(
            courseId, courseModuleId, contentId, contentType, description));
    return ResponseModelToEntityMapper<DiscussionDataEntity,
            DiscussionDataModel>()
        .toEntityFromModel(responseModel,
            (DiscussionDataModel model) => model.toDiscussionDataEntity);
  }

  @override
  Future<ResponseEntity> updateDiscussion(
      int discussionId, String description) async {
    ResponseModel responseModel = (await discussionRemoteDataSource
        .updateDiscussionAction(discussionId, description));
    return ResponseModelToEntityMapper<DiscussionDataEntity,
            DiscussionDataModel>()
        .toEntityFromModel(responseModel,
            (DiscussionDataModel model) => model.toDiscussionDataEntity);
  }

  @override
  Future<ResponseEntity> deleteDiscussion(int discussionId) async {
    ResponseModel responseModel =
        (await discussionRemoteDataSource.deleteDiscussionAction(discussionId));
    return ResponseModelToEntityMapper<DiscussionDataEntity,
            DiscussionDataModel>()
        .toEntityFromModel(responseModel,
            (DiscussionDataModel model) => model.toDiscussionDataEntity);
  }

  @override
  Future<ResponseEntity> voteDiscussion(int discussionId) async {
    ResponseModel responseModel =
        (await discussionRemoteDataSource.voteDiscussionAction(discussionId));
    return ResponseModelToEntityMapper<DiscussionDataEntity,
            DiscussionDataModel>()
        .toEntityFromModel(responseModel,
            (DiscussionDataModel model) => model.toDiscussionDataEntity);
  }

  @override
  Future<ResponseEntity> reportDiscussion(
      int discussionId, String remarks) async {
    ResponseModel responseModel = (await discussionRemoteDataSource
        .reportDiscussionAction(discussionId, remarks));
    return ResponseModelToEntityMapper<DiscussionDataEntity,
            DiscussionDataModel>()
        .toEntityFromModel(responseModel,
            (DiscussionDataModel model) => model.toDiscussionDataEntity);
  }

  @override
  Future<ResponseEntity> getDiscussionComments(int discussionId) async {
    ResponseModel responseModel = (await discussionRemoteDataSource
        .getDiscussionCommentsAction(discussionId));
    return ResponseModelToEntityMapper<DiscussionCommentsDataEntity,
            DiscussionCommentsDataModel>()
        .toEntityFromModel(
            responseModel,
            (DiscussionCommentsDataModel model) =>
                model.toDiscussionCommentsDataEntity);
  }

  @override
  Future<ResponseEntity> createComment(
      int discussionId, String description) async {
    ResponseModel responseModel = (await discussionRemoteDataSource
        .createCommentAction(discussionId, description));
    return ResponseModelToEntityMapper<CommentDataEntity, CommentDataModel>()
        .toEntityFromModel(responseModel,
            (CommentDataModel model) => model.toCommentDataEntity);
  }

  @override
  Future<ResponseEntity> updateComment(
      int commentId, String description) async {
    ResponseModel responseModel = (await discussionRemoteDataSource
        .updateCommentAction(commentId, description));
    return ResponseModelToEntityMapper<CommentDataEntity, CommentDataModel>()
        .toEntityFromModel(responseModel,
            (CommentDataModel model) => model.toCommentDataEntity);
  }

  @override
  Future<ResponseEntity> deleteComment(int commentId) async {
    ResponseModel responseModel =
        (await discussionRemoteDataSource.deleteCommentAction(commentId));
    return ResponseModelToEntityMapper<CommentDataEntity, CommentDataModel>()
        .toEntityFromModel(responseModel,
            (CommentDataModel model) => model.toCommentDataEntity);
  }

  @override
  Future<ResponseEntity> voteComment(int commentId) async {
    ResponseModel responseModel =
        (await discussionRemoteDataSource.voteCommentAction(commentId));
    return ResponseModelToEntityMapper<CommentDataEntity, CommentDataModel>()
        .toEntityFromModel(responseModel,
            (CommentDataModel model) => model.toCommentDataEntity);
  }

  @override
  Future<ResponseEntity> reportComment(int commentId, String remarks) async {
    ResponseModel responseModel = (await discussionRemoteDataSource
        .reportCommentAction(commentId, remarks));
    return ResponseModelToEntityMapper<CommentDataEntity, CommentDataModel>()
        .toEntityFromModel(responseModel,
            (CommentDataModel model) => model.toCommentDataEntity);
  }
}

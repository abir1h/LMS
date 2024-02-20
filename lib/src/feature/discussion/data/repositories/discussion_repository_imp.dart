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
  Future<ResponseEntity> getDiscussions() async {
    ResponseModel responseModel =
        (await discussionRemoteDataSource.getDiscussionsAction());
    return ResponseModelToEntityMapper<DiscussionDataEntity,
            DiscussionDataModel>()
        .toEntityFromModel(responseModel,
            (DiscussionDataModel model) => model.toDiscussionDataEntity);
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
}

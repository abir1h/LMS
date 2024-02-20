import 'comment_data_mapper.dart';
import '../../domain/entities/discussion_comments_data_entity.dart';
import '../models/discussion_comments_data_model.dart';
import 'user_data_mapper.dart';
import '../../domain/entities/comment_data_entity.dart';
import '../models/comment_data_model.dart';

abstract class DiscussionCommentsDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _DiscussionCommentsDataModelToEntityMapper extends DiscussionCommentsDataMapper<
    DiscussionCommentsDataModel, DiscussionCommentsDataEntity> {
  @override
  DiscussionCommentsDataModel fromEntityToModel(
      DiscussionCommentsDataEntity entity) {
    return DiscussionCommentsDataModel(
      id: entity.id,
      courseModuleId: entity.courseModuleId,
      contentType: entity.contentType,
      contentId: entity.contentId,
      description: entity.description,
      attachment: entity.attachment,
      createdBy: entity.createdBy,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      commentsCount: entity.commentsCount,
      user: entity.user.toUserDataModel,
      comments: List<CommentDataEntity>.from(entity.comments)
          .map((entity) => entity.toCommentDataModel)
          .toList(),
    );
  }

  @override
  DiscussionCommentsDataEntity toEntityFromModel(
      DiscussionCommentsDataModel model) {
    return DiscussionCommentsDataEntity(
      id: model.id,
      courseModuleId: model.courseModuleId,
      contentType: model.contentType,
      contentId: model.contentId,
      description: model.description,
      attachment: model.attachment,
      createdBy: model.createdBy,
      status: model.status,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      commentsCount: model.commentsCount,
      user: model.user!.toUserDataEntity,
      comments: List<CommentDataModel>.from(model.comments)
          .map((entity) => entity.toCommentDataEntity)
          .toList(),
    );
  }
}

extension ProfileDataModelExt on DiscussionCommentsDataModel {
  DiscussionCommentsDataEntity get toDiscussionCommentsDataEntity =>
      _DiscussionCommentsDataModelToEntityMapper().toEntityFromModel(this);
}

extension ProfileDataEntityExt on DiscussionCommentsDataEntity {
  DiscussionCommentsDataModel get toDiscussionCommentsDataModel =>
      _DiscussionCommentsDataModelToEntityMapper().fromEntityToModel(this);
}

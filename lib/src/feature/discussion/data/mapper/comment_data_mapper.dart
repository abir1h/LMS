import 'user_data_mapper.dart';
import '../../domain/entities/comment_data_entity.dart';
import '../models/comment_data_model.dart';

abstract class CommentDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CommentDataModelToEntityMapper
    extends CommentDataMapper<CommentDataModel, CommentDataEntity> {
  @override
  CommentDataModel fromEntityToModel(CommentDataEntity entity) {
    return CommentDataModel(
        id: entity.id,
        discussionId: entity.discussionId,
        description: entity.description,
        attachment: entity.attachment,
        vote: entity.vote,
        createdBy: entity.createdBy,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        hasRestriction: entity.hasRestriction,
        restrictedBy: entity.restrictedBy,
        restrictionRemarks: entity.restrictionRemarks);
  }

  @override
  CommentDataEntity toEntityFromModel(CommentDataModel model) {
    return CommentDataEntity(
        id: model.id,
        discussionId: model.discussionId,
        description: model.description,
        attachment: model.attachment,
        vote: model.vote,
        createdBy: model.createdBy,
        status: model.status,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        hasRestriction: model.hasRestriction,
        restrictedBy: model.restrictedBy,
        restrictionRemarks: model.restrictionRemarks);
  }
}

extension ProfileDataModelExt on CommentDataModel {
  CommentDataEntity get toCommentDataEntity =>
      _CommentDataModelToEntityMapper().toEntityFromModel(this);
}

extension ProfileDataEntityExt on CommentDataEntity {
  CommentDataModel get toCommentDataModel =>
      _CommentDataModelToEntityMapper().fromEntityToModel(this);
}

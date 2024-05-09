import 'package:lms/src/feature/discussion/data/mapper/comment_data_mapper.dart';

import '../../domain/entities/comment_data_entity.dart';
import '../../domain/entities/discussion_data_entity.dart';
import '../models/comment_data_model.dart';
import '../models/discussion_data_model.dart';

abstract class DiscussionDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _DiscussionDataModelToEntityMapper
    extends DiscussionDataMapper<DiscussionDataModel, DiscussionDataEntity> {
  @override
  DiscussionDataModel fromEntityToModel(DiscussionDataEntity entity) {
    return DiscussionDataModel(
      id: entity.id,
      courseModuleId: entity.courseModuleId,
      contentType: entity.contentType,
      contentId: entity.contentId,
      description: entity.description,
      attachment: entity.attachment,
      vote: entity.vote,
      createdBy: entity.createdBy,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      courseId: entity.courseId,
      report: entity.report,
      hasRestriction: entity.hasRestriction,
      restrictedBy: entity.restrictedBy,
      restrictionRemarks: entity.restrictionRemarks,
      isDeleted: entity.isDeleted,
      isVote: entity.isVote,
      isReport: entity.isReport,
      isSelf: entity.isSelf,
      cid: entity.cid,
      titleEn: entity.titleEn,
      titleBn: entity.titleBn,
      comments: List<CommentDataEntity>.from(entity.comments)
          .map((entity) => entity.toCommentDataModel)
          .toList(),
    );
  }

  @override
  DiscussionDataEntity toEntityFromModel(DiscussionDataModel model) {
    return DiscussionDataEntity(
      id: model.id,
      courseModuleId: model.courseModuleId,
      contentType: model.contentType,
      contentId: model.contentId,
      description: model.description,
      attachment: model.attachment,
      vote: model.vote,
      createdBy: model.createdBy,
      status: model.status,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      courseId: model.courseId,
      report: model.report,
      hasRestriction: model.hasRestriction,
      restrictedBy: model.restrictedBy,
      restrictionRemarks: model.restrictionRemarks,
      isDeleted: model.isDeleted,
      isVote: model.isVote,
      isReport: model.isReport,
      isSelf: model.isSelf,
      cid: model.cid,
      titleEn: model.titleEn,
      titleBn: model.titleBn,
      comments: List<CommentDataModel>.from(model.comments!)
          .map((entity) => entity.toCommentDataEntity)
          .toList(),
    );
  }
}

extension ProfileDataModelExt on DiscussionDataModel {
  DiscussionDataEntity get toDiscussionDataEntity =>
      _DiscussionDataModelToEntityMapper().toEntityFromModel(this);
}

extension ProfileDataEntityExt on DiscussionDataEntity {
  DiscussionDataModel get toDiscussionDataModel =>
      _DiscussionDataModelToEntityMapper().fromEntityToModel(this);
}

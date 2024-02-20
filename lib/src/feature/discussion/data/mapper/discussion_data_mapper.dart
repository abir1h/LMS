import 'package:lms/src/feature/discussion/data/mapper/user_data_mapper.dart';

import '../../domain/entities/discussion_data_entity.dart';
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
        createdBy: entity.createdBy,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        user: entity.user.toUserDataModel);
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
        createdBy: model.createdBy,
        status: model.status,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        user: model.user!.toUserDataEntity);
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

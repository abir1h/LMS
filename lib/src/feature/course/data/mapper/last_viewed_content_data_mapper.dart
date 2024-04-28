import '../../domain/entities/last_viewed_content_data_entity.dart';
import '../models/last_viewed_content_data_model.dart';

abstract class LastViewedContentDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class LastViewedContentDataModelToEntityMapper
    extends LastViewedContentDataMapper<LastViewedContentDataModel,
        LastViewedContentDataEntity> {
  @override
  LastViewedContentDataModel fromEntityToModel(
      LastViewedContentDataEntity entity) {
    return LastViewedContentDataModel(
        contentTitleEn: entity.contentTitleEn,
        contentTitleBn: entity.contentTitleBn,
        contentType: entity.contentType,
        contentId: entity.contentId,
        sort: entity.sort,
        isCompleted: entity.isCompleted,
        lastWatchTime: entity.lastWatchTime);
  }

  @override
  LastViewedContentDataEntity toEntityFromModel(
      LastViewedContentDataModel model) {
    return LastViewedContentDataEntity(
        contentTitleEn: model.contentTitleEn,
        contentTitleBn: model.contentTitleBn,
        contentType: model.contentType,
        contentId: model.contentId,
        sort: model.sort,
        isCompleted: model.isCompleted,
        lastWatchTime: model.lastWatchTime);
  }
}

extension LastViewedContentDataModelExt on LastViewedContentDataModel {
  LastViewedContentDataEntity get toLastViewedContentDataEntity =>
      LastViewedContentDataModelToEntityMapper().toEntityFromModel(this);
}

extension LastViewedContentDataEntityExt on LastViewedContentDataEntity {
  LastViewedContentDataModel get toLastViewedContentDataModel =>
      LastViewedContentDataModelToEntityMapper().fromEntityToModel(this);
}

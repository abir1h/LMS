import '../../domain/entities/content_data_entity.dart';
import '../models/content_data_model.dart';

abstract class ContentDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class ContentDataModelToEntityMapper
    extends ContentDataMapper<ContentDataModel, ContentDataEntity> {
  @override
  ContentDataModel fromEntityToModel(ContentDataEntity entity) {
    return ContentDataModel(
        id: entity.id, titleEn: entity.titleEn, titleBn: entity.titleBn);
  }

  @override
  ContentDataEntity toEntityFromModel(ContentDataModel model) {
    return ContentDataEntity(
        id: model.id, titleEn: model.titleEn, titleBn: model.titleBn);
  }
}

extension ContentDataModelExt on ContentDataModel {
  ContentDataEntity get toContentDataEntity =>
      ContentDataModelToEntityMapper().toEntityFromModel(this);
}

extension ContentDataEntityExt on ContentDataEntity {
  ContentDataModel get toContentDataModel =>
      ContentDataModelToEntityMapper().fromEntityToModel(this);
}

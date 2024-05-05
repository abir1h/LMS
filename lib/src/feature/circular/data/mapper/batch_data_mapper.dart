import '../../domain/entities/batch_data_entity.dart';
import '../models/batch_data_model.dart';

abstract class BatchDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class BatchDataModelToEntityMapper
    extends BatchDataMapper<BatchDataModel, BatchDataEntity> {
  @override
  BatchDataModel fromEntityToModel(BatchDataEntity entity) {
    return BatchDataModel(
        id: entity.id, nameEn: entity.nameEn, nameBn: entity.nameBn);
  }

  @override
  BatchDataEntity toEntityFromModel(BatchDataModel model) {
    return BatchDataEntity(
        id: model.id, nameEn: model.nameEn, nameBn: model.nameBn);
  }
}

extension BatchDataModelExt on BatchDataModel {
  BatchDataEntity get toBatchDataEntity =>
      BatchDataModelToEntityMapper().toEntityFromModel(this);
}

extension BatchDataEntityExt on BatchDataEntity {
  BatchDataModel get toBatchDataModel =>
      BatchDataModelToEntityMapper().fromEntityToModel(this);
}

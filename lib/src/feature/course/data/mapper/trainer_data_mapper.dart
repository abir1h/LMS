import '../../domain/entities/trainer_data_entity.dart';
import '../models/trainer_data_model.dart';

abstract class TrainerDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class TrainerDataModelToEntityMapper
    extends TrainerDataMapper<TrainerDataModel, TrainerDataEntity> {
  @override
  TrainerDataModel fromEntityToModel(TrainerDataEntity entity) {
    return TrainerDataModel(
        id: entity.id,
        emisUserId: entity.emisUserId,
        fullnameEn: entity.fullnameEn,
        fullnameBn: entity.fullnameBn);
  }

  @override
  TrainerDataEntity toEntityFromModel(TrainerDataModel model) {
    return TrainerDataEntity(
        id: model.id,
        emisUserId:model. emisUserId,
        fullnameEn: model.fullnameEn,
        fullnameBn: model.fullnameBn);
  }
}

extension TrainerDataModelExt on TrainerDataModel {
  TrainerDataEntity get toTrainerDataEntity =>
      TrainerDataModelToEntityMapper().toEntityFromModel(this);
}

extension TrainerDataEntityExt on TrainerDataEntity {
  TrainerDataModel get toTrainerDataModel =>
      TrainerDataModelToEntityMapper().fromEntityToModel(this);
}

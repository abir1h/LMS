import '../../domain/entities/activity_duration_data_entity.dart';
import '../models/activity_duration_data_model.dart';

abstract class ActivityDurationDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _ActivityDurationDataModelToEntityMapper
    extends ActivityDurationDataMapper<ActivityDurationDataModel,
        ActivityDurationDataEntity> {
  @override
  ActivityDurationDataModel fromEntityToModel(
      ActivityDurationDataEntity entity) {
    return ActivityDurationDataModel(x: entity.x, y: entity.y);
  }

  @override
  ActivityDurationDataEntity toEntityFromModel(
      ActivityDurationDataModel model) {
    return ActivityDurationDataEntity(x: model.x, y: model.y);
  }
}

extension ActivityDurationDataModelExt on ActivityDurationDataModel {
  ActivityDurationDataEntity get toActivityDurationDataEntity =>
      _ActivityDurationDataModelToEntityMapper().toEntityFromModel(this);
}

extension ActivityDurationDataEntityExt on ActivityDurationDataEntity {
  ActivityDurationDataModel get toActivityDurationDataModel =>
      _ActivityDurationDataModelToEntityMapper().fromEntityToModel(this);
}

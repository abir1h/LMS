import '../../domain/entities/current_module_data_entity.dart';
import '../models/current_module_data_model.dart';

abstract class CurrentModuleDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CurrentModuleDataModelToEntityMapper extends CurrentModuleDataMapper<
    CurrentModuleDataModel, CurrentModuleDataEntity> {
  @override
  CurrentModuleDataModel fromEntityToModel(CurrentModuleDataEntity entity) {
    return CurrentModuleDataModel(
        courseTitle: entity.courseTitle,
        courseTitleBN: entity.courseTitleBN,
        completion: entity.completion);
  }

  @override
  CurrentModuleDataEntity toEntityFromModel(CurrentModuleDataModel model) {
    return CurrentModuleDataEntity(
        courseTitle: model.courseTitle,
        courseTitleBN: model.courseTitle,
        completion: model.courseTitle);
  }
}

extension CurrentModuleDataModelExt on CurrentModuleDataModel {
  CurrentModuleDataEntity get toCurrentModuleDataEntity =>
      _CurrentModuleDataModelToEntityMapper().toEntityFromModel(this);
}

extension CurrentModuleDataEntityExt on CurrentModuleDataEntity {
  CurrentModuleDataModel get toCurrentModuleDataModel =>
      _CurrentModuleDataModelToEntityMapper().fromEntityToModel(this);
}

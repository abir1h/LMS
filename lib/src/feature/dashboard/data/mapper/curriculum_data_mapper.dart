import '../../domain/entities/curriculum_data_entity.dart';
import '../models/curriculum_data_model.dart';

abstract class CurriculumDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CurriculumDataModelToEntityMapper
    extends CurriculumDataMapper<CurriculumDataModel, CurriculumDataEntity> {
  @override
  CurriculumDataModel fromEntityToModel(CurriculumDataEntity entity) {
    return CurriculumDataModel(
        onGoing: entity.onGoing, completed: entity.completed);
  }

  @override
  CurriculumDataEntity toEntityFromModel(CurriculumDataModel model) {
    return CurriculumDataEntity(
        onGoing: model.onGoing, completed: model.completed);
  }
}

extension CurriculumDataModelExt on CurriculumDataModel {
  CurriculumDataEntity get toCurriculumDataEntity =>
      _CurriculumDataModelToEntityMapper().toEntityFromModel(this);
}

extension CurriculumDataEntityExt on CurriculumDataEntity {
  CurriculumDataModel get toCurriculumDataModel =>
      _CurriculumDataModelToEntityMapper().fromEntityToModel(this);
}

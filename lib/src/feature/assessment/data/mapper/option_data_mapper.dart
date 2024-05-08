import '../../domain/entities/option_data_entity.dart';
import '../models/option_data_model.dart';

abstract class OptionDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class OptionDataModelToEntityMapper
    extends OptionDataMapper<OptionDataModel, OptionDataEntity> {
  @override
  OptionDataModel fromEntityToModel(OptionDataEntity entity) {
    return OptionDataModel(
        id: entity.id,
        circularQuestionId: entity.circularQuestionId,
        optionKey: entity.optionKey,
        optionValue: entity.optionValue,
        optionImg: entity.optionImg,
        sort: entity.sort);
  }

  @override
  OptionDataEntity toEntityFromModel(OptionDataModel model) {
    return OptionDataEntity(
        id: model.id,
        circularQuestionId: model.circularQuestionId,
        optionKey: model.optionKey,
        optionValue: model.optionValue,
        optionImg: model.optionImg,
        sort: model.sort);
  }
}

extension OptionDataModelExt on OptionDataModel {
  OptionDataEntity get toOptionDataEntity =>
      OptionDataModelToEntityMapper().toEntityFromModel(this);
}

extension OptionDataEntityExt on OptionDataEntity {
  OptionDataModel get toOptionDataModel =>
      OptionDataModelToEntityMapper().fromEntityToModel(this);
}

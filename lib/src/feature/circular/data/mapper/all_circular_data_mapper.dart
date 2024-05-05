import 'circular_data_mapper.dart';
import '../../domain/entities/all_circular_data_entity.dart';
import '../../domain/entities/circular_data_entity.dart';
import '../models/all_circular_data_model.dart';
import '../models/circular_data_model.dart';

abstract class AllCircularDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class AllCircularDataModelToEntityMapper
    extends AllCircularDataMapper<AllCircularDataModel, AllCircularDataEntity> {
  @override
  AllCircularDataModel fromEntityToModel(AllCircularDataEntity entity) {
    return AllCircularDataModel(
      running: List<CircularDataEntity>.from(entity.running)
          .map((entity) => entity.toCircularDataModel)
          .toList(),
      upcoming: List<CircularDataEntity>.from(entity.upcoming)
          .map((entity) => entity.toCircularDataModel)
          .toList(),
      completed: List<CircularDataEntity>.from(entity.completed)
          .map((entity) => entity.toCircularDataModel)
          .toList(),
    );
  }

  @override
  AllCircularDataEntity toEntityFromModel(AllCircularDataModel model) {
    return AllCircularDataEntity(
      running: List<CircularDataModel>.from(model.running)
          .map((model) => model.toCircularDataEntity)
          .toList(),
      upcoming: List<CircularDataModel>.from(model.upcoming)
          .map((model) => model.toCircularDataEntity)
          .toList(),
      completed: List<CircularDataModel>.from(model.completed)
          .map((model) => model.toCircularDataEntity)
          .toList(),
    );
  }
}

extension AllCircularDataModelExt on AllCircularDataModel {
  AllCircularDataEntity get toAllCircularDataEntity =>
      AllCircularDataModelToEntityMapper().toEntityFromModel(this);
}

extension AllCircularDataEntityExt on AllCircularDataEntity {
  AllCircularDataModel get toAllCircularDataModel =>
      AllCircularDataModelToEntityMapper().fromEntityToModel(this);
}

import '../../domain/entities/upcoming_class_data_entity.dart';
import '../models/upcoming_class_data_model.dart';

abstract class UpcomingClassDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class UpcomingClassDataModelToEntityMapper extends UpcomingClassDataMapper<
    UpcomingClassDataModel, UpcomingClassDataEntity> {
  @override
  UpcomingClassDataModel fromEntityToModel(UpcomingClassDataEntity entity) {
    return UpcomingClassDataModel(
        id: entity.id,
        titleEn: entity.titleEn,
        titleBn: entity.titleBn,
        scheduleAt: entity.scheduleAt);
  }

  @override
  UpcomingClassDataEntity toEntityFromModel(UpcomingClassDataModel model) {
    return UpcomingClassDataEntity(
        id: model.id,
        titleEn: model.titleEn,
        titleBn: model.titleBn,
        scheduleAt: model.scheduleAt);
  }
}

extension UpcomingClassDataModelExt on UpcomingClassDataModel {
  UpcomingClassDataEntity get toUpcomingClassDataEntity =>
      UpcomingClassDataModelToEntityMapper().toEntityFromModel(this);
}

extension UpcomingClassDataEntityExt on UpcomingClassDataEntity {
  UpcomingClassDataModel get toUpcomingClassDataModel =>
      UpcomingClassDataModelToEntityMapper().fromEntityToModel(this);
}

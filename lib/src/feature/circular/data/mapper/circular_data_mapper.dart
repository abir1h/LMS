import '../../domain/entities/circular_data_entity.dart';
import '../models/circular_data_model.dart';

abstract class CircularDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class CircularDataModelToEntityMapper
    extends CircularDataMapper<CircularDataModel, CircularDataEntity> {
  @override
  CircularDataModel fromEntityToModel(CircularDataEntity entity) {
    return CircularDataModel(
        id: entity.id,
        batchId: entity.batchId,
        courseId: entity.courseId,
        referenceNumber: entity.referenceNumber,
        nameEn: entity.nameEn,
        nameBn: entity.nameBn,
        status: entity.status,
        startDate: entity.startDate,
        endDate: entity.endDate,
        courseNameEn: entity.courseNameEn,
        courseNameBn: entity.courseNameBn,
        code: entity.code,
        batchNameEn: entity.batchNameEn,
        batchNameBn: entity.batchNameBn,
        circularTrainersCount: entity.circularTrainersCount);
  }

  @override
  CircularDataEntity toEntityFromModel(CircularDataModel model) {
    return CircularDataEntity(
        id: model.id,
        batchId: model.batchId,
        courseId: model.courseId,
        referenceNumber: model.referenceNumber,
        nameEn: model.nameEn,
        nameBn: model.nameBn,
        status: model.status,
        startDate: model.startDate,
        endDate: model.endDate,
        courseNameEn: model.courseNameEn,
        courseNameBn: model.courseNameBn,
        code: model.code,
        batchNameEn: model.batchNameEn,
        batchNameBn: model.batchNameBn,
        circularTrainersCount: model.circularTrainersCount);
  }
}

extension CircularDataModelExt on CircularDataModel {
  CircularDataEntity get toCircularDataEntity =>
      CircularDataModelToEntityMapper().toEntityFromModel(this);
}

extension CircularDataEntityExt on CircularDataEntity {
  CircularDataModel get toCircularDataModel =>
      CircularDataModelToEntityMapper().fromEntityToModel(this);
}

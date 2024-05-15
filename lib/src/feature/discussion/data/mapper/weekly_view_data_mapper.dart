import '../../domain/entities/weekly_view_data_entity.dart';
import '../models/weekly_view_data_model.dart';

abstract class WeeklyViewDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _WeeklyViewDataModelToEntityMapper
    extends WeeklyViewDataMapper<WeeklyViewDataModel, WeeklyViewDataEntity> {
  @override
  WeeklyViewDataModel fromEntityToModel(WeeklyViewDataEntity entity) {
    return WeeklyViewDataModel(
        id: entity.id,
        courseId: entity.courseId,
        circularId: entity.circularId,
        code: entity.code,
        nameEn: entity.nameEn,
        nameBn: entity.nameBn,
        startDate: entity.startDate,
        endDate: entity.endDate,
        sort: entity.sort,
        learningOutcomeEn: entity.learningOutcomeEn,
        learningOutcomeBn: entity.learningOutcomeBn,
        isModified: entity.isModified,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        coursediscussionsCount: entity.coursediscussionsCount,
        latestTime: entity.latestTime);
  }

  @override
  WeeklyViewDataEntity toEntityFromModel(WeeklyViewDataModel model) {
    return WeeklyViewDataEntity(
        id: model.id,
        courseId: model.courseId,
        circularId: model.circularId,
        code: model.code,
        nameEn: model.nameEn,
        nameBn: model.nameBn,
        startDate: model.startDate,
        endDate: model.endDate,
        sort: model.sort,
        learningOutcomeEn: model.learningOutcomeEn,
        learningOutcomeBn: model.learningOutcomeBn,
        isModified: model.isModified,
        status: model.status,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        coursediscussionsCount: model.coursediscussionsCount,
        latestTime: model.latestTime);
  }
}

extension ProfileDataModelExt on WeeklyViewDataModel {
  WeeklyViewDataEntity get toWeeklyViewDataEntity =>
      _WeeklyViewDataModelToEntityMapper().toEntityFromModel(this);
}

extension ProfileDataEntityExt on WeeklyViewDataEntity {
  WeeklyViewDataModel get toWeeklyViewDataModel =>
      _WeeklyViewDataModelToEntityMapper().fromEntityToModel(this);
}

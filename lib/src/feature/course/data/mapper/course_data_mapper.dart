import '../../domain/entities/course_data_entity.dart';
import '../models/course_data_model.dart';

abstract class CourseDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class CourseDataModelToEntityMapper
    extends CourseDataMapper<CourseDataModel, CourseDataEntity> {
  @override
  CourseDataModel fromEntityToModel(CourseDataEntity entity) {
    return CourseDataModel(
        id: entity.id,
        code: entity.code,
        nameEn: entity.nameEn,
        nameBn: entity.nameBn,
        circularId: entity.circularId,
        startDate: entity.startDate,
        endDate: entity.endDate,
        publishDate: entity.publishDate,
        circularStatus: entity.circularStatus,
        courseProgress: entity.courseProgress);
  }

  @override
  CourseDataEntity toEntityFromModel(CourseDataModel model) {
    return CourseDataEntity(
        id: model.id,
        code: model.code,
        nameEn: model.nameEn,
        nameBn: model.nameBn,
        circularId: model.circularId,
        startDate: model.startDate,
        endDate: model.endDate,
        publishDate: model.publishDate,
        circularStatus: model.circularStatus,
        courseProgress: model.courseProgress);
  }
}

extension CourseDataModelExt on CourseDataModel {
  CourseDataEntity get toCourseDataEntity =>
      CourseDataModelToEntityMapper().toEntityFromModel(this);
}

extension CourseDataEntityExt on CourseDataEntity {
  CourseDataModel get toCourseDataModel =>
      CourseDataModelToEntityMapper().fromEntityToModel(this);
}

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
        referenceNumber: entity.referenceNumber,
        startDate: entity.startDate,
        endDate: entity.endDate,
        publishDate: entity.publishDate,
        flag: entity.flag,
        url: entity.url,
        circularStatus: entity.circularStatus,
        courseProgress: entity.courseProgress,
        batchId: entity.batchId,
        batchNameEn: entity.batchNameEn,
        batchNameBn: entity.batchNameBn,
        batchStatus: entity.batchStatus,
        courseModulesCount: entity.courseModulesCount,
        blendedClassesCount: entity.blendedClassesCount,
        physicalClassesCount: entity.physicalClassesCount,
        liveClassesCount: entity.liveClassesCount,
        batchProgress: entity.batchProgress,
        totalTimeSpent: entity.totalTimeSpent);
  }

  @override
  CourseDataEntity toEntityFromModel(CourseDataModel model) {
    return CourseDataEntity(
        id: model.id,
        code: model.code,
        nameEn: model.nameEn,
        nameBn: model.nameBn,
        circularId: model.circularId,
        referenceNumber: model.referenceNumber,
        startDate: model.startDate,
        endDate: model.endDate,
        publishDate: model.publishDate,
        flag: model.flag,
        url: model.url,
        circularStatus: model.circularStatus,
        courseProgress: model.courseProgress,
        batchId: model.batchId,
        batchNameEn: model.batchNameEn,
        batchNameBn: model.batchNameBn,
        batchStatus: model.batchStatus,
        courseModulesCount: model.courseModulesCount,
        blendedClassesCount: model.blendedClassesCount,
        physicalClassesCount: model.physicalClassesCount,
        liveClassesCount: model.liveClassesCount,
        batchProgress: model.batchProgress,
        totalTimeSpent: model.totalTimeSpent);
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

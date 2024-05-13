import '../../domain/entities/progress_course_data_entity.dart';
import '../../domain/entities/progress_course_data_entity.dart';
import '../models/progress_course_data_model.dart';
import '../models/progress_course_data_model.dart';

abstract class ProgressDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class ProgressDataModelToEntityMapper
    extends ProgressDataMapper<ProgressCourseDataModel, ProgressCourseDataEntity> {
  @override
  ProgressCourseDataModel fromEntityToModel(ProgressCourseDataEntity entity) {
    return ProgressCourseDataModel(
        id: entity.id,
        code: entity.code,
        nameEn: entity.nameEn,
        nameBn: entity.nameBn,
        featuredImage: entity.featuredImage,
        icon: entity.icon,
        circularId: entity.circularId,
        referenceNumber: entity.referenceNumber,
        startDate: entity.startDate,
        endDate: entity.endDate,
        publishDate: entity.publishDate,
        flag: entity.flag,
        url: entity.url,
        circularStatus: entity.circularStatus,
        batchId: entity.batchId,
        batchNameEn: entity.batchNameEn,
        batchNameBn: entity.batchNameBn,
        batchStatus: entity.batchStatus,
        courseModulesCount: entity.courseModulesCount,
        blendedClassesCount: entity.blendedClassesCount,
        courseScriptsCount: entity.courseScriptsCount,
        courseProgress: entity.courseProgress);
  }

  @override
  ProgressCourseDataEntity toEntityFromModel(ProgressCourseDataModel model) {
    return ProgressCourseDataEntity(
        id: model.id,
        code: model.code,
        nameEn: model.nameEn,
        nameBn: model.nameBn,
        featuredImage: model.featuredImage,
        icon: model.icon,
        circularId: model.circularId,
        referenceNumber: model.referenceNumber,
        startDate: model.startDate,
        endDate: model.endDate,
        publishDate: model.publishDate,
        flag: model.flag,
        url: model.url,
        circularStatus: model.circularStatus,
        batchId: model.batchId,
        batchNameEn: model.batchNameEn,
        batchNameBn: model.batchNameBn,
        batchStatus: model.batchStatus,
        courseModulesCount: model.courseModulesCount,
        blendedClassesCount: model.blendedClassesCount,
        courseScriptsCount: model.courseScriptsCount,
        courseProgress: model.courseProgress);
  }
}

extension ProgressDataModelExt on ProgressCourseDataModel {
  ProgressCourseDataEntity get toProgressDataEntity =>
      ProgressDataModelToEntityMapper().toEntityFromModel(this);
}

extension ProgressDataEntityExt on ProgressCourseDataEntity {
  ProgressCourseDataModel get toProgressDataModel =>
      ProgressDataModelToEntityMapper().fromEntityToModel(this);
}

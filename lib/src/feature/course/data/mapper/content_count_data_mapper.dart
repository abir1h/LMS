import '../../domain/entities/content_count_data_entity.dart';
import '../models/content_count_data_model.dart';

abstract class ContentCountDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class ContentCountDataModelToEntityMapper extends ContentCountDataMapper<
    ContentCountDataModel, ContentCountDataEntity> {
  @override
  ContentCountDataModel fromEntityToModel(ContentCountDataEntity entity) {
    return ContentCountDataModel(
        courseWeekCount: entity.courseWeekCount,
        blendedClassCount: entity.blendedClassCount,
        scriptCount: entity.scriptCount,
        videoCount: entity.videoCount,
        assignmentCount: entity.assignmentCount,
        assessmentCount: entity.assessmentCount);
  }

  @override
  ContentCountDataEntity toEntityFromModel(ContentCountDataModel model) {
    return ContentCountDataEntity(
        courseWeekCount: model.courseWeekCount,
        blendedClassCount: model.blendedClassCount,
        scriptCount: model.scriptCount,
        videoCount: model.videoCount,
        assignmentCount: model.assignmentCount,
        assessmentCount: model.assessmentCount);
  }
}

extension ContentCountDataModelExt on ContentCountDataModel {
  ContentCountDataEntity get toContentCountDataEntity =>
      ContentCountDataModelToEntityMapper().toEntityFromModel(this);
}

extension ContentCountDataEntityExt on ContentCountDataEntity {
  ContentCountDataModel get toContentCountDataModel =>
      ContentCountDataModelToEntityMapper().fromEntityToModel(this);
}

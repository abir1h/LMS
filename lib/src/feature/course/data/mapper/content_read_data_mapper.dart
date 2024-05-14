import '../../domain/entities/content_count_data_entity.dart';
import '../../domain/entities/content_read_data_entity.dart';
import '../models/content_count_data_model.dart';
import '../models/content_read_data_model.dart';

abstract class ContentReadDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class ContentReadDataModelToEntityMapper
    extends ContentReadDataMapper<ContentReadDataModel, ContentReadDataEntity> {
  @override
  ContentReadDataModel fromEntityToModel(ContentReadDataEntity entity) {
    return ContentReadDataModel(
        id: entity.id,
        circularId: entity.circularId,
        courseId: entity.courseId,
        contentType: entity.contentType,
        contentId: entity.contentId,
        traineeId: entity.traineeId,
        isCompleted: entity.isCompleted,
        lastWatchTime: entity.lastWatchTime,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        attendanceType: entity.attendanceType);
  }

  @override
  ContentReadDataEntity toEntityFromModel(ContentReadDataModel model) {
    return ContentReadDataEntity(
        id: model.id,
        circularId:  model.circularId,
        courseId:  model.courseId,
        contentType:  model.contentType,
        contentId:  model.contentId,
        traineeId:  model.traineeId,
        isCompleted:  model.isCompleted,
        lastWatchTime:  model.lastWatchTime,
        createdAt:  model.createdAt,
        updatedAt:  model.updatedAt,
        attendanceType:  model.attendanceType);
  }
}

extension ContentReadDataModelExt on ContentReadDataModel {
  ContentReadDataEntity get toContentReadDataEntity =>
      ContentReadDataModelToEntityMapper().toEntityFromModel(this);
}

extension ContentReadDataEntityExt on ContentReadDataEntity {
  ContentReadDataModel get toContentReadDataModel =>
      ContentReadDataModelToEntityMapper().fromEntityToModel(this);
}

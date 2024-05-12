import '../../domain/entities/course_content_data_entity.dart';
import '../models/course_content_data_model.dart';

abstract class CourseContentDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class CourseContentDataModelToEntityMapper extends CourseContentDataMapper<
    CourseContentDataModel, CourseContentDataEntity> {
  @override
  CourseContentDataModel fromEntityToModel(CourseContentDataEntity entity) {
    return CourseContentDataModel(
        contentTitleEn: entity.contentTitleEn,
        contentTitleBn: entity.contentTitleBn,
        contentType: entity.contentType,
        contentId: entity.contentId,
        sort: entity.sort,
        schedule: entity.schedule,
        isCompleted: entity.isCompleted,
        lastWatchTime: entity.lastWatchTime);
  }

  @override
  CourseContentDataEntity toEntityFromModel(CourseContentDataModel model) {
    return CourseContentDataEntity(
        contentTitleEn: model.contentTitleEn,
        contentTitleBn: model.contentTitleBn,
        contentType: model.contentType,
        contentId: model.contentId,
        sort: model.sort,
        schedule: model.schedule,
        isCompleted: model.isCompleted,
        lastWatchTime: model.lastWatchTime);
  }
}

extension CourseContentDataModelExt on CourseContentDataModel {
  CourseContentDataEntity get toCourseContentDataEntity =>
      CourseContentDataModelToEntityMapper().toEntityFromModel(this);
}

extension CourseContentDataEntityExt on CourseContentDataEntity {
  CourseContentDataModel get toCourseContentDataModel =>
      CourseContentDataModelToEntityMapper().fromEntityToModel(this);
}

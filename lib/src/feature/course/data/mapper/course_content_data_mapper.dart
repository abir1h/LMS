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
        contentType: entity.contentType,
        contentId: entity.contentId,
        sort: entity.sort,
        titleEn: entity.titleEn,
        titleBn: entity.titleBn);
  }

  @override
  CourseContentDataEntity toEntityFromModel(CourseContentDataModel model) {
    return CourseContentDataEntity(
        contentType: model.contentType,
        contentId: model.contentId,
        sort: model.sort,
        titleEn: model.titleEn,
        titleBn: model.titleBn);
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

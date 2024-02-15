import '../../domain/entities/course_content_data_entity.dart';
import '../../domain/entities/course_type_data_entity.dart';
import '../models/course_content_data_model.dart';
import '../models/course_type_data_model.dart';

abstract class CourseTypeDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class CourseTypeDataModelToEntityMapper
    extends CourseTypeDataMapper<CourseTypeDataModel, CourseTypeDataEntity> {
  @override
  CourseTypeDataModel fromEntityToModel(CourseTypeDataEntity entity) {
    return CourseTypeDataModel(
        id: entity.id,
        nameEn: entity.nameEn,
        nameBn: entity.nameBn,
        status: entity.status);
  }

  @override
  CourseTypeDataEntity toEntityFromModel(CourseTypeDataModel model) {
    return CourseTypeDataEntity(
        id: model.id,
        nameEn: model.nameEn,
        nameBn: model.nameBn,
        status: model.status);
  }
}

extension CourseTypeDataModelExt on CourseTypeDataModel {
  CourseTypeDataEntity get toCourseTypeDataEntity =>
      CourseTypeDataModelToEntityMapper().toEntityFromModel(this);
}

extension CourseTypeDataEntityExt on CourseTypeDataEntity {
  CourseTypeDataModel get toCourseTypeDataModel =>
      CourseTypeDataModelToEntityMapper().fromEntityToModel(this);
}

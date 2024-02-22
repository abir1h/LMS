import 'course_content_data_mapper.dart';
import '../../domain/entities/course_content_data_entity.dart';
import '../../domain/entities/course_module_data_entity.dart';
import '../models/course_content_data_model.dart';
import '../models/course_module_data_model.dart';

abstract class CourseModuleDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class CourseModuleDataModelToEntityMapper extends CourseModuleDataMapper<
    CourseModuleDataModel, CourseModuleDataEntity> {
  @override
  CourseModuleDataModel fromEntityToModel(CourseModuleDataEntity entity) {
    return CourseModuleDataModel(
        id: entity.id,
        courseId: entity.courseId,
        code: entity.code,
        nameEn: entity.nameEn,
        nameBn: entity.nameBn,
        startDate: entity.startDate,
        endDate: entity.endDate,
        sort: entity.sort,
        isModified: entity.isModified,
        courseContents:
            List<CourseContentDataEntity>.from(entity.courseContents!)
                .map((entity) => entity.toCourseContentDataModel)
                .toList(),
        isLocked: entity.isLocked);
  }

  @override
  CourseModuleDataEntity toEntityFromModel(CourseModuleDataModel model) {
    return CourseModuleDataEntity(
        id: model.id,
        courseId: model.courseId,
        code: model.code,
        nameEn: model.nameEn,
        nameBn: model.nameBn,
        startDate: model.startDate,
        endDate: model.endDate,
        sort: model.sort,
        isModified: model.isModified,
        courseContents: List<CourseContentDataModel>.from(model.courseContents!)
            .map((model) => model.toCourseContentDataEntity)
            .toList(),
        isLocked: model.isLocked);
  }
}

extension CourseModuleDataModelExt on CourseModuleDataModel {
  CourseModuleDataEntity get toCourseModuleDataEntity =>
      CourseModuleDataModelToEntityMapper().toEntityFromModel(this);
}

extension CourseModuleDataEntityExt on CourseModuleDataEntity {
  CourseModuleDataModel get toCourseModuleDataModel =>
      CourseModuleDataModelToEntityMapper().fromEntityToModel(this);
}

import 'package:lms/src/feature/course/data/mapper/course_content_data_mapper.dart';
import 'package:lms/src/feature/course/data/mapper/course_module_data_mapper.dart';
import 'package:lms/src/feature/course/data/mapper/course_type_data_mapper.dart';

import '../../domain/entities/course_content_data_entity.dart';
import '../../domain/entities/course_data_entity.dart';
import '../../domain/entities/course_module_data_entity.dart';
import '../models/course_content_data_model.dart';
import '../models/course_data_model.dart';
import '../models/course_module_data_model.dart';

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
      shortDescEn: entity.shortDescEn,
      shortDescBn: entity.shortDescBn,
      courseTypeId: entity.courseTypeId,
      courseType: entity.courseType?.toCourseTypeDataModel,
      courseModules: List<CourseModuleDataEntity>.from(entity.courseModules!)
          .map((entity) => entity.toCourseModuleDataModel)
          .toList(),
    );
  }

  @override
  CourseDataEntity toEntityFromModel(CourseDataModel model) {
    return CourseDataEntity(
      id: model.id,
      code: model.code,
      nameEn: model.nameEn,
      nameBn: model.nameBn,
      shortDescEn: model.shortDescEn,
      shortDescBn: model.shortDescBn,
      courseTypeId: model.courseTypeId,
      courseType: model.courseType?.toCourseTypeDataEntity,
      courseModules: List<CourseModuleDataModel>.from(model.courseModules!)
          .map((model) => model.toCourseModuleDataEntity)
          .toList(),
    );
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

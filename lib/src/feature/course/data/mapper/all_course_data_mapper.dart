import 'course_data_mapper.dart';
import '../models/course_data_model.dart';
import '../../domain/entities/course_data_entity.dart';
import '../../domain/entities/all_course_data_entity.dart';
import '../models/all_course_data_model.dart';

abstract class AllCourseDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class AllCourseDataModelToEntityMapper
    extends AllCourseDataMapper<AllCourseDataModel, AllCourseDataEntity> {
  @override
  AllCourseDataModel fromEntityToModel(AllCourseDataEntity entity) {
    return AllCourseDataModel(
      courses: List<CourseDataEntity>.from(entity.courses)
          .map((entity) => entity.toCourseDataModel)
          .toList(),
      running: List<CourseDataEntity>.from(entity.courses)
          .map((entity) => entity.toCourseDataModel)
          .toList(),
    );
  }

  @override
  AllCourseDataEntity toEntityFromModel(AllCourseDataModel model) {
    return AllCourseDataEntity(
      courses: List<CourseDataModel>.from(model.courses)
          .map((model) => model.toCourseDataEntity)
          .toList(),
      running: List<CourseDataModel>.from(model.courses)
          .map((model) => model.toCourseDataEntity)
          .toList(),
    );
  }
}

extension AllCourseDataModelExt on AllCourseDataModel {
  AllCourseDataEntity get toAllCourseDataEntity =>
      AllCourseDataModelToEntityMapper().toEntityFromModel(this);
}

extension AllCourseDataEntityExt on AllCourseDataEntity {
  AllCourseDataModel get toAllCourseDataModel =>
      AllCourseDataModelToEntityMapper().fromEntityToModel(this);
}

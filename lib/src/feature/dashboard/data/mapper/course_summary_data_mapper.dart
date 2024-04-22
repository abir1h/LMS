import '../../domain/entities/course_summary_data_entity.dart';
import '../models/course_summary_data_model.dart';

abstract class CourseSummaryDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CourseSummaryDataModelToEntityMapper extends CourseSummaryDataMapper<
    CourseSummaryDataModel, CourseSummaryDataEntity> {
  @override
  CourseSummaryDataModel fromEntityToModel(CourseSummaryDataEntity entity) {
    return CourseSummaryDataModel(
        runningCourses: entity.runningCourses,
        completedCourses: entity.completedCourses,
        upcomingCourses: entity.upcomingCourses);
  }

  @override
  CourseSummaryDataEntity toEntityFromModel(CourseSummaryDataModel model) {
    return CourseSummaryDataEntity(
        runningCourses: model.runningCourses,
        completedCourses: model.completedCourses,
        upcomingCourses: model.upcomingCourses);
  }
}

extension CourseSummaryDataModelExt on CourseSummaryDataModel {
  CourseSummaryDataEntity get toCourseSummaryDataEntity =>
      _CourseSummaryDataModelToEntityMapper().toEntityFromModel(this);
}

extension CourseSummaryDataEntityExt on CourseSummaryDataEntity {
  CourseSummaryDataModel get toCourseSummaryDataModel =>
      _CourseSummaryDataModelToEntityMapper().fromEntityToModel(this);
}

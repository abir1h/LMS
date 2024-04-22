import 'course_summary_data_mapper.dart';
import '../../../course/data/mapper/course_data_mapper.dart';
import '../../../course/data/models/course_data_model.dart';
import '../../../course/domain/entities/course_data_entity.dart';
import '../../domain/entities/dashboard_data_entity.dart';
import '../models/dashboard_data_model.dart';

abstract class DashboardDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _DashboardDataModelToEntityMapper
    extends DashboardDataMapper<DashboardDataModel, DashboardDataEntity> {
  @override
  DashboardDataModel fromEntityToModel(DashboardDataEntity entity) {
    return DashboardDataModel(
        courses: List<CourseDataEntity>.from(entity.courses)
            .map((entity) => entity.toCourseDataModel)
            .toList(),
        courseSummery: entity.courseSummery.toCourseSummaryDataModel,
        discussion: entity.discussion);
  }

  @override
  DashboardDataEntity toEntityFromModel(DashboardDataModel model) {
    return DashboardDataEntity(
        courses: List<CourseDataModel>.from(model.courses)
            .map((model) => model.toCourseDataEntity)
            .toList(),
        courseSummery: model.courseSummery!.toCourseSummaryDataEntity,
        discussion: model.discussion);
  }
}

extension DashboardDataModelExt on DashboardDataModel {
  DashboardDataEntity get toDashboardDataEntity =>
      _DashboardDataModelToEntityMapper().toEntityFromModel(this);
}

extension DashboardRDataEntityExt on DashboardDataEntity {
  DashboardDataModel get toDashboardDataModel =>
      _DashboardDataModelToEntityMapper().fromEntityToModel(this);
}

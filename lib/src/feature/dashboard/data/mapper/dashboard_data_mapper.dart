import 'activity_duration_data_mapper.dart';
import 'current_module_data_mapper.dart';
import 'curriculum_data_mapper.dart';
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
        currentModuleData: entity.currentModuleData?.toCurrentModuleDataModel,
        curriculumData: entity.curriculumData?.toCurriculumDataModel,
        discussions: entity.discussions,
        noticesCount: entity.noticesCount,
        activityDurationData:
            entity.activityDurationData?.toActivityDurationDataModel,
        noticeboardList: entity.noticeboardList);
  }

  @override
  DashboardDataEntity toEntityFromModel(DashboardDataModel model) {
    return DashboardDataEntity(
        currentModuleData: model.currentModuleData?.toCurrentModuleDataEntity,
        curriculumData: model.curriculumData?.toCurriculumDataEntity,
        discussions: model.discussions,
        noticesCount: model.noticesCount,
        activityDurationData:
            model.activityDurationData?.toActivityDurationDataEntity,
        noticeboardList: model.noticeboardList);
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

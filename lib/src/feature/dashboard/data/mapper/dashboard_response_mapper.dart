import 'dashboard_data_mapper.dart';
import '../../domain/entities/dashboard_response_entity.dart';
import '../models/dashboard_response_model.dart';

abstract class DashboardResponseMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _DashboardResponseModelToEntityMapper extends DashboardResponseMapper<
    DashboardResponseModel, DashboardResponseEntity> {
  @override
  DashboardResponseModel fromEntityToModel(DashboardResponseEntity entity) {
    return DashboardResponseModel(
      message: entity.message,
      data: entity.data?.toDashboardDataModel,
      errors: entity.errors,
    );
  }

  @override
  DashboardResponseEntity toEntityFromModel(DashboardResponseModel model) {
    return DashboardResponseEntity(
        message: model.message,
        data: model.data?.toDashboardDataEntity,
        errors: model.errors);
  }
}

extension DashboardResponseModelExt on DashboardResponseModel {
  DashboardResponseEntity get toDashboardResponseEntity =>
      _DashboardResponseModelToEntityMapper().toEntityFromModel(this);
}

extension DashboardResponseEntityExt on DashboardResponseEntity {
  DashboardResponseModel get toDashboardResponseModel =>
      _DashboardResponseModelToEntityMapper().fromEntityToModel(this);
}

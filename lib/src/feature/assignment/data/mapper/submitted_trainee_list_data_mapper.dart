import '../../domain/entities/submitted_trainee_list_data_entity.dart';
import '../models/submitted_trainee_list_data_model.dart';

abstract class SubmittedTraineeListDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class SubmittedTraineeListDataModelToEntityMapper
    extends SubmittedTraineeListDataMapper<SubmittedTraineeListDataModel,
        SubmittedTraineeListDataEntity> {
  @override
  SubmittedTraineeListDataModel fromEntityToModel(
      SubmittedTraineeListDataEntity entity) {
    return SubmittedTraineeListDataModel(
      id: entity.id,
      status: entity.status,
      isAccepted: entity.isAccepted,
      isReviewed: entity.isReviewed,
    );
  }

  @override
  SubmittedTraineeListDataEntity toEntityFromModel(
      SubmittedTraineeListDataModel model) {
    return SubmittedTraineeListDataEntity(
      id: model.id,
      status: model.status,
      isAccepted: model.isAccepted,
      isReviewed: model.isReviewed,
    );
  }
}

extension SubmittedTraineeListDataModelExt on SubmittedTraineeListDataModel {
  SubmittedTraineeListDataEntity get toSubmittedTraineeListDataEntity =>
      SubmittedTraineeListDataModelToEntityMapper().toEntityFromModel(this);
}

extension SubmittedTraineeListDataEntityExt on SubmittedTraineeListDataEntity {
  SubmittedTraineeListDataModel get toSubmittedTraineeListDataModel =>
      SubmittedTraineeListDataModelToEntityMapper().fromEntityToModel(this);
}

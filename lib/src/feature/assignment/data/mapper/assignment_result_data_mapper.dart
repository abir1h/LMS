import '../../domain/entities/assignment_result_data_entity.dart';
import '../models/assignment_result_data_model.dart';

abstract class AssignmentResultDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class AssignmentResultDataModelToEntityMapper
    extends AssignmentResultDataMapper<AssignmentResultDataModel,
        AssignmentResultDataEntity> {
  @override
  AssignmentResultDataModel fromEntityToModel(
      AssignmentResultDataEntity entity) {
    return AssignmentResultDataModel(
        id: entity.id,
        assignmentSubmissionId: entity.assignmentSubmissionId,
        circularSubAssignmentId: entity.circularSubAssignmentId,
        traineesId: entity.traineesId,
        markObtained: entity.markObtained,
        evaluatedBy: entity.evaluatedBy,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt);
  }

  @override
  AssignmentResultDataEntity toEntityFromModel(
      AssignmentResultDataModel model) {
    return AssignmentResultDataEntity(
        id: model.id,
        assignmentSubmissionId: model.assignmentSubmissionId,
        circularSubAssignmentId: model.circularSubAssignmentId,
        traineesId: model.traineesId,
        markObtained: model.markObtained,
        evaluatedBy: model.evaluatedBy,
        status: model.status,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt);
  }
}

extension AssignmentResultDataModelExt on AssignmentResultDataModel {
  AssignmentResultDataEntity get toAssignmentResultDataEntity =>
      AssignmentResultDataModelToEntityMapper().toEntityFromModel(this);
}

extension AssignmentResultDataEntityExt on AssignmentResultDataEntity {
  AssignmentResultDataModel get toAssignmentResultDataModel =>
      AssignmentResultDataModelToEntityMapper().fromEntityToModel(this);
}

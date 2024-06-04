import '../../domain/entities/collaborative_assignment_result_entity.dart';
import '../models/collaborative_assignment_result_data_model.dart';

abstract class CollaborativeAssignmentResultDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class CollaborativeAssignmentResultDataModelToEntityMapper
    extends CollaborativeAssignmentResultDataMapper<
        CollaborativeAssignmentResultDataModel,
        CollaborativeAssignmentResultDataEntity> {
  @override
  CollaborativeAssignmentResultDataModel fromEntityToModel(
      CollaborativeAssignmentResultDataEntity entity) {
    return CollaborativeAssignmentResultDataModel(
        id: entity.id,
        assignmentId: entity.assignmentId,
        evaluatedBy: entity.evaluatedBy,
        markObtained: entity.markObtained,
        acceptTime: entity.acceptTime,
        details: entity.details,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        assignmentSubmissionId: entity.assignmentSubmissionId);
  }

  @override
  CollaborativeAssignmentResultDataEntity toEntityFromModel(
      CollaborativeAssignmentResultDataModel model) {
    return CollaborativeAssignmentResultDataEntity(
        id: model.id,
        assignmentId: model.assignmentId,
        evaluatedBy: model.evaluatedBy,
        markObtained: model.markObtained,
        acceptTime: model.acceptTime,
        details: model.details,
        status: model.status,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        assignmentSubmissionId: model.assignmentSubmissionId);
  }
}

extension CollaborativeAssignmentResultDataModelExt
    on CollaborativeAssignmentResultDataModel {
  CollaborativeAssignmentResultDataEntity
      get toCollaborativeAssignmentResultDataEntity =>
          CollaborativeAssignmentResultDataModelToEntityMapper()
              .toEntityFromModel(this);
}

extension CollaborativeAssignmentResultDataEntityExt
    on CollaborativeAssignmentResultDataEntity {
  CollaborativeAssignmentResultDataModel
      get toCollaborativeAssignmentResultDataModel =>
          CollaborativeAssignmentResultDataModelToEntityMapper()
              .fromEntityToModel(this);
}

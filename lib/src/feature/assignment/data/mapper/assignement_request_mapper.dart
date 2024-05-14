import '../../domain/entities/assignement_request_entity.dart';
import '../models/assignment_request_model.dart';

abstract class AssignmentRequestMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class AssignmentRequestModelToEntityMapper extends AssignmentRequestMapper<
    AssignmentRequestModel, AssignmentRequestEntity> {
  @override
  AssignmentRequestModel fromEntityToModel(AssignmentRequestEntity entity) {
    return AssignmentRequestModel(
        circularId: entity.circularId,
        courseId: entity.courseId,
        courseModuleId: entity.courseModuleId,
        circularAssignmentId: entity.circularAssignmentId,
        message: entity.message,
        traineeId: entity.traineeId,
        status: entity.status,
        updatedAt: entity.updatedAt,
        createdAt: entity.createdAt,
        id: entity.id);
  }

  @override
  AssignmentRequestEntity toEntityFromModel(AssignmentRequestModel model) {
    return AssignmentRequestEntity(
        circularId: model.circularId,
        courseId: model.courseId,
        courseModuleId: model.courseModuleId,
        circularAssignmentId: model.circularAssignmentId,
        message: model.message,
        traineeId: model.traineeId,
        status: model.status,
        updatedAt: model.updatedAt,
        createdAt: model.createdAt,
        id: model.id);
  }
}

extension AssignmentRequestModelExt on AssignmentRequestModel {
  AssignmentRequestEntity get toAssignmentRequestEntity =>
      AssignmentRequestModelToEntityMapper().toEntityFromModel(this);
}

extension AssignmentRequestEntityExt on AssignmentRequestEntity {
  AssignmentRequestModel get toAssignmentRequestModel =>
      AssignmentRequestModelToEntityMapper().fromEntityToModel(this);
}

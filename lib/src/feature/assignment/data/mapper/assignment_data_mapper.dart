import '../../domain/entities/assignment_data_entity.dart';
import '../models/assignment_data_model.dart';

abstract class AssignmentDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class AssignmentDataModelToEntityMapper
    extends AssignmentDataMapper<AssignmentDataModel, AssignmentDataEntity> {
  @override
  AssignmentDataModel fromEntityToModel(AssignmentDataEntity entity) {
    return AssignmentDataModel(
        id: entity.id,
        courseId: entity.courseId,
        courseModuleId: entity.courseModuleId,
        titleEn: entity.titleEn,
        titleBn: entity.titleBn,
        mark: entity.mark,
        passMark: entity.passMark,
        totalTime: entity.totalTime,
        assignmentStartTime: entity.assignmentStartTime,
        assignmentEndTime: entity.assignmentEndTime,
        extendedDueDate: entity.extendedDueDate,
        instructionsEn: entity.instructionsEn,
        instructionsBn: entity.instructionsBn,
        supportingDoc: entity.supportingDoc,
        submissionType: entity.submissionType,
        isGroupAssignments: entity.isGroupAssignments,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        deletedAt: entity.deletedAt);
  }

  @override
  AssignmentDataEntity toEntityFromModel(AssignmentDataModel model) {
    return AssignmentDataEntity(
        id: model.id,
        courseId: model.courseId,
        courseModuleId: model.courseModuleId,
        titleEn: model.titleEn,
        titleBn: model.titleBn,
        mark: model.mark,
        passMark: model.passMark,
        totalTime: model.totalTime,
        assignmentStartTime: model.assignmentStartTime,
        assignmentEndTime: model.assignmentEndTime,
        extendedDueDate: model.extendedDueDate,
        instructionsEn: model.instructionsEn,
        instructionsBn: model.instructionsBn,
        supportingDoc: model.supportingDoc,
        submissionType: model.submissionType,
        isGroupAssignments: model.isGroupAssignments,
        status: model.status,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        deletedAt: model.deletedAt);
  }
}

extension AssignmentDataModelExt on AssignmentDataModel {
  AssignmentDataEntity get toAssignmentDataEntity =>
      AssignmentDataModelToEntityMapper().toEntityFromModel(this);
}

extension AssignmentDataEntityExt on AssignmentDataEntity {
  AssignmentDataModel get toAssignmentDataModel =>
      AssignmentDataModelToEntityMapper().fromEntityToModel(this);
}

import 'assignment_submission_data_mapper.dart';
import '../../domain/entities/sub_assignment_data_entity.dart';
import '../models/sub_assignment_data_model.dart';

abstract class SubAssignmentDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class SubAssignmentDataModelToEntityMapper extends SubAssignmentDataMapper<
    SubAssignmentDataModel, SubAssignmentDataEntity> {
  @override
  SubAssignmentDataModel fromEntityToModel(SubAssignmentDataEntity entity) {
    return SubAssignmentDataModel(
        id: entity.id,
        circularAssignmentsId: entity.circularAssignmentsId,
        parentId: entity.parentId,
        traineesIds: entity.traineesIds,
        titleEn: entity.titleEn,
        titleBn: entity.titleBn,
        instructionsEn: entity.instructionsEn,
        instructionsBn: entity.instructionsBn,
        supportingDoc: entity.supportingDoc,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        assignmentSubmissions:
            entity.assignmentSubmissions?.toAssignmentSubmissionDataModel);
  }

  @override
  SubAssignmentDataEntity toEntityFromModel(SubAssignmentDataModel model) {
    return SubAssignmentDataEntity(
        id: model.id,
        circularAssignmentsId: model.circularAssignmentsId,
        parentId: model.parentId,
        traineesIds: model.traineesIds,
        titleEn: model.titleEn,
        titleBn: model.titleBn,
        instructionsEn: model.instructionsEn,
        instructionsBn: model.instructionsBn,
        supportingDoc: model.supportingDoc,
        status: model.status,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        assignmentSubmissions:
            model.assignmentSubmissions?.toAssignmentSubmissionDataEntity);
  }
}

extension SubAssignmentDataModelExt on SubAssignmentDataModel {
  SubAssignmentDataEntity get toSubAssignmentDataEntity =>
      SubAssignmentDataModelToEntityMapper().toEntityFromModel(this);
}

extension SubAssignmentDataEntityExt on SubAssignmentDataEntity {
  SubAssignmentDataModel get toSubAssignmentDataModel =>
      SubAssignmentDataModelToEntityMapper().fromEntityToModel(this);
}

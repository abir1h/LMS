import 'package:lms/src/feature/assignment/data/mapper/assignment_submission_data_mapper.dart';
import 'package:lms/src/feature/assignment/data/mapper/sub_assignment_data_mapper.dart';
import 'package:lms/src/feature/assignment/data/mapper/submitted_trainee_list_data_mapper.dart';

import '../../domain/entities/assignment_data_entity.dart';
import '../../domain/entities/submitted_trainee_list_data_entity.dart';
import '../models/assignment_data_model.dart';
import '../models/submitted_trainee_list_data_model.dart';

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
        circularId: entity.circularId,
        courseModuleId: entity.courseModuleId,
        titleEn: entity.titleEn,
        titleBn: entity.titleBn,
        mark: entity.mark,
        passMark: entity.passMark,
        totalTime: entity.totalTime,
        submissionType: entity.submissionType,
        extendedDueDate: entity.extendedDueDate,
        assignmentStartTime: entity.assignmentStartTime,
        assignmentEndTime: entity.assignmentEndTime,
        descriptionEn: entity.descriptionEn,
        descriptionBn: entity.descriptionBn,
        instructionsEn: entity.instructionsEn,
        instructionsBn: entity.instructionsBn,
        type: entity.type,
        supportingDoc: entity.supportingDoc,
        assignmentRequestCount: entity.assignmentRequestCount,
        inReview: entity.inReview,
        allowed: entity.allowed,
        submittedTraineeList: List<SubmittedTraineeListDataEntity>.from(
                entity.submittedTraineeList)
            .map((entity) => entity.toSubmittedTraineeListDataModel)
            .toList(),
        circularSubAssignments:
            entity.circularSubAssignments?.toSubAssignmentDataModel,
        assignmentSubmissions:
            entity.assignmentSubmissions?.toAssignmentSubmissionDataModel);
  }

  @override
  AssignmentDataEntity toEntityFromModel(AssignmentDataModel model) {
    return AssignmentDataEntity(
        id: model.id,
        courseId: model.courseId,
        circularId: model.circularId,
        courseModuleId: model.courseModuleId,
        titleEn: model.titleEn,
        titleBn: model.titleBn,
        mark: model.mark,
        passMark: model.passMark,
        totalTime: model.totalTime,
        submissionType: model.submissionType,
        extendedDueDate: model.extendedDueDate,
        assignmentStartTime: model.assignmentStartTime,
        assignmentEndTime: model.assignmentEndTime,
        descriptionEn: model.descriptionEn,
        descriptionBn: model.descriptionBn,
        instructionsEn: model.instructionsEn,
        instructionsBn: model.instructionsBn,
        type: model.type,
        supportingDoc: model.supportingDoc,
        assignmentRequestCount: model.assignmentRequestCount,
        inReview: model.inReview,
        allowed: model.allowed,
        submittedTraineeList:
            List<SubmittedTraineeListDataModel>.from(model.submittedTraineeList)
                .map((entity) => entity.toSubmittedTraineeListDataEntity)
                .toList(),
        circularSubAssignments:
            model.circularSubAssignments?.toSubAssignmentDataEntity,
        assignmentSubmissions:
            model.assignmentSubmissions?.toAssignmentSubmissionDataEntity);
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

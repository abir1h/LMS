import 'package:lms/src/feature/assignment/data/mapper/assignment_result_data_mapper.dart';
import 'package:lms/src/feature/assignment/data/mapper/attachment_data_mapper.dart';

import '../../domain/entities/assignment_submission_data_entity.dart';
import '../../domain/entities/attachment_data_entity.dart';
import '../models/assignment_submission_data_model.dart';
import '../models/attachment_data_model.dart';

abstract class AssignmentSubmissionDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class AssignmentSubmissionDataModelToEntityMapper
    extends AssignmentSubmissionDataMapper<AssignmentSubmissionDataModel,
        AssignmentSubmissionDataEntity> {
  @override
  AssignmentSubmissionDataModel fromEntityToModel(
      AssignmentSubmissionDataEntity entity) {
    return AssignmentSubmissionDataModel(
      id: entity.id,
      circularId: entity.circularId,
      courseId: entity.courseId,
      circularAssignmentId: entity.circularAssignmentId,
      circularSubAssignmentId: entity.circularSubAssignmentId,
      submittedBy: entity.submittedBy,
      evaluatedBy: entity.evaluatedBy,
      ipAddress: entity.ipAddress,
      answer: entity.answer,
      marks: entity.marks,
      remarks: entity.remarks,
      status: entity.status,
      isResubmitted: entity.isResubmitted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      attachments: List<AttachmentDataEntity>.from(entity.attachments)
          .map((entity) => entity.toAttachmentDataModel)
          .toList(),
      assignmentResultDataModel:
          entity.assignmentResultDataEntity?.toAssignmentResultDataModel,
    );
  }

  @override
  AssignmentSubmissionDataEntity toEntityFromModel(
      AssignmentSubmissionDataModel model) {
    return AssignmentSubmissionDataEntity(
      id: model.id,
      circularId: model.circularId,
      courseId: model.courseId,
      circularAssignmentId: model.circularAssignmentId,
      circularSubAssignmentId: model.circularSubAssignmentId,
      submittedBy: model.submittedBy,
      evaluatedBy: model.evaluatedBy,
      ipAddress: model.ipAddress,
      answer: model.answer,
      marks: model.marks,
      remarks: model.remarks,
      status: model.status,
      isResubmitted: model.isResubmitted,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      attachments: List<AttachmentDataModel>.from(model.attachments)
          .map((model) => model.toAttachmentDataEntity)
          .toList(),
      assignmentResultDataEntity:
          model.assignmentResultDataModel?.toAssignmentResultDataEntity,
    );
  }
}

extension AssignmentSubmissionDataModelExt on AssignmentSubmissionDataModel {
  AssignmentSubmissionDataEntity get toAssignmentSubmissionDataEntity =>
      AssignmentSubmissionDataModelToEntityMapper().toEntityFromModel(this);
}

extension AssignmentSubmissionDataEntityExt on AssignmentSubmissionDataEntity {
  AssignmentSubmissionDataModel get toAssignmentSubmissionDataModel =>
      AssignmentSubmissionDataModelToEntityMapper().fromEntityToModel(this);
}

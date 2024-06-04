import 'assignment_data_mapper.dart';
import 'attachment_data_mapper.dart';
import 'collaborative_assignment_result_data_mapper.dart';
import '../../domain/entities/attachment_data_entity.dart';
import '../../domain/entities/collaborative_accept_review_data_entity.dart';
import '../models/attachment_data_model.dart';
import '../models/collaborative_accept_review_data_model.dart';

abstract class CollaborativeAcceptReviewDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class CollaborativeAcceptReviewDataModelToEntityMapper
    extends CollaborativeAcceptReviewDataMapper<
        CollaborativeAcceptReviewDataModel,
        CollaborativeAcceptReviewDataEntity> {
  @override
  CollaborativeAcceptReviewDataModel fromEntityToModel(
      CollaborativeAcceptReviewDataEntity entity) {
    return CollaborativeAcceptReviewDataModel(
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
        assignment: entity.assignment?.toAssignmentDataModel,
        attachments: List<AttachmentDataEntity>.from(entity.attachments)
            .map((entity) => entity.toAttachmentDataModel)
            .toList(),
        collaborativeAssignmentResult: entity.collaborativeAssignmentResult
            ?.toCollaborativeAssignmentResultDataModel);
  }

  @override
  CollaborativeAcceptReviewDataEntity toEntityFromModel(
      CollaborativeAcceptReviewDataModel model) {
    return CollaborativeAcceptReviewDataEntity(
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
        assignment: model.assignment?.toAssignmentDataEntity,
        attachments: List<AttachmentDataModel>.from(model.attachments)
            .map((entity) => entity.toAttachmentDataEntity)
            .toList(),
        collaborativeAssignmentResult: model.collaborativeAssignmentResult
            ?.toCollaborativeAssignmentResultDataEntity);
  }
}

extension CollaborativeAcceptReviewDataModelExt
    on CollaborativeAcceptReviewDataModel {
  CollaborativeAcceptReviewDataEntity
      get toCollaborativeAcceptReviewDataEntity =>
          CollaborativeAcceptReviewDataModelToEntityMapper()
              .toEntityFromModel(this);
}

extension CollaborativeAcceptReviewDataEntityExt
    on CollaborativeAcceptReviewDataEntity {
  CollaborativeAcceptReviewDataModel get toCollaborativeAcceptReviewDataModel =>
      CollaborativeAcceptReviewDataModelToEntityMapper()
          .fromEntityToModel(this);
}

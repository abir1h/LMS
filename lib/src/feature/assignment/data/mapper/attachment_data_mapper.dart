import '../../domain/entities/attachment_data_entity.dart';
import '../models/attachment_data_model.dart';

abstract class AttachmentDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class AttachmentDataModelToEntityMapper
    extends AttachmentDataMapper<AttachmentDataModel, AttachmentDataEntity> {
  @override
  AttachmentDataModel fromEntityToModel(AttachmentDataEntity entity) {
    return AttachmentDataModel(
        id: entity.id,
        assignmentSubmissionId: entity.assignmentSubmissionId,
        file: entity.file,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt);
  }

  @override
  AttachmentDataEntity toEntityFromModel(AttachmentDataModel model) {
    return AttachmentDataEntity(
        id: model.id,
        assignmentSubmissionId: model.assignmentSubmissionId,
        file: model.file,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt);
  }
}

extension AttachmentDataModelExt on AttachmentDataModel {
  AttachmentDataEntity get toAttachmentDataEntity =>
      AttachmentDataModelToEntityMapper().toEntityFromModel(this);
}

extension AttachmentDataEntityExt on AttachmentDataEntity {
  AttachmentDataModel get toAttachmentDataModel =>
      AttachmentDataModelToEntityMapper().fromEntityToModel(this);
}

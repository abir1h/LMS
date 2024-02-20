import '../../domain/entities/note_data_entity.dart';
import '../models/note_data_model.dart';

abstract class NoteDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class NoteDataModelToEntityMapper
    extends NoteDataMapper<NoteDataModel, NoteDataEntity> {
  @override
  NoteDataModel fromEntityToModel(NoteDataEntity entity) {
    return NoteDataModel(
        courseModuleId: entity.courseModuleId,
        contentId: entity.contentId,
        contentType: entity.contentType,
        title: entity.title,
        description: entity.description,
        createdBy: entity.createdBy,
        status: entity.status,
        createdAt: entity.createdAt);
  }

  @override
  NoteDataEntity toEntityFromModel(NoteDataModel model) {
    return NoteDataEntity(
        courseModuleId: model.courseModuleId,
        contentId: model.contentId,
        contentType: model.contentType,
        title: model.title,
        description: model.description,
        createdBy: model.createdBy,
        status: model.status,
        createdAt: model.createdAt);
  }
}

extension NoteDataModelExt on NoteDataModel {
  NoteDataEntity get toNoteDataEntity =>
      NoteDataModelToEntityMapper().toEntityFromModel(this);
}

extension NoteDataEntityExt on NoteDataEntity {
  NoteDataModel get toNoteDataModel =>
      NoteDataModelToEntityMapper().fromEntityToModel(this);
}

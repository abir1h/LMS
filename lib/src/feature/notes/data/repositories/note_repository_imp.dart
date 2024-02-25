import '../mapper/note_data_mapper.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/entities/note_data_entity.dart';
import '../../domain/repositories/note_repository.dart';
import '../data_sources/remote/note_data_source.dart';
import '../models/note_data_model.dart';

class NoteRepositoryImp extends NoteRepository {
  final NoteRemoteDataSource noteRemoteDataSource;
  NoteRepositoryImp({required this.noteRemoteDataSource});

  @override
  Future<ResponseEntity> getNotes() async {
    ResponseModel responseModel = (await noteRemoteDataSource.getNotesAction());
    return ResponseModelToEntityMapper<List<NoteDataEntity>,
            List<NoteDataModel>>()
        .toEntityFromModel(
            responseModel,
            (List<NoteDataModel> models) => List<NoteDataModel>.from(models)
                .map((e) => e.toNoteDataEntity)
                .toList());
  }

  @override
  Future<ResponseEntity> getNotesByContent(
      int contentId, String contentType) async {
    ResponseModel responseModel = (await noteRemoteDataSource
        .getNotesByContentAction(contentId, contentType));
    return ResponseModelToEntityMapper<List<NoteDataEntity>,
            List<NoteDataModel>>()
        .toEntityFromModel(
            responseModel,
            (List<NoteDataModel> models) => List<NoteDataModel>.from(models)
                .map((e) => e.toNoteDataEntity)
                .toList());
  }

  @override
  Future<ResponseEntity> getNoteDetails(int noteId) async {
    ResponseModel responseModel =
        (await noteRemoteDataSource.getNoteDetailsAction(noteId));
    return ResponseModelToEntityMapper<NoteDataEntity, NoteDataModel>()
        .toEntityFromModel(
            responseModel, (NoteDataModel model) => model.toNoteDataEntity);
  }

  @override
  Future<ResponseEntity> createNote(
      NoteDataEntity noteDataEntity) async {
    ResponseModel responseModel = (await noteRemoteDataSource
        .createNoteAction(noteDataEntity.toNoteDataModel));
    return ResponseModelToEntityMapper<NoteDataEntity, NoteDataModel>()
        .toEntityFromModel(
            responseModel, (NoteDataModel model) => model.toNoteDataEntity);
  }

  @override
  Future<ResponseEntity> updateNote(
      NoteDataEntity noteDataEntity) async {
    ResponseModel responseModel = (await noteRemoteDataSource
        .updateNoteAction(noteDataEntity.toNoteDataModel));
    return ResponseModelToEntityMapper<NoteDataEntity, NoteDataModel>()
        .toEntityFromModel(
            responseModel, (NoteDataModel model) => model.toNoteDataEntity);
  }

  @override
  Future<ResponseEntity> deleteNote(int noteId) async {
    ResponseModel responseModel =
        (await noteRemoteDataSource.deleteNoteAction(noteId));
    return ResponseModelToEntityMapper<NoteDataEntity, NoteDataModel>()
        .toEntityFromModel(
            responseModel, (NoteDataModel model) => model.toNoteDataEntity);
  }
}

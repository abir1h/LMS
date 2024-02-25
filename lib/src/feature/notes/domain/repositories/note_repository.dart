import '../../../shared/domain/entities/response_entity.dart';
import '../entities/note_data_entity.dart';

abstract class NoteRepository {
  Future<ResponseEntity> getNotes();
  Future<ResponseEntity> getNotesByContent(int contentId, String contentType);
  Future<ResponseEntity> getNoteDetails(int noteId);
  Future<ResponseEntity> createNote(NoteDataEntity noteDataEntity);
  Future<ResponseEntity> updateNote(NoteDataEntity noteDataEntity);
  Future<ResponseEntity> deleteNote(int noteId);
}

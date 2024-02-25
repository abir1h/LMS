import '../../../shared/domain/entities/response_entity.dart';
import '../entities/note_data_entity.dart';
import '../repositories/note_repository.dart';

class NoteUseCase {
  final NoteRepository _noteRepository;
  NoteUseCase({required NoteRepository noteRepository})
      : _noteRepository = noteRepository;

  Future<ResponseEntity> getNotesUseCase() async {
    final response = _noteRepository.getNotes();
    return response;
  }

  Future<ResponseEntity> getNotesByContentUseCase(
      int contentId, String contentType) async {
    final response = _noteRepository.getNotesByContent(contentId, contentType);
    return response;
  }

  Future<ResponseEntity> getNoteDetailsUseCase(int noteId) async {
    final response = _noteRepository.getNoteDetails(noteId);
    return response;
  }

  Future<ResponseEntity> createNoteUseCase(
      NoteDataEntity noteDataEntity) async {
    final response = _noteRepository.createNote(noteDataEntity);
    return response;
  }

  Future<ResponseEntity> updateNoteUseCase(
      NoteDataEntity noteDataEntity) async {
    final response = _noteRepository.updateNote(noteDataEntity);
    return response;
  }

  Future<ResponseEntity> deleteNoteUseCase(int noteId) async {
    final response = _noteRepository.deleteNote(noteId);
    return response;
  }
}

import '../../../shared/domain/entities/response_entity.dart';
import '../entities/note_data_entity.dart';
import '../repositories/note_repository.dart';

class NoteUseCase {
  final NoteRepository _noteRepository;
  NoteUseCase({required NoteRepository noteRepository})
      : _noteRepository = noteRepository;

  Future<ResponseEntity> getNotesUseCase(int pageNumber,{String? sortBy, bool? sortDesc}) async {
    final response =
    _noteRepository.getNoteList(pageNumber,sortBy:sortBy,sortDesc:sortDesc);
    return response;
  }

  Future<ResponseEntity> createNotesUseCase(
      NoteDataEntity noteDataEntity) async {
    final response = _noteRepository.createNotes(noteDataEntity);
    return response;
  }

  Future<ResponseEntity> updateNotesUseCase(
      NoteDataEntity noteDataEntity) async {
    final response = _noteRepository.updateNotes(noteDataEntity);
    return response;
  }

  Future<ResponseEntity> deleteNotesUseCase(int noteId) async {
    final response = _noteRepository.deleteNotes(noteId);
    return response;
  }

  Future<ResponseEntity> getNotesByContentUseCase(
      int contentId, String contentType) async {
    final response = _noteRepository.getNotesByContent(contentId, contentType);
    return response;
  }
}

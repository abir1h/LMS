import 'package:flutter/material.dart';
import '../../../notes/domain/entities/note_data_entity.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../notes/data/data_sources/remote/note_data_source.dart';
import '../../../notes/data/repositories/note_repository_imp.dart';
import '../../../notes/domain/use_cases/note_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  // void navigateToDetailedNoteScreen(int noteId);
}

mixin CourseNoteWidgetService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final NoteUseCase _noteUseCase = NoteUseCase(
      noteRepository: NoteRepositoryImp(
          noteRemoteDataSource: NoteRemoteDataSourceImp()));

  Future<ResponseEntity> getNotesByContent(int contentId, String contentType) async {
    return _noteUseCase.getNotesByContentUseCase(contentId, contentType);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    noteDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<List<NoteDataEntity>>
      noteDataStreamController = AppStreamController();

  ///Discussion list
  void loadNoteList(int contentId, String contentType) {
    if (!mounted) return;
    noteDataStreamController.add(LoadingState());
    getNotesByContent(contentId, contentType)
        .then((value) {
      if (value.error == null && value.data.isNotEmpty) {
        noteDataStreamController
            .add(DataLoadedState<List<NoteDataEntity>>(value.data));
      } else if (value.error == null &&
          value.data.isEmpty) {
        noteDataStreamController
            .add(DataLoadedState<List<NoteDataEntity>>(value.data));
        // noteDataStreamController
        //     .add(EmptyState(message: 'No Notes Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  // void onTapNote(int noteId) {
  //   _view.navigateToDetailedNoteScreen(noteId);
  // }
}

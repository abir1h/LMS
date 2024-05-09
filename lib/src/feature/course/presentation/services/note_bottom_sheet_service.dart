import 'package:flutter/material.dart';

import '../../../notes/data/data_sources/remote/note_data_source.dart';
import '../../../notes/data/repositories/note_repository_imp.dart';
import '../../../notes/domain/entities/note_data_entity.dart';
import '../../../notes/domain/use_cases/note_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';


abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin NoteBottomSheetService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;

  final NoteUseCase _noteUseCase = NoteUseCase(
      noteRepository:
      NoteRepositoryImp(noteRemoteDataSource: NoteRemoteDataSourceImp()));

  Future<ResponseEntity> updateNotes(NoteDataEntity noteDataEntity) async {
    return _noteUseCase.updateNotesUseCase(noteDataEntity);
  }

  Future<ResponseEntity> createNotes(NoteDataEntity noteDataEntity) async {
    return _noteUseCase.createNotesUseCase(noteDataEntity);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  void onUpdateNotes(NoteDataEntity noteDataEntity) {
    updateNotes(noteDataEntity).then((value) {
      if (mounted) {
        if (value.error == null && value.data != null) {
          _view.showSuccess(value.message!);
          // AppEventsNotifier.notify(EventAction.notesScreen);
        } else {
          _view.showWarning(value.message!);
          // AppEventsNotifier.notify(EventAction.notesScreen);
        }
        return value;
      }
    });
  }

  void onCreateNotes(NoteDataEntity noteDataEntity) {
    createNotes(noteDataEntity).then((value) {
      if (mounted) {
        if (value.error == null && value.data != null) {
          _view.showSuccess(value.message!);
          // AppEventsNotifier.notify(EventAction.notesScreen);
        } else {
          _view.showWarning(value.message!);
          // AppEventsNotifier.notify(EventAction.notesScreen);
        }
        return value;
      }
    });
  }
}

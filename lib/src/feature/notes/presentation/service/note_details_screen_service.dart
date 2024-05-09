import 'package:flutter/material.dart';
import 'package:lms/src/core/routes/app_route_args.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../domain/entities/note_data_entity.dart';

abstract class _ViewModel {
  void onNavigateToNoteEditScreen(NoteDataEntity noteDataEntity);
}

mixin NoteDetailsScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  void onTapEdit(NoteDataEntity noteDataEntity) {
    _view.onNavigateToNoteEditScreen(noteDataEntity);
  }
}

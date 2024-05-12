import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/assignment_data_source.dart';
import '../../data/repositories/assignment_repository_imp.dart';
import '../../domain/entities/assignment_data_entity.dart';
import '../../domain/use_cases/assignment_use_case.dart';
import '../models/assignment_model.dart';

abstract class _ViewModel {

}

mixin AssignmentBottomSheetService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;
  AssignmentModel? assignmentModel;


  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

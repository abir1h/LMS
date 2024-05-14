import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../course/data/data_sources/remote/course_data_source.dart';
import '../../../course/data/repositories/course_repository_imp.dart';
import '../../../course/domain/entities/script_data_entity.dart';
import '../../../course/domain/use_cases/course_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';


abstract class _ViewModel {
  void showWarning(String message);
}

mixin TranscriptScreenVideoService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;

  final CourseUseCase _courseUseCase = CourseUseCase(
      courseRepository: CourseRepositoryImp(
          courseRemoteDataSource: CourseRemoteDataSourceImp()));

  Future<ResponseEntity> getScriptDetails(int courseContentId) async {
    return _courseUseCase.getScriptDetailsUseCase(courseContentId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    scriptDetailsDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<ScriptDataEntity>
  scriptDetailsDataStreamController = AppStreamController();

  ///Load Script details
  void loadScriptData(int courseContentId) {
    if (!mounted) return;
    scriptDetailsDataStreamController.add(LoadingState());
    getScriptDetails(courseContentId).then((value) {
      if (value.error == null && value.data != null) {
        scriptDetailsDataStreamController
            .add(DataLoadedState<ScriptDataEntity>(value.data));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}
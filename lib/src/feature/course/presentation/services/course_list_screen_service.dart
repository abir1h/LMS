import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/course_data_source.dart';
import '../../data/repositories/course_repository_imp.dart';
import '../../domain/entities/all_course_data_entity.dart';
import '../../domain/use_cases/course_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
}

mixin CourseListScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final CourseUseCase _courseUseCase = CourseUseCase(
      courseRepository: CourseRepositoryImp(
          courseRemoteDataSource: CourseRemoteDataSourceImp()));

  Future<ResponseEntity> getCourses(String courseStatus) async {
    return _courseUseCase.getCoursesUseCase(courseStatus);
  }

  Future<ResponseEntity> getCourseDetails(int courseId) async {
    return _courseUseCase.getCourseDetailsUseCase(courseId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    allCourseDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<AllCourseDataEntity> allCourseDataStreamController =
      AppStreamController();

  ///Load Course list
  void loadAllCourseData(String courseStatus) {
    if (!mounted) return;
    allCourseDataStreamController.add(LoadingState());
    getCourses(courseStatus).then((value) {
      if (value.error == null && value.data != null) {
        allCourseDataStreamController
            .add(DataLoadedState<AllCourseDataEntity>(value.data));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}

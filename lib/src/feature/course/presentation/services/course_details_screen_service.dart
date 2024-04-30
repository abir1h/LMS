import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../data/data_sources/remote/course_data_source.dart';
import '../../data/repositories/course_repository_imp.dart';
import '../../domain/entities/course_details_data_entity.dart';
import '../../domain/use_cases/course_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToCourseVideoScreen();
  void navigateToOverallProgressScreen();
  void navigateToCourseAssignmentScreen(int courseContentId);
  void navigateToCourseAssessmentScreen(int courseContentId);
  void navigateToCourseLiveClassScreen(int courseContentId);
  void navigateToCourseScriptScreen(int courseContentId, String courseCode,
      String courseDescriptionEn, String courseDescriptionBn);
}

mixin CourseDetailsScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final CourseUseCase _courseUseCase = CourseUseCase(
      courseRepository: CourseRepositoryImp(
          courseRemoteDataSource: CourseRemoteDataSourceImp()));

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
    courseDetailsDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<CourseDetailsDataEntity>
      courseDetailsDataStreamController = AppStreamController();

  ///Load Course list
  void loadCourseData(int courseId) {
    if (!mounted) return;
    courseDetailsDataStreamController.add(LoadingState());
    getCourseDetails(courseId).then((value) {
      if (value.error == null && value.data != null) {
        courseDetailsDataStreamController
            .add(DataLoadedState<CourseDetailsDataEntity>(value.data));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTapCourseVideo() {
    _view.navigateToCourseVideoScreen();
  }

  void onTapProgress() {
    _view.navigateToOverallProgressScreen();
  }

  void onTapCourseAssignment(int courseContentId) {
    _view.navigateToCourseAssignmentScreen(courseContentId);
  }

  void onTapCourseAssessment(int courseContentId) {
    _view.navigateToCourseAssessmentScreen(courseContentId);
  }

  void onTapCourseLiveClass(int courseContentId) {
    _view.navigateToCourseLiveClassScreen(courseContentId);
  }

  void onTapScript(
      {required int courseContentId,
      required String courseCode,
      required String courseDescriptionEn,
      required String courseDescriptionBn}) {
    _view.navigateToCourseScriptScreen(
        courseContentId, courseCode, courseDescriptionEn, courseDescriptionBn);
  }
}

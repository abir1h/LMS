import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../data/data_sources/remote/course_data_source.dart';
import '../../data/repositories/course_repository_imp.dart';
import '../../domain/entities/course_details_data_entity.dart';
import '../../domain/use_cases/course_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToCourseVideoScreen(int contentId, String contentType,
      String contentTitleEn, String contentTitleBn);
  void navigateToOverallProgressScreen();
  void navigateToCourseAssignmentScreen(int courseContentId, bool isCompleted);
  void navigateToCourseAssessmentScreen(int courseContentId);
  void navigateToCourseLiveClassScreen(int courseContentId);
  void navigateToCourseScriptScreen(
      int courseId,
      int courseContentId,
      String courseContentType,
      String courseCode,
      String courseDescriptionEn,
      String courseDescriptionBn);
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

  Future<ResponseEntity> contentRead(
      int contentId,
      String contentType,
      int courseId,
      bool isCompleted,
      String lastWatchTime,
      String attendanceType) async {
    return _courseUseCase.contentReadUseCase(contentId, contentType, courseId,
        isCompleted, lastWatchTime, attendanceType);
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
        courseDetailsDataStreamController
            .add(EmptyState(message: ""));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  Future<ResponseEntity> contentReadPost(int contentId, int courseId) async {
    ResponseEntity responseEntity =
        await contentRead(contentId, "course_script", courseId, true, "", "");
    if (responseEntity.error == null && responseEntity.data != null) {
    } else {
      _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }

  void onTapCourseVideo(int contentId, String contentType,
      String contentTitleEn, String contentTitleBn) {
    _view.navigateToCourseVideoScreen(
        contentId, contentType, contentTitleEn, contentTitleBn);
  }

  void onTapProgress() {
    _view.navigateToOverallProgressScreen();
  }

  void onTapCourseAssignment(int courseContentId, bool isCompleted) {
    _view.navigateToCourseAssignmentScreen(courseContentId, isCompleted);
  }

  void onTapCourseAssessment(int courseContentId) {
    _view.navigateToCourseAssessmentScreen(courseContentId);
  }

  void onTapCourseLiveClass(int courseContentId) {
    _view.navigateToCourseLiveClassScreen(courseContentId);
  }

  void onTapScript(
      {required int courseId,
      required int courseContentId,
      required String courseContentType,
      required String courseCode,
      required String courseDescriptionEn,
      required String courseDescriptionBn}) {
    _view.navigateToCourseScriptScreen(
        courseId,
        courseContentId,
        courseContentType,
        courseCode,
        courseDescriptionEn,
        courseDescriptionBn);
  }
}

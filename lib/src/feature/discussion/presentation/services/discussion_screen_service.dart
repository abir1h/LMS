import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../course/data/data_sources/remote/course_data_source.dart';
import '../../../course/data/repositories/course_repository_imp.dart';
import '../../../course/domain/entities/all_course_data_entity.dart';
import '../../../course/domain/use_cases/course_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/discussion_data_source.dart';
import '../../data/repositories/discussion_repository_imp.dart';
import '../../domain/entities/discussion_data_entity.dart';
import '../../domain/use_cases/discussion_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToDetailedDiscussionScreen(int discussionId);
}

mixin DiscussionScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final CourseUseCase _courseUseCase = CourseUseCase(
      courseRepository: CourseRepositoryImp(
          courseRemoteDataSource: CourseRemoteDataSourceImp()));

  Future<ResponseEntity> getCourses(String courseStatus) async {
    return _courseUseCase.getCoursesUseCase(courseStatus);
  }

  final DiscussionUseCase _discussionUseCase = DiscussionUseCase(
      discussionRepository: DiscussionRepositoryImp(
          discussionRemoteDataSource: DiscussionRemoteDataSourceImp()));

  Future<ResponseEntity> getDiscussions(int courseId) async {
    return _discussionUseCase.getDiscussionsUseCase(courseId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    loadAllCourseData("");
  }

  @override
  void dispose() {
    allCourseDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<AllCourseDataEntity> allCourseDataStreamController =
      AppStreamController();

  final AppStreamController<List<DiscussionDataEntity>>
      discussionDataStreamController = AppStreamController();

  ///Load Course list
  void loadAllCourseData(String courseStatus) {
    if (!mounted) return;
    allCourseDataStreamController.add(LoadingState());
    getCourses(courseStatus).then((value) {
      if (value.error == null && value.data != null) {
        allCourseDataStreamController
            .add(DataLoadedState<AllCourseDataEntity>(value.data));
        if (value.data.running.isNotEmpty) {
          loadDiscussions(value.data.running.first.id);
        } else {
          allCourseDataStreamController.add(EmptyState(message: ''));
        }
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  ///Load Discussion list
  void loadDiscussions(int courseId) {
    if (!mounted) return;
    discussionDataStreamController.add(LoadingState());
    getDiscussions(courseId).then((value) {
      if (value.error == null && value.data.isNotEmpty) {
        discussionDataStreamController
            .add(DataLoadedState<List<DiscussionDataEntity>>(value.data));
      } else if (value.error == null && value.data.isEmpty) {
        discussionDataStreamController
            .add(EmptyState(message: 'No Discussions Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTap(int discussionId) {
    _view.navigateToDetailedDiscussionScreen(discussionId);
  }
}

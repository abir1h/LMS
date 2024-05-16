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
import '../../domain/entities/weekly_view_data_entity.dart';
import '../../domain/use_cases/discussion_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToModuleDiscussionScreen(int courseId, int courseModuleId);
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

  Future<ResponseEntity> getWeekWiseDiscussions(int courseId) async {
    return _discussionUseCase.getWeekWiseDiscussionsUseCase(courseId);
  }

  int _selectedTabIndex = 0;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    // loadDataList();
    loadAllCourseData("");
  }

  @override
  void dispose() {
    allCourseDataStreamController.dispose();
    stateDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<AllCourseDataEntity> allCourseDataStreamController =
      AppStreamController();

  final AppStreamController<List<DiscussionDataEntity>>
      discussionDataStreamController = AppStreamController();

  final AppStreamController<StateType> stateDataStreamController =
      AppStreamController();

  ///Load Course list
  void loadAllCourseData(String courseStatus) {
    if (!mounted) return;
    allCourseDataStreamController.add(LoadingState());
    getCourses(courseStatus).then((value) {
      if (value.error == null && value.data != null) {
        allCourseDataStreamController
            .add(DataLoadedState<AllCourseDataEntity>(value.data));
        if (value.data.running.isNotEmpty) {
          loadDataList(value.data.running.first.id);
        } else {
          allCourseDataStreamController.add(EmptyState(message: ''));
        }
      } else if (value.error == null && value.data == null) {
        allCourseDataStreamController
            .add(EmptyState(message: ""));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void loadDataList(int courseId) {
    if (!mounted) return;

    ///Loading state
    stateDataStreamController.add(LoadingState<StateType>());
    if (_selectedTabIndex == 0) {
      _weekWiseData(courseId);
    } else {
      _allDiscussionsData(courseId);
    }
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

  void _weekWiseData(int courseId) {
    getWeekWiseDiscussions(courseId).then((value) {
      if (_selectedTabIndex != 0) return;
      if (value.error == null && value.data != null) {
        stateDataStreamController.add(
            DataLoadedState<StateType>(WeeklyDiscussionDataState(value.data)));
      } else if (value.error == null && value.data == null) {
        stateDataStreamController
            .add(EmptyState(message: ""));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void _allDiscussionsData(int courseId) {
    getDiscussions(courseId).then((value) {
      if (_selectedTabIndex != 1) return;
      if (value.error == null && value.data != null) {
        stateDataStreamController.add(
            DataLoadedState<StateType>(AllDiscussionDataState(value.data)));
      } else if (value.error == null && value.data == null) {
        stateDataStreamController
            .add(EmptyState(message: ""));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTap(int discussionId) {
    _view.navigateToDetailedDiscussionScreen(discussionId);
  }

  void onTapWeek(int courseId, int courseModuleId) {
    _view.navigateToModuleDiscussionScreen(courseId, courseModuleId);
  }

  void onTabValueChange(int value, int courseId) {
    _selectedTabIndex = value;
    loadDataList(courseId);
  }
}

abstract class StateType {}

class WeeklyDiscussionDataState extends StateType {
  final List<WeeklyViewDataEntity> weeklyViewDataEntity;
  WeeklyDiscussionDataState(this.weeklyViewDataEntity);
}

class AllDiscussionDataState extends StateType {
  final List<DiscussionDataEntity> discussionDataEntity;
  AllDiscussionDataState(this.discussionDataEntity);
}

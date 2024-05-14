import 'package:flutter/material.dart';
import 'package:lms/src/feature/course/domain/entities/content_read_data_entity.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/course_data_source.dart';
import '../../data/repositories/course_repository_imp.dart';
import '../../domain/entities/blended_class_data_entity.dart';
import '../../domain/use_cases/course_use_case.dart';

abstract class _ViewModel {
  void showSuccess(String message);
  void showWarning(String message);
}

mixin CourseLiveClassScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final CourseUseCase _courseUseCase = CourseUseCase(
      courseRepository: CourseRepositoryImp(
          courseRemoteDataSource: CourseRemoteDataSourceImp()));

  Future<ResponseEntity> getBlendedDetails(int courseContentId) async {
    return _courseUseCase.getBlendedClassUseCase(courseContentId);
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

  Future<ResponseEntity> contentReadPost(
      int contentId,
      String contentType,
      int courseId,
      bool isCompleted,
      String lastWatchTime,
      String attendanceType) async {
    ResponseEntity responseEntity = await contentRead(contentId, contentType,
        courseId, isCompleted, lastWatchTime, attendanceType);
    if (responseEntity.error == null && responseEntity.data != null) {
      CustomToasty.of(context).releaseUI();
      _view.showSuccess(responseEntity.message!);
    } else {
      _view.showWarning(responseEntity.message!);
      CustomToasty.of(context).releaseUI();

    }
    return responseEntity;

    // CustomToasty.of(context).lockUI();
    // contentRead(contentId, contentType, courseId, isCompleted, lastWatchTime,
    //         attendanceType)
    //     .then((value) {
    //   if (value.error == null && value.data != null) {
    //     _view.showSuccess(value.message!);
    //     CustomToasty.of(context).releaseUI();
    //   } else {
    //     _view.showWarning(value.message!);
    //     CustomToasty.of(context).releaseUI();
    //   }
    // });
    return responseEntity;
  }

  // contentReadPost(int contentId, String contentType, int courseId,
  //     bool isCompleted, String lastWatchTime, String attendanceType) async {
  //   CustomToasty.of(context).lockUI();
  //   contentRead(contentId, contentType, courseId, isCompleted, lastWatchTime,
  //       attendanceType);
  //   CustomToasty.of(context).releaseUI();
  // }

  int _selectedTabIndex = 0;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    stateDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<StateType> stateDataStreamController =
      AppStreamController();

  ///Load data list from server based on selected tab
  void loadDataList(int courseContentId) {
    if (!mounted) return;

    ///Loading state
    stateDataStreamController.add(LoadingState<StateType>());
    if (_selectedTabIndex == 0) {
      _inPersonClassData(courseContentId);
    } else {
      _onlineClassData(courseContentId);
    }
  }

  void _inPersonClassData(int courseContentId) {
    getBlendedDetails(courseContentId).then((value) {
      if (_selectedTabIndex != 0) return;
      if (value.error == null && value.data != null) {
        stateDataStreamController.add(
            DataLoadedState<StateType>(InPersonClassDataState(value.data)));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void _onlineClassData(int courseContentId) {
    getBlendedDetails(courseContentId).then((value) {
      if (_selectedTabIndex != 1) return;
      if (value.error == null && value.data != null) {
        stateDataStreamController
            .add(DataLoadedState<StateType>(OnlineClassDataState(value.data)));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTabValueChange(int value, int courseContentId) {
    _selectedTabIndex = value;
    loadDataList(courseContentId);
  }
}

abstract class StateType {}

class InPersonClassDataState extends StateType {
  final BlendedClassDataEntity blendedClassDataEntity;
  InPersonClassDataState(this.blendedClassDataEntity);
}

class OnlineClassDataState extends StateType {
  final BlendedClassDataEntity blendedClassDataEntity;
  OnlineClassDataState(this.blendedClassDataEntity);
}

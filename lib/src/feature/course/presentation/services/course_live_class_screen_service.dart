import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/course_data_source.dart';
import '../../data/repositories/course_repository_imp.dart';
import '../../domain/entities/blended_class_data_entity.dart';
import '../../domain/use_cases/course_use_case.dart';

abstract class _ViewModel {
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

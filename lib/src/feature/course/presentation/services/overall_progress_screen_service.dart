import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';

abstract class _ViewModel {
  void showWarning(String message);
}

mixin OverallProgressScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  int _selectedTabIndex = 0;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    _loadDataList();
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
  void _loadDataList() {
    if (!mounted) return;

    ///Loading state
    stateDataStreamController.add(LoadingState<StateType>());
    if (_selectedTabIndex == 0) {
      _loadWeeklyData();
    } else {
      _loadOverallData();
    }
  }

  void _loadWeeklyData() {
    stateDataStreamController
        .add(DataLoadedState<StateType>(WeeklyDataState()));
  }

  void _loadOverallData() {
    stateDataStreamController
        .add(DataLoadedState<StateType>(OverallDataState()));
  }

  void onTabValueChange(int value) {
    _selectedTabIndex = value;
    _loadDataList();
  }
}

abstract class StateType {}

class WeeklyDataState extends StateType {
  // final ProfileDataEntity profileDataEntity;
  WeeklyDataState();
}

class OverallDataState extends StateType {
  // final ProgressDataEntity progressDataEntity;
  OverallDataState();
}

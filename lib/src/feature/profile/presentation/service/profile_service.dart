import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../data/data_sources/remote/profile_data_source.dart';
import '../../data/repositories/profile_repository_imp.dart';
import '../../domain/entities/profile_data_entity.dart';
import '../../domain/use_cases/profile_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
}

mixin ProfileService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final ProfileUseCase _profileUseCase = ProfileUseCase(
      profileRepository: ProfileRepositoryImp(
          profileRemoteDataSource: ProfileRemoteDataSourceImp()));

  Future<ResponseEntity> getProfileInformation() async {
    return _profileUseCase.userProfileInformationUseCase();
  }

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
      _loadProfileData();
    } else {
      _loadProgressData();
    }
  }

  ///Load Profile
  void _loadProfileData() {
    // if (!mounted) return;
    // profileDataStreamController.add(LoadingState());
    getProfileInformation().then((value) {
      if (_selectedTabIndex != 0) return;
      if (value.error == null && value.data != null) {
        stateDataStreamController
            .add(DataLoadedState<StateType>(ProfileDataState(value.data)));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  ///Load Progress data
  void _loadProgressData() {
    stateDataStreamController
        .add(DataLoadedState<StateType>(ProgressDataState()));
  }

  void onTabValueChange(int value) {
    _selectedTabIndex = value;
    _loadDataList();
  }
}

abstract class StateType {}

class ProfileDataState extends StateType {
  final ProfileDataEntity profileDataEntity;
  ProfileDataState(this.profileDataEntity);
}

class ProgressDataState extends StateType {
  // final ProgressDataEntity progressDataEntity;
  ProgressDataState(
      // this.progressDataEntity,
      );
}

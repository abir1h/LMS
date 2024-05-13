import 'package:flutter/material.dart';
import 'package:lms/src/feature/profile/domain/entities/all_progress_data_entity.dart';
import 'package:lms/src/feature/profile/domain/entities/user_info_data_entity.dart';

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

  Future<ResponseEntity> getProfileData() async {
    return _profileUseCase.getUserProfileInformationUseCase();
  }

  int _selectedTabIndex = 0;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    _loadHeader();
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
  final AppStreamController<AllProgressDataEntity> headerDataStreamController =
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
  late AllProgressDataEntity allProgressDataEntity;

  ///Load Profile
  void _loadHeader() {
      if (!mounted) return;
      headerDataStreamController.add(LoadingState());
      getProfileData().then((value) {
        if (value.error == null && value.data != null) {
          allProgressDataEntity = value.data;
          headerDataStreamController
              .add(DataLoadedState<AllProgressDataEntity>(value.data));
        } else if (value.error == null && value.data == null) {
        } else {
          _view.showWarning(value.message!);
        }
      });

  }

  void _loadProfileData() {
    // if (!mounted) return;
    // profileDataStreamController.add(LoadingState());
    getProfileData().then((value) {
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
    getProfileData().then((value) {
      if (_selectedTabIndex != 1) return;
      if (value.error == null && value.data != null) {
        stateDataStreamController
            .add(DataLoadedState<StateType>(ProgressDataState(value.data)));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTabValueChange(int value) {
    _selectedTabIndex = value;
    _loadDataList();
  }
}

abstract class StateType {}

class ProfileDataState extends StateType {
  final AllProgressDataEntity userInfoDataEntity;
  ProfileDataState(this.userInfoDataEntity);
}

class ProgressDataState extends StateType {
  final AllProgressDataEntity progressDataEntity;
  ProgressDataState(
    this.progressDataEntity,
  );
}

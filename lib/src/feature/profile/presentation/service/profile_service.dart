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

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    loadProfileData();
  }

  @override
  void dispose() {
    profileDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<ProfileDataEntity> profileDataStreamController =
      AppStreamController();

  ///Load Course list
  void loadProfileData() {
    if (!mounted) return;
    profileDataStreamController.add(LoadingState());
    getProfileInformation().then((value) {
      if (value.error == null && value.data != null) {
        profileDataStreamController
            .add(DataLoadedState<ProfileDataEntity>(value.data));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}

import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/dashboard_data_source.dart';
import '../../data/repositories/dashboard_repository_imp.dart';
import '../../domain/entities/dashboard_data_entity.dart';
import '../../domain/use_cases/dashboard_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToTranscriptVideoScreen();
  void navigateToCourseListScreen(String circularStatus);
  void navigateToLeaderBoardScreen();
}

mixin DashboardScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final DashboardUseCase _dashboardUseCase = DashboardUseCase(
      dashboardRepository: DashboardRepositoryImp(
          dashboardRemoteDataSource: DashboardRemoteDataSourceImp()));

  Future<ResponseEntity> getUserDashboard() async {
    return _dashboardUseCase.userDashboardUseCase();
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    loadDashboardData();
  }

  @override
  void dispose() {
    dashboardDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<DashboardDataEntity> dashboardDataStreamController =
      AppStreamController();

  ///Load Dashboard Data
  void loadDashboardData() {
    if (!mounted) return;
    dashboardDataStreamController.add(LoadingState());
    getUserDashboard().then((value) {
      if (value.error == null && value.data != null) {
        dashboardDataStreamController
            .add(DataLoadedState<DashboardDataEntity>(value.data));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTapRunningModule() {
    _view.navigateToTranscriptVideoScreen();
  }

  void onTapCard(String circularStatus) {
    _view.navigateToCourseListScreen(circularStatus);
  }

  void onTapSeeAll() {
    _view.navigateToLeaderBoardScreen();
  }
}

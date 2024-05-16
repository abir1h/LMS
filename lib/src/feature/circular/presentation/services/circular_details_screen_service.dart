import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../data/data_sources/remote/circular_data_source.dart';
import '../../data/repositories/circular_repository_imp.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/entities/circular_details_data_entity.dart';
import '../../domain/use_cases/circular_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToCourseDetailsScreen(int courseId, String circularStatus);
}

mixin CircularDetailsScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final CircularUseCase _circularUseCase = CircularUseCase(
      circularRepository: CircularRepositoryImp(
          circularRemoteDataSource: CircularRemoteDataSourceImp()));

  Future<ResponseEntity> getCircularDetails(int circularId) async {
    return _circularUseCase.getCircularDetailsUseCase(circularId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    circularDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<CircularDetailsDataEntity>
      circularDataStreamController = AppStreamController();

  ///Load Circular Details
  void loadAllCircularsData(int circularId) {
    if (!mounted) return;
    circularDataStreamController.add(LoadingState());
    getCircularDetails(circularId).then((value) {
      if (value.error == null && value.data != null) {
        circularDataStreamController
            .add(DataLoadedState<CircularDetailsDataEntity>(value.data));
      } else if (value.error == null && value.data == null) {
        circularDataStreamController
            .add(EmptyState(message: ""));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTap(int courseId, String circularStatus) {
    _view.navigateToCourseDetailsScreen(courseId, circularStatus);
  }
}

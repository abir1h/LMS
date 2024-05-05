import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../data/data_sources/remote/circular_data_source.dart';
import '../../data/repositories/circular_repository_imp.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/entities/all_circular_data_entity.dart';
import '../../domain/use_cases/circular_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToCircularDetailsScreen(int circularId);
}

mixin CircularScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final CircularUseCase _circularUseCase = CircularUseCase(
      circularRepository: CircularRepositoryImp(
          circularRemoteDataSource: CircularRemoteDataSourceImp()));

  Future<ResponseEntity> getCirculars() async {
    return _circularUseCase.getCircularsUseCase();
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    loadAllCircularsData();
  }

  @override
  void dispose() {
    allCircularDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<AllCircularDataEntity>
      allCircularDataStreamController = AppStreamController();

  ///Load Course list
  void loadAllCircularsData() {
    if (!mounted) return;
    allCircularDataStreamController.add(LoadingState());
    getCirculars().then((value) {
      if (value.error == null && value.data != null) {
        allCircularDataStreamController
            .add(DataLoadedState<AllCircularDataEntity>(value.data));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTapCircular(int circularId) {
    _view.navigateToCircularDetailsScreen(circularId);
  }
}

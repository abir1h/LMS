import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../assignment/data/data_sources/remote/assignment_data_source.dart';
import '../../../assignment/data/repositories/assignment_repository_imp.dart';
import '../../../assignment/domain/entities/assignment_data_entity.dart';
import '../../../assignment/domain/use_cases/assignment_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToAssignmentScreen(int courseContentId);
}

mixin CourseAssignmentScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final AssignmentUseCase _assignmentUseCase = AssignmentUseCase(
      assignmentRepository: AssignmentRepositoryImp(
          assignmentRemoteDataSource: AssignmentRemoteDataSourceImp()));

  Future<ResponseEntity> getAssignmentDetails(int courseContentId) async {
    return _assignmentUseCase.getAssignmentDetailsUseCase(courseContentId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    assignmentDetailsDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<AssignmentDataEntity>
      assignmentDetailsDataStreamController = AppStreamController();

  ///Load assessment details
  void loadAssignmentData(int courseContentId) {
    if (!mounted) return;
    assignmentDetailsDataStreamController.add(LoadingState());
    getAssignmentDetails(courseContentId).then((value) {
      if (value.error == null && value.data != null) {
        assignmentDetailsDataStreamController
            .add(DataLoadedState<AssignmentDataEntity>(value.data));
      } else if (value.error == null && value.data == null) {
        assignmentDetailsDataStreamController
            .add(EmptyState(message: ""));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTap(int courseContentId) {
    _view.navigateToAssignmentScreen(courseContentId);
  }
}

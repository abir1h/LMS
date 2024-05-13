import 'package:flutter/material.dart';
import 'package:lms/src/core/common_widgets/custom_toasty.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../assessment/data/data_sources/remote/assessment_data_source.dart';
import '../../../assessment/data/repositories/assessment_repository_imp.dart';
import '../../../assessment/domain/entities/assessment_data_entity.dart';
import '../../../assessment/domain/entities/exam_data_entity.dart';
import '../../../assessment/domain/use_cases/assessment_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void onTapExamDetailsScreen(ExamDataEntity data );
}

mixin CourseAssessmentScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final AssessmentUseCase _assessmentUseCase = AssessmentUseCase(
      assessmentRepository: AssessmentRepositoryImp(
          assessmentRemoteDataSource: AssessmentRemoteDataSourceImp()));

  Future<ResponseEntity> getAssessmentDetails(int courseContentId) async {
    return _assessmentUseCase.getAssessmentDetailsUseCase(courseContentId);
  }

  Future<ResponseEntity> startExam(int circularAssessmentId) async {
    return _assessmentUseCase.startExamUseCase(circularAssessmentId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    assessmentDetailsDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<AssessmentDataEntity>
      assessmentDetailsDataStreamController = AppStreamController();

  ///Load assessment details
  void loadAssessmentData(int courseContentId) {
    if (!mounted) return;
    assessmentDetailsDataStreamController.add(LoadingState());
    getAssessmentDetails(1).then((value) {
      if (value.error == null && value.data != null) {
        assessmentDetailsDataStreamController
            .add(DataLoadedState<AssessmentDataEntity>(value.data));
      } else if (value.error == null && value.data == null) {
        _view.showWarning(value.message!);
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTapStartExam(int circularAssessmentId) {
    if (!mounted) return;
    CustomToasty.of(context).lockUI();
    startExam(circularAssessmentId).then((value) {
      CustomToasty.of(context).releaseUI();
      if (value.error == null && value.data != null) {
        _view.onTapExamDetailsScreen(value.data);
      } else if (value.error == null && value.data == null) {
        _view.showWarning(value.message!);
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}

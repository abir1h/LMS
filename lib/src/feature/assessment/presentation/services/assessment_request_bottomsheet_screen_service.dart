import 'package:flutter/material.dart';

import '../../../../core/utility/validator.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/assessment_data_source.dart';
import '../../data/repositories/assessment_repository_imp.dart';
import '../../domain/use_cases/assessment_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin AssessmentRequestBottomSheetScreenService<T extends StatefulWidget>
    on State<T> implements _ViewModel {
  late _ViewModel _view;

  final AssessmentUseCase _assessmentUseCase = AssessmentUseCase(
      assessmentRepository: AssessmentRepositoryImp(
          assessmentRemoteDataSource: AssessmentRemoteDataSourceImp()));

  Future<ResponseEntity> requestExam(
      int circularAssessmentId, String remarks) async {
    return _assessmentUseCase.requestExamUseCase(circularAssessmentId, remarks);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool validateFormData(TextEditingController remarksController) {
    if (Validator.isEmpty(remarksController.text.trim())) {
      _view.showWarning("Remarks is required!");
      return false;
    } else {
      return true;
    }
  }

  Future<ResponseEntity> onRequestExam(
      {required int circularAssessmentId, required String remarks}) async {
    ResponseEntity responseEntity =
        await requestExam(circularAssessmentId, remarks);
    if (responseEntity.error == null && responseEntity.data != null) {
      _view.showSuccess(responseEntity.message!);
    } else {
      _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }
}

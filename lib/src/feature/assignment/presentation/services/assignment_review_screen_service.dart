import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/utility/validator.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/assignment_data_source.dart';
import '../../data/repositories/assignment_repository_imp.dart';
import '../../domain/entities/collaborative_accept_review_data_entity.dart';
import '../../domain/use_cases/assignment_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin AssignmentReviewScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final AssignmentUseCase _assignmentUseCase = AssignmentUseCase(
      assignmentRepository: AssignmentRepositoryImp(
          assignmentRemoteDataSource: AssignmentRemoteDataSourceImp()));

  Future<ResponseEntity> getAcceptReview(int traineeId) async {
    return _assignmentUseCase.getAcceptReviewUseCase(traineeId);
  }

  Future<ResponseEntity> reviewResultSubmit(
    int assignmentSubId,
    int resultId,
    String markObtained,
  ) async {
    return _assignmentUseCase.reviewResultSubmitUseCase(
        assignmentSubId, resultId, markObtained);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    acceptReviewDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<CollaborativeAcceptReviewDataEntity>
      acceptReviewDataStreamController = AppStreamController();

  ///Load  details
  void loadReviewData(int traineeId) {
    if (!mounted) return;
    acceptReviewDataStreamController.add(LoadingState());
    getAcceptReview(traineeId).then((value) {
      if (value.error == null && value.data != null) {
        acceptReviewDataStreamController.add(
            DataLoadedState<CollaborativeAcceptReviewDataEntity>(value.data));
      } else if (value.error == null && value.data == null) {
        acceptReviewDataStreamController.add(EmptyState(message: ""));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  Future<ResponseEntity> onReviewResultSubmit(
      {required int assignmentSubId,
      required int resultId,
      required String markObtained}) async {
    ResponseEntity responseEntity =
        await reviewResultSubmit(assignmentSubId, resultId, markObtained);
    if (responseEntity.error == null && responseEntity.data != null) {
      _view.showSuccess(responseEntity.message!);
    } else {
      _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }

  bool validateFormData(TextEditingController discussionController) {
    if (Validator.isEmpty(discussionController.text.trim())) {
      _view.showWarning("Description is required!");
      return false;
    } else {
      return true;
    }
  }
}
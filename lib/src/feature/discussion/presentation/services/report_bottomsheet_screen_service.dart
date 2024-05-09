import 'package:flutter/material.dart';

import '../../../../core/utility/validator.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/discussion_data_source.dart';
import '../../data/repositories/discussion_repository_imp.dart';
import '../../domain/use_cases/discussion_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin ReportBottomSheetScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final DiscussionUseCase _discussionUseCase = DiscussionUseCase(
      discussionRepository: DiscussionRepositoryImp(
          discussionRemoteDataSource: DiscussionRemoteDataSourceImp()));

  Future<ResponseEntity> reportDiscussion(
      int discussionId, String remarks) async {
    return _discussionUseCase.reportDiscussionUseCase(discussionId, remarks);
  }

  Future<ResponseEntity> reportComment(int commentId, String remarks) async {
    return _discussionUseCase.reportCommentUseCase(commentId, remarks);
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

  bool validateFormData(TextEditingController titleController) {
    if (Validator.isEmpty(titleController.text.trim())) {
      _view.showWarning("Description is required!");
      return false;
    } else {
      return true;
    }
  }

  Future<ResponseEntity> onReportDiscussion(
      {required int discussionId, required String remarks}) async {
    ResponseEntity responseEntity =
        await reportDiscussion(discussionId, remarks);
    if (responseEntity.error == null && responseEntity.data != null) {
      _view.showSuccess(responseEntity.message!);
    } else {
      _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }

  Future<ResponseEntity> onReportComment(
      {required int commentId, required String remarks}) async {
    ResponseEntity responseEntity = await reportComment(commentId, remarks);
    if (responseEntity.error == null && responseEntity.data != null) {
      _view.showSuccess(responseEntity.message!);
    } else {
      _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }
}

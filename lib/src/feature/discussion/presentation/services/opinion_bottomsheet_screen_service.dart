import 'package:flutter/material.dart';

import '../../../../core/utility/validator.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/discussion_data_source.dart';
import '../../data/repositories/discussion_repository_imp.dart';
import '../../domain/use_cases/discussion_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void onSuccessRequest();
}

mixin OpinionBottomSheetScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final DiscussionUseCase _discussionUseCase = DiscussionUseCase(
      discussionRepository: DiscussionRepositoryImp(
          discussionRemoteDataSource: DiscussionRemoteDataSourceImp()));

  Future<ResponseEntity> createComment(
      int discussionId, String description) async {
    return _discussionUseCase.createCommentUseCase(discussionId, description);
  }

  Future<ResponseEntity> updateComment(
      int commentId, String description) async {
    return _discussionUseCase.updateCommentUseCase(commentId, description);
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

  Future onCommentCreate(
      {required int discussionId, required String description}) async {
    ResponseEntity responseEntity =
        await createComment(discussionId, description);
    if (responseEntity.error == null && responseEntity.data != null) {
      _view.showSuccess(responseEntity.message!);
      _view.onSuccessRequest();
    } else {
      _view.showWarning(responseEntity.message!);
    }
  }

  Future onCommentUpdate(
      {required int commentId, required String description}) async {
    ResponseEntity responseEntity = await updateComment(commentId, description);
    if (responseEntity.error == null && responseEntity.data != null) {
      _view.showSuccess(responseEntity.message!);
      _view.onSuccessRequest();
    } else {
      _view.showWarning(responseEntity.message!);
    }
  }
}

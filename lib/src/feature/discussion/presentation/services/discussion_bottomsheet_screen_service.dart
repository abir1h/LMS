import 'package:flutter/material.dart';

import '../../../../core/utility/validator.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/discussion_data_source.dart';
import '../../data/repositories/discussion_repository_imp.dart';
import '../../domain/entities/discussion_data_entity.dart';
import '../../domain/use_cases/discussion_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin DiscussionBottomSheetScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final DiscussionUseCase _discussionUseCase = DiscussionUseCase(
      discussionRepository: DiscussionRepositoryImp(
          discussionRemoteDataSource: DiscussionRemoteDataSourceImp()));

  Future<ResponseEntity> createDiscussions(
      {required int courseId,
      required int courseModuleId,
      required int contentId,
      required String contentType,
      required String description}) async {
    return _discussionUseCase.createDiscussionUseCase(
        courseId, courseModuleId, contentId, contentType, description);
  }

  Future<ResponseEntity> updateDiscussions(
      {required int discussionId, required String description}) async {
    return _discussionUseCase.updateDiscussionUseCase(
        discussionId, description);
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

  // bool validateFormData(
  //     TextEditingController authorNameController,
  //     TextEditingController bookNameController,
  //     TextEditingController publishYearController,
  //     TextEditingController editionController) {
  //   if (Validator.isEmpty(authorNameController.text.trim())) {
  //     _view.showWarning("Author name is required!");
  //     return false;
  //   } else if (!Validator.isValidLength(
  //       authorNameController.text.trim(), 3, 100)) {
  //     _view.showWarning("Author name is required at least 3 character!");
  //     return false;
  //   } else if (Validator.isValidString(authorNameController.text.trim())) {
  //     _view.showWarning("Special character is not allowed");
  //     return false;
  //   } else if (Validator.isEmpty(bookNameController.text.trim())) {
  //     _view.showWarning("Book name is required!");
  //     return false;
  //   } else if (!Validator.isValidLength(
  //       bookNameController.text.trim(), 3, 100)) {
  //     _view.showWarning("Book name is required at least 3 character!");
  //     return false;
  //   } else if (Validator.isValidString(bookNameController.text.trim())) {
  //     _view.showWarning("Special character is not allowed");
  //     return false;
  //   } else if (Validator.isEmpty(publishYearController.text.trim())) {
  //     _view.showWarning("Publish year is required!");
  //     return false;
  //   } else if (Validator.isEmpty(editionController.text.trim())) {
  //     _view.showWarning("Edition is required!");
  //     return false;
  //   } else if (!Validator.isValidLength(
  //       editionController.text.trim(), 3, 100)) {
  //     _view.showWarning("Edition is required at least 3 character!");
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  Future<ResponseEntity> onDiscussionCreate(
      {required int courseId,
      required int courseModuleId,
      required int contentId,
      required String contentType,
      required String description}) async {
    ResponseEntity responseEntity = await createDiscussions(
        courseId: courseId,
        courseModuleId: courseModuleId,
        contentId: contentId,
        contentType: contentType,
        description: description);
    if (responseEntity.error == null && responseEntity.data != null) {
      _view.showSuccess(responseEntity.message!);
    } else {
      _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }

  Future<ResponseEntity> onDiscussionUpdate(
      {required int discussionId, required String description}) async {
    ResponseEntity responseEntity = await updateDiscussions(
        discussionId: discussionId, description: description);
    if (responseEntity.error == null && responseEntity.data != null) {
      _view.showSuccess(responseEntity.message!);
    } else {
      _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }
}

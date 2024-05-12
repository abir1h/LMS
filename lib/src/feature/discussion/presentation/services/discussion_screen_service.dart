import 'package:flutter/material.dart';

import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/discussion_data_source.dart';
import '../../data/repositories/discussion_repository_imp.dart';
import '../../domain/use_cases/discussion_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin DiscussionScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final DiscussionUseCase _discussionUseCase = DiscussionUseCase(
      discussionRepository: DiscussionRepositoryImp(
          discussionRemoteDataSource: DiscussionRemoteDataSourceImp()));

  Future<ResponseEntity> getDiscussions(int courseId) async {
    return _discussionUseCase.getDiscussionsUseCase(courseId);
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
}

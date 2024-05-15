import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/discussion_data_source.dart';
import '../../data/repositories/discussion_repository_imp.dart';
import '../../domain/entities/discussion_data_entity.dart';
import '../../domain/use_cases/discussion_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToDetailedDiscussionScreen(int discussionId);
}

mixin ModuleDiscussionsScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final DiscussionUseCase _discussionUseCase = DiscussionUseCase(
      discussionRepository: DiscussionRepositoryImp(
          discussionRemoteDataSource: DiscussionRemoteDataSourceImp()));

  Future<ResponseEntity> getDiscussions(
      int courseId, int courseModuleId) async {
    return _discussionUseCase.getWeekWiseDiscussionsDetailsUseCase(
        courseId, courseModuleId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    discussionDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers

  final AppStreamController<List<DiscussionDataEntity>>
      discussionDataStreamController = AppStreamController();

  ///Load Discussion list
  void loadDiscussions(int courseId, int courseModuleId) {
    if (!mounted) return;
    discussionDataStreamController.add(LoadingState());
    getDiscussions(courseId, courseModuleId).then((value) {
      if (value.error == null && value.data.isNotEmpty) {
        discussionDataStreamController
            .add(DataLoadedState<List<DiscussionDataEntity>>(value.data));
      } else if (value.error == null && value.data.isEmpty) {
        discussionDataStreamController
            .add(EmptyState(message: 'No Discussions Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTap(int discussionId) {
    _view.navigateToDetailedDiscussionScreen(discussionId);
  }
}

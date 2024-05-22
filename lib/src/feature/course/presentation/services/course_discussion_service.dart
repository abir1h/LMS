import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/utility/app_label.dart';
import '../../../discussion/data/data_sources/remote/discussion_data_source.dart';
import '../../../discussion/data/repositories/discussion_repository_imp.dart';
import '../../../discussion/domain/entities/discussion_data_entity.dart';
import '../../../discussion/domain/use_cases/discussion_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToDetailedDiscussionScreen(int discussionId);
}

mixin CourseDiscussionWidgetService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final DiscussionUseCase _discussionUseCase = DiscussionUseCase(
      discussionRepository: DiscussionRepositoryImp(
          discussionRemoteDataSource: DiscussionRemoteDataSourceImp()));

  Future<ResponseEntity> getDiscussions(int courseId, int courseModuleId,
      int contentId, String contentType) async {
    return _discussionUseCase.getDiscussionsByContentUseCase(
        courseId, courseModuleId, contentId, contentType);
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

  ///Discussion list
  void loadDiscussionList(
      int courseId, int courseModuleId, int contentId, String contentType) {
    if (!mounted) return;
    discussionDataStreamController.add(LoadingState());
    getDiscussions(courseId, courseModuleId, contentId, contentType)
        .then((value) {
      if (value.error == null && value.data.isNotEmpty) {
        discussionDataStreamController
            .add(DataLoadedState<List<DiscussionDataEntity>>(value.data));
      } else if (value.error == null && value.data.isEmpty) {
        discussionDataStreamController
            .add(EmptyState(message:  label(e: "No Discussions Found", b: "কোন আলোচনা পাওয়া যায়নি"),));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTapCourse(int discussionId) {
    _view.navigateToDetailedDiscussionScreen(discussionId);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/discussion_data_source.dart';
import '../../data/repositories/discussion_repository_imp.dart';
import '../../domain/entities/comment_data_entity.dart';
import '../../domain/entities/discussion_data_entity.dart';
import '../../domain/use_cases/discussion_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin DetailedDiscussionService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final DiscussionUseCase _discussionUseCase = DiscussionUseCase(
      discussionRepository: DiscussionRepositoryImp(
          discussionRemoteDataSource: DiscussionRemoteDataSourceImp()));

  Future<ResponseEntity> getDiscussionComments(int discussionId) async {
    return _discussionUseCase.getDiscussionDetailsUseCase(discussionId);
  }

  Future<ResponseEntity> voteDiscussions(int discussionId) async {
    return _discussionUseCase.voteDiscussionUseCase(discussionId);
  }

  Future<ResponseEntity> voteComments(int commentId) async {
    return _discussionUseCase.voteCommentUseCase(commentId);
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
  final AppStreamController<DiscussionDataEntity>
      discussionDataStreamController = AppStreamController();

  late DiscussionDataEntity discussionDataEntity;

  ///Load Discussion details
  void loadDiscussionData(int discussionId) {
    if (!mounted) return;
    discussionDataStreamController.add(LoadingState());
    getDiscussionComments(discussionId).then((value) {
      if (value.error == null && value.data != null) {
        discussionDataEntity = value.data;
        discussionDataStreamController
            .add(DataLoadedState<DiscussionDataEntity>(value.data));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTapVoteDiscussion(int discussionId) {
    voteDiscussions(discussionId).then((value) {
      if (value.error == null && value.data != null) {
        discussionDataEntity.vote = value.data.vote;
        discussionDataStreamController
            .add(DataLoadedState<DiscussionDataEntity>(discussionDataEntity));
        _view.showSuccess(value.message!);
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTapVoteComment(int commentId) {
    voteComments(commentId).then((value) {
      if (value.error == null && value.data != null) {
        discussionDataEntity.comments
            .singleWhere((element) => element.id == value.data.id)
            .vote = value.data.vote;
        discussionDataStreamController
            .add(DataLoadedState<DiscussionDataEntity>(discussionDataEntity));
        _view.showSuccess(value.message!);
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}

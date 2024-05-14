import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../course/data/data_sources/remote/course_data_source.dart';
import '../../../course/data/repositories/course_repository_imp.dart';
import '../../../course/domain/entities/video_data_entity.dart';
import '../../../course/domain/use_cases/course_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void setVideo(String url, String category);
}

mixin TranscriptScreenVideoService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final CourseUseCase _courseUseCase = CourseUseCase(
      courseRepository: CourseRepositoryImp(
          courseRemoteDataSource: CourseRemoteDataSourceImp()));

  Future<ResponseEntity> getVideoDetails(int courseContentId) async {
    return _courseUseCase.getVideoDetailsUseCase(courseContentId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    videoDetailsDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<VideoDataEntity> videoDetailsDataStreamController =
      AppStreamController();

  ///Load Video details
  void loadVideoData(int courseContentId) {
    if (!mounted) return;
    videoDetailsDataStreamController.add(LoadingState());
    getVideoDetails(courseContentId).then((value) {
      if (value.error == null && value.data != null && value.data.videoData != null) {
        videoDetailsDataStreamController
            .add(DataLoadedState<VideoDataEntity>(value.data.videoData));
        _view.setVideo(value.data.videoData.videoUrl, value.data.videoData.category);
      } else if (value.error == null && value.data == null) {
        _view.showWarning(value.message!);
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}

import 'package:flutter/material.dart';
import '../../data/repositories/video_repository_imp.dart';
import '../../domain/use_cases/video_use_case.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../course/domain/entities/video_content_data_entity.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../course/data/data_sources/remote/course_data_source.dart';
import '../../../course/data/repositories/course_repository_imp.dart';
import '../../../course/domain/entities/video_qustion_data_entity.dart';
import '../../../course/domain/use_cases/course_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/video_data_source.dart';
import '../screens/transcript_video_screen.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToBack();
  bool isPlayerFullscreen();
  void changeOrientationToPortrait();
  void setYoutubeVideo(String url);
}

mixin TranscriptScreenVideoService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  late CourseVideoScreenArgs screenArgs;
  int currentPlayedPositionSec = 0;
  bool showOverlay = false;

  final CourseUseCase _courseUseCase = CourseUseCase(
      courseRepository: CourseRepositoryImp(
          courseRemoteDataSource: CourseRemoteDataSourceImp()));
  final VideoUseCase _videoUseCase = VideoUseCase(
      videoRepository: VideoRepositoryImp(
          videoRemoteDataSource: VideoRemoteDataSourceImp()));

  Future<ResponseEntity> getVideoDetails(int courseContentId) async {
    return _courseUseCase.getVideoDetailsUseCase(courseContentId);
  }

  Future<ResponseEntity> contentRead(
      int contentId,
      String contentType,
      int courseId,
      bool isCompleted,
      String lastWatchTime,
      String attendanceType) async {
    return _courseUseCase.contentReadUseCase(contentId, contentType, courseId,
        isCompleted, lastWatchTime, attendanceType);
  }

  Future<ResponseEntity> videoActivity(int circularVideoId, int lastWatchTime,
      List<int> questionSeenList) async {
    return _videoUseCase.videoActivityUseCase(
        circularVideoId, lastWatchTime, questionSeenList);
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
    playbackPausePlayStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<VideoContentDataEntity>
      videoDetailsDataStreamController = AppStreamController();
  final AppStreamController<bool> playbackPausePlayStreamController =
      AppStreamController();

  final AppStreamController<VideoQuestionDataEntity>
      videoQuestionDataStreamController = AppStreamController();

  ///Load Video details
  void loadVideoData(int courseContentId) {
    if (!mounted) return;
    videoDetailsDataStreamController.add(LoadingState());
    getVideoDetails(courseContentId).then((value) {
      if (value.error == null &&
          value.data != null &&
          value.data.videoData != null) {
        videoDetailsDataStreamController
            .add(DataLoadedState<VideoContentDataEntity>(value.data));
        if (value.data.videoData.category != VideoCategory.s3.name) {
          _view.setYoutubeVideo(value.data.videoData.videoUrl);
        }
      } else if (value.error == null && value.data == null) {
        _view.showWarning(value.message!);
        videoDetailsDataStreamController.add(EmptyState(message: ""));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  ///Change video playback orientation
  Future<bool> onGoBack() async {
    if (_view.isPlayerFullscreen()) {
      _view.changeOrientationToPortrait();
    }
    _view.navigateToBack();
    return Future.value(false);
  }

  void onPlaybackProgressChanged(VideoContentDataEntity currentContent,
      double playedPosition, double totalDuration) {
    int playedPositionSec = (playedPosition ~/ 1000).round();
    if (currentPlayedPositionSec != playedPositionSec) {
      currentPlayedPositionSec = playedPositionSec;
      VideoQuestionDataEntity? questionData = currentContent.videoQuestion
          ?.singleWhere(
              (element) => element.popUpTimeSecond == playedPositionSec,
              orElse: () => VideoQuestionDataEntity(
                    id: -1,
                    videoId: -1,
                    questionText: "",
                    popUpTimeSecond: 0,
                    message: false,
                    seen: false,
                    choices: [],
                  ));
      if (questionData?.id != -1 && questionData?.seen == false) {
        debugPrint("pop question");
        showOverlay = true;
        AppEventsNotifier.notify(EventAction.videoWidget);
        videoQuestionDataStreamController
            .add(DataLoadedState<VideoQuestionDataEntity>(questionData!));
        playbackPausePlayStreamController.add(DataLoadedState<bool>(false));
      }
    }
    if (screenArgs.data.lastWatchTime < playedPositionSec) {
      screenArgs.data.lastWatchTime =
          screenArgs.data.lastWatchTime < playedPositionSec
              ? playedPositionSec
              : screenArgs.data.lastWatchTime;
    }
  }

  void onSkipInteractiveAction() {
    showOverlay = false;
    AppEventsNotifier.notify(EventAction.videoWidget);
    playbackPausePlayStreamController.add(DataLoadedState<bool>(true));
  }
}

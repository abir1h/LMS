import 'package:flutter/material.dart';
import 'package:lms/src/feature/course/domain/entities/video_content_data_entity.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../course/data/data_sources/remote/course_data_source.dart';
import '../../../course/data/repositories/course_repository_imp.dart';
import '../../../course/domain/entities/video_data_entity.dart';
import '../../../course/domain/use_cases/course_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
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
    playbackPausePlayStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<VideoContentDataEntity> videoDetailsDataStreamController =
      AppStreamController();
  final AppStreamController<bool> playbackPausePlayStreamController =
      AppStreamController();

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

  ///Video playback section
  // void _onPlayVideo(VideoDataEntity content) async {
  //   ///Activate player widget
  //   playerActivationStreamController
  //       .add(DataLoadedState<ActivePlayerType>(content.rawUrl.isNotEmpty
  //       ? ActivePlayerType.solidVidePlayer
  //       : content.youtubeUrl.isNotEmpty
  //       ? ActivePlayerType.youtubePlayer
  //       : ActivePlayerType.none));
  //   // Wakelock.enable();
  //   var videoContent = VideoContentViewModel.fromJson(content.toJson());
  //   playerStreamController
  //       .add(DataLoadedState<VideoContentViewModel>(videoContent));
  // }

  //player related code
  // double onInterceptPlaybackSeekToPosition(VideoDataEntity currentContent,
  //     double seekPosition, double totalDuration) {
  //   /// seekIntercept logic
  //   return currentContent.playedDurationTimeSec * 1000 >= seekPosition
  //       ? seekPosition
  //       : (currentContent.playedDurationTimeSec * 1000).toDouble();
  // }

  // void onPlaybackProgressChanged(VideoDataEntity currentContent,
  //     double playedPosition, double totalDuration) {
  //   ///Update last played position only if played position is larger
  //   int playedPositionSec = (playedPosition ~/ 1000).round();
  //   _watchSession.lastPlayedDuration = playedPositionSec;
  //   // if (currentContent.playedDurationTimeSec < playedPositionSec) {
  //   currentContent.playedDurationTimeSec = currentContent.playedDurationTimeSec < playedPositionSec?playedPositionSec:currentContent.playedDurationTimeSec;
  //   // if (playedPositionSec % 5 == 0) {
  //   _watchSession = VideoWatchSession(
  //       id: currentContent.id,
  //       classId: currentContent.classId,
  //       chapterId: currentContent.chapterId,
  //       totalDuration: currentContent.videoDurationSecond,
  //       guid: _watchSession.guid.isEmpty ? _guid : _watchSession.guid,
  //       playedDuration: currentContent.playedDurationTimeSec,
  //       startTime: '',
  //       endTime: '',
  //       lastPlayedDuration: _watchSession.lastPlayedDuration);
  //   _storeActualWatchedSession();
  //   // } else if (playedPositionSec == currentContent.videoDurationSecond) {
  //   //   _watchSession = VideoWatchSession(
  //   //       id: currentContent.id,
  //   //       classId: currentContent.classId,
  //   //       chapterId: currentContent.chapterId,
  //   //       totalDuration: currentContent.videoDurationSecond,
  //   //       guid: _watchSession.guid.isEmpty ? _guid : _watchSession.guid,
  //   //       playedDuration: currentContent.playedDurationTimeSec,
  //   //       startTime: '',
  //   //       endTime: '',
  //   //       lastPlayedDuration: _watchSession.lastPlayedDuration);
  //   //     _storeActualWatchedSession();
  //   // }
  //   // }
  // }
}

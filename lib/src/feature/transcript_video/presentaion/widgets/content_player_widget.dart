import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../course/domain/entities/video_data_entity.dart';
import 'video_player.dart';


class ContentPlayerWidget extends StatefulWidget {
  final Stream<DataState<VideoDataEntity>> playerStream;
  final Stream<DataState<bool>> playbackStream;
  final Widget? overlay;

  final double Function(VideoDataEntity currentContent,
      double seekPosition, double totalDuration)? interceptSeekTo;
  final void Function(VideoDataEntity currentContent,
      double playedPosition, double totalDuration)? onProgressChanged;

  const ContentPlayerWidget({
    Key? key,
    required this.playerStream,
    required this.playbackStream,
    this.overlay,
    this.interceptSeekTo,
    this.onProgressChanged,
  }) : super(key: key);

  @override
  State<ContentPlayerWidget> createState() => _CustomPlayerWidgetState();
}

class _CustomPlayerWidgetState extends State<ContentPlayerWidget> {
  final ContentVideoPlayerController _playerController = ContentVideoPlayerController();

  // VideoDataEntity _currentContent = VideoContentViewModel.empty();
  late VideoDataEntity _currentContent;
  StreamSubscription<DataState<VideoDataEntity>>? _subscription;
  StreamSubscription<DataState<bool>>? _playbackSubscription;

  @override
  void initState() {
    _playerController.interceptSeekTo = _interceptSeekTo;
    _playerController.onProgressChange = _onProgressChanged;
    _subscription = widget.playerStream.listen(_onPlayVideo);
    _playbackSubscription = widget.playbackStream.listen(_onPlaybackChange);
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _playerController.dispose();
    _playbackSubscription?.cancel();
    super.dispose();
  }

  void _onPlayVideo(DataState<VideoDataEntity> event) {
    if (!mounted) return;
    _currentContent = (event as DataLoadedState<VideoDataEntity>).data;
    _playerController.play(
      getVideoFileUrl("http://116.204.155.53/${_currentContent.videoUrl}"),
      autoPlay: true,
      playPosition:const Duration(seconds: 0)
      // playPosition:Duration(seconds: _currentContent.lastPlayedDurationTimeSec)
      // _currentContent.playedDurationTimeSec < _currentContent.videoDurationSecond
      //     ? Duration(seconds: _currentContent.playedDurationTimeSec)
      //     : null,
    );
  }

  void _onPlaybackChange(DataState<bool> event) {
    var data = (event as DataLoadedState<bool>).data;
    if (data) {
      _playerController.resume();
    } else {
      _playerController.pause();
    }
  }

  double _interceptSeekTo(double seekPosition, double totalDuration) {
    return widget.interceptSeekTo
        ?.call(_currentContent, seekPosition, totalDuration) ??
        seekPosition;
  }

  void _onProgressChanged(double playedPosition, double totalDuration) {
    widget.onProgressChanged
        ?.call(_currentContent, playedPosition, totalDuration);
  }

  @override
  Widget build(BuildContext context) {
    return CustomVideoPlayer(
      controller: _playerController,
      overlay: Align(alignment: Alignment.topLeft, child: widget.overlay),
    );
  }
}

String getVideoFileUrl(String filePath) {
  if (filePath.isEmpty) return "";
  return filePath;
}


// class VideoContentViewModel extends ContentEntity{
//   VideoContentViewModel.fromJson(Map<String, dynamic> json) : super.fromJson(json);
//   VideoContentViewModel.empty() : super.empty();
// }
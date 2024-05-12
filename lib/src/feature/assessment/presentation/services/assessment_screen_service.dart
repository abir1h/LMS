import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lms/src/feature/assessment/domain/entities/exam_data_entity.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/routes/app_route_args.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin AssessmentScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  ///Screen args
  late AssessmentScreenArgs screenArgs;
  late Timer _examTimer;
  late DateTime _examStartTime;

  ///Stream Controllers
  final AppStreamController<PageState> pageStateStreamController =
      AppStreamController();
  final BehaviorSubject<Duration> timerStreamController = BehaviorSubject();

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    ///Initialized timer
    _examStartTime = DateTime.now();
    _examTimer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {_onTimerTick(_examTimer);});
  }
  @override
  void dispose() {
    pageStateStreamController.dispose();
    timerStreamController.close();
    _examTimer.cancel();
    super.dispose();
  }

  ///Set screen args and load questions
  void initService(AssessmentScreenArgs args) {
    if(!mounted) return;
    ///Loading state
    pageStateStreamController.add(LoadingState<PageState>());
    screenArgs = args;
    pageStateStreamController
        .add(DataLoadedState<PageState>(ExamRunningState(screenArgs.examData)));
  }
  void _onTimerTick(Timer timer) {
    ///Exam started
    var elapsedTime = DateTime.now().difference(_examStartTime);
    var remaining = Duration(minutes: screenArgs.examData.assessment!.totalTime) - elapsedTime;
    timerStreamController.sink.add(remaining);

    ///Exam expired check
    if(remaining.inSeconds <= 0){
      _examTimer.cancel();
      // widget.onTimeExpired(widget.data,widget.overview,_examStartTime,DateTime.now());
    }
  }
}

abstract class PageState {}

class ExamRunningState extends PageState {
  final ExamDataEntity examData;
  ExamRunningState(this.examData);
}

class TimeExpiredState extends PageState {
  final ExamDataEntity questions;
  final bool shouldShowAnswerSheet;
  final DateTime startTime;
  final DateTime endTime;
  TimeExpiredState(
      this.questions, this.shouldShowAnswerSheet, this.startTime, this.endTime);
}

class AnswerSubmittedState extends PageState {
  AnswerSubmittedState();
}

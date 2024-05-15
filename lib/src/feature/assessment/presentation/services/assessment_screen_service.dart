import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lms/src/feature/assessment/domain/entities/exam_data_entity.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/assessment_data_source.dart';
import '../../data/repositories/assessment_repository_imp.dart';
import '../../domain/use_cases/assessment_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin AssessmentScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final AssessmentUseCase _assessmentUseCase = AssessmentUseCase(
      assessmentRepository: AssessmentRepositoryImp(
          assessmentRemoteDataSource: AssessmentRemoteDataSourceImp()));

  Future<ResponseEntity> onSubmit(ExamDataEntity examDataEntity) async {
    return _assessmentUseCase.submitExamUseCase(examDataEntity);
  }

  ///Screen args
  late AssessmentScreenArgs screenArgs;
  late Timer examTimer;
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
    examTimer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onTimerTick(examTimer);
    });
  }

  @override
  void dispose() {
    pageStateStreamController.dispose();
    timerStreamController.close();
    examTimer.cancel();
    super.dispose();
  }

  ///Set screen args and load questions
  void initService(AssessmentScreenArgs args) {
    if (!mounted) return;

    ///Loading state
    pageStateStreamController.add(LoadingState<PageState>());
    screenArgs = args;
    pageStateStreamController
        .add(DataLoadedState<PageState>(ExamRunningState(screenArgs.examData)));
  }

  void _onTimerTick(Timer timer) {
    ///Exam started
    var elapsedTime = DateTime.now().difference(_examStartTime);
    var remaining =
        Duration(minutes: screenArgs.examData.assessment!.totalTime) -
            elapsedTime;
    timerStreamController.sink.add(remaining);

    ///Exam expired check
    if (remaining.inSeconds <= 0) {
      examTimer.cancel();
      // widget.onTimeExpired(widget.data,widget.overview,_examStartTime,DateTime.now());
    }
  }

  Future<ResponseEntity> onSubmitExam(ExamDataEntity examDataEntity) async {
    ResponseEntity responseEntity = await onSubmit(examDataEntity);
    if (responseEntity.error == null && responseEntity.data != null) {
      _view.showSuccess(responseEntity.message!);
    } else {
      _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }

  void onExamResultSubmitted(ExamDataEntity data) {
    pageStateStreamController
        .add(DataLoadedState<PageState>(AnswerSubmittedState(data)));
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
  final ExamDataEntity examData;
  AnswerSubmittedState(this.examData);
}

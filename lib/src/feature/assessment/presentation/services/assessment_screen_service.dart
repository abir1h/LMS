import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/common_widgets/custom_action_button.dart';
import '../../../../core/common_widgets/custom_dialog_widget.dart';
import '../../../../core/utility/app_label.dart';
import '../../../course/data/data_sources/remote/course_data_source.dart';
import '../../../course/data/repositories/course_repository_imp.dart';
import '../../../course/domain/use_cases/course_use_case.dart';
import '../../domain/entities/exam_data_entity.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/assessment_data_source.dart';
import '../../data/repositories/assessment_repository_imp.dart';
import '../../domain/entities/result_data_entity.dart';
import '../../domain/use_cases/assessment_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void showExamSubmitDialog();
  void showExamCancellationDialog();
  void forceClose();
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

  final CourseUseCase _courseUseCase = CourseUseCase(
      courseRepository: CourseRepositoryImp(
          courseRemoteDataSource: CourseRemoteDataSourceImp()));

  Future<ResponseEntity> contentRead(
      {required int contentId,
      required String contentType,
      required int courseId,
      required bool isCompleted,
      required String lastWatchTime,
      required String attendanceType}) async {
    return _courseUseCase.contentReadUseCase(contentId, contentType, courseId,
        isCompleted, lastWatchTime, attendanceType);
  }

  ///Screen args
  late AssessmentScreenArgs screenArgs;
  late Timer examTimer;
  late DateTime _examStartTime;
  bool _isExamRunning = false;

  int groupValue = -1;

  final DefaultActionButtonController submitButtonController =
      DefaultActionButtonController();

  ///Stream Controllers
  final AppStreamController<PageState> pageStateStreamController =
      AppStreamController();
  final BehaviorSubject<Duration> timerStreamController = BehaviorSubject();

  final StreamController<String> questionNumberTextStream =
      StreamController.broadcast();
  final StreamController<Map<String, dynamic>> buttonTextStream =
      StreamController.broadcast();
  final StreamController<Map<String, dynamic>> pageArrowButtonStream =
      StreamController.broadcast();
  final StreamController<int> pageSelectedIndexStream =
      StreamController.broadcast();

  final ScrollController scrollController = ScrollController();

  final PageController questionPagerController = PageController();

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
    scrollController.addListener(_scrollValue);
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
    _isExamRunning = true;

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
      _view.showExamSubmitDialog();
      onSubmitExam(screenArgs.examData);
      // pageStateStreamController.add(
      //     DataLoadedState<PageState>(TimeExpiredState(screenArgs.examData)));
      _isExamRunning = false;
    }
  }

  Future<bool> onGoBack() {
    if (_isExamRunning) {
      _view.showExamCancellationDialog();
    } else {
      _view.forceClose();
    }
    return Future.value(false);
  }

  Future<ResponseEntity> onSubmitExam(ExamDataEntity examDataEntity) async {
    ResponseEntity responseEntity = await onSubmit(examDataEntity);
    if (responseEntity.error == null && responseEntity.data != null) {
      _view.showSuccess(responseEntity.message!);
      contentReadPost();
    } else {
      _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }

  void onExamResultSubmitted(ResultDataEntity data) {
    pageStateStreamController
        .add(DataLoadedState<PageState>(AnswerSubmittedState(data)));
    _isExamRunning = false;
  }

  Future<ResponseEntity> contentReadPost() async {
    ResponseEntity responseEntity = await contentRead(
        contentId: screenArgs.examData.assessment!.id,
        contentType: "circular_assessment",
        courseId: screenArgs.examData.assessment!.courseId,
        isCompleted: true,
        lastWatchTime: "",
        attendanceType: "");
    if (responseEntity.error == null && responseEntity.data != null) {
      // _view.showSuccess(responseEntity.message!);
    } else {
      // _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }

  _scrollValue() {
    if (scrollController.position.pixels == 0.0) {
      pageArrowButtonStream.add({
        "next": true,
        "previous": false,
      });
    } else if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      pageArrowButtonStream.add({
        "next": false,
        "previous": true,
      });
    } else {
      pageArrowButtonStream.add({
        "next": true,
        "previous": true,
      });
    }
  }

  onQuestionChanged(int index) {
    scrollController.animateTo(index * 32,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    pageSelectedIndexStream.sink.add(index);
    questionNumberTextStream.add(
        "${label(e: "Question", b: "প্রশ্ন")}: ${replaceEnglishNumberWithBengali("${index + 1}")} / ${replaceEnglishNumberWithBengali(screenArgs.examData.assessment!.questions.length.toString())}");
    if (index == screenArgs.examData.assessment!.questions.length - 1) {
      buttonTextStream.add({
        "next": label(e: "Submit", b: "সাবমিট"),
        "previous": index == 0 ? false : true,
      });
    } else {
      buttonTextStream.add({
        "next": label(e: "Next", b: "পরবর্তী"),
        "previous": index == 0 ? false : true,
      });
    }
  }

  onNextTap() {
    if (questionPagerController.page?.floor() !=
        screenArgs.examData.assessment!.questions.length - 1) {
      questionPagerController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      showConfirmationDialog();
    }
  }

  onPreviousButtonTap() {
    questionPagerController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  showConfirmationDialog() {
    CustomDialogWidget.show(
      context: context,
      icon: Icons.quiz_outlined,
      title: label(e: "Are You Sure?", b: "আপনি কি নিশ্চিত?"),
      infoText: label(
          e: "You are about to submit answers. Before submitting, you should double-check your answers.\n\nHowever, do you like to submit it now?",
          b: "আপনি উত্তর জমা দিতে চলেছেন৷ জমা দেওয়ার আগে, আপনার উত্তরগুলি দুবার চেক করা উচিত৷\n\nতবে, আপনি কি এখন এটি জমা দিতে চান?"),
      leftButtonText: label(e: "Cancel", b: "বাতিল করুন"),
      rightButtonText: label(e: "Yes", b: "হ্যাঁ"),
    ).then((value) {
      if (value) {
        onSubmitExam(screenArgs.examData).then((value) {
          examTimer.cancel();
          _view.showExamSubmitDialog();
        });
      }
    });
  }
}

abstract class PageState {}

class ExamRunningState extends PageState {
  final ExamDataEntity examData;
  ExamRunningState(this.examData);
}

class TimeExpiredState extends PageState {
  final ExamDataEntity examData;
  // final ExamDataEntity questions;
  // final bool shouldShowAnswerSheet;
  // final DateTime startTime;
  // final DateTime endTime;
  TimeExpiredState(
    this.examData,
    // this.questions,
    // this.shouldShowAnswerSheet,
    // this.startTime,
    // this.endTime,
  );
}

class AnswerSubmittedState extends PageState {
  final ResultDataEntity resultData;
  AnswerSubmittedState(this.resultData);
}

import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/utility/validator.dart';
import '../../../course/data/data_sources/remote/course_data_source.dart';
import '../../../course/data/repositories/course_repository_imp.dart';
import '../../../course/domain/use_cases/course_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/assignment_data_source.dart';
import '../../data/repositories/assignment_repository_imp.dart';
import '../../domain/use_cases/assignment_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin WrittenAssignmentSubmitScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final AssignmentUseCase _assignmentUseCase = AssignmentUseCase(
      assignmentRepository: AssignmentRepositoryImp(
          assignmentRemoteDataSource: AssignmentRemoteDataSourceImp()));

  Future<ResponseEntity> storeAssignment(int assignmentId, int subAssignmentId,
      int courseId, int circularId, String answer, List<File> files) async {
    return _assignmentUseCase.storeAssignmentUseCase(
        assignmentId, subAssignmentId, courseId, circularId, answer, files);
  }

  Future<ResponseEntity> updateAssignment(
      int submissionId,
      int assignmentId,
      int subAssignmentId,
      int courseId,
      int circularId,
      String answer,
      List<File> files) async {
    return _assignmentUseCase.updateAssignmentUseCase(submissionId,
        assignmentId, subAssignmentId, courseId, circularId, answer, files);
  }

  final CourseUseCase _courseUseCase = CourseUseCase(
      courseRepository: CourseRepositoryImp(
          courseRemoteDataSource: CourseRemoteDataSourceImp()));

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

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<ResponseEntity> onStoreAssignment(
      {required int assignmentId,
      required int subAssignmentId,
      required int courseId,
      required int circularId,
      required String answer,
      required List<File> files}) async {
    ResponseEntity responseEntity = await storeAssignment(
        assignmentId, subAssignmentId, courseId, circularId, answer, files);
    if (responseEntity.error == null && responseEntity.data != null) {
      _view.showSuccess(responseEntity.message!);
    } else {
      _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }

  Future<ResponseEntity> onUpdateAssignment(
      {required int submissionId,
      required int assignmentId,
      required int subAssignmentId,
      required int courseId,
      required int circularId,
      required String answer,
      required List<File> files}) async {
    ResponseEntity responseEntity = await updateAssignment(submissionId,
        assignmentId, subAssignmentId, courseId, circularId, answer, files);
    if (responseEntity.error == null && responseEntity.data != null) {
      _view.showSuccess(responseEntity.message!);
    } else {
      _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }

  Future<ResponseEntity> contentReadPost(
      int contentId, int courseId, bool isCompleted) async {
    ResponseEntity responseEntity = await contentRead(
        contentId, "circular_assignment", courseId, isCompleted, "", "");
    if (responseEntity.error == null && responseEntity.data != null) {
      // _view.showSuccess(responseEntity.message!);
    } else {
      // _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }
}

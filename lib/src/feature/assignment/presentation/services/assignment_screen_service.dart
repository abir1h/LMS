import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/assignment_data_source.dart';
import '../../data/repositories/assignment_repository_imp.dart';
import '../../domain/entities/assignment_data_entity.dart';
import '../../domain/use_cases/assignment_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin AssignmentScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final AssignmentUseCase _assignmentUseCase = AssignmentUseCase(
      assignmentRepository: AssignmentRepositoryImp(
          assignmentRemoteDataSource: AssignmentRemoteDataSourceImp()));

  Future<ResponseEntity> getAssignmentDetails(int courseContentId) async {
    return _assignmentUseCase.getAssignmentDetailsUseCase(courseContentId);
  }

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

  List<String> fileName = [];
  List<File>? files = [];

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    assignmentDetailsDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<AssignmentDataEntity>
      assignmentDetailsDataStreamController = AppStreamController();

  ///Load assessment details
  void loadAssignmentData(int courseContentId) {
    if (!mounted) return;
    assignmentDetailsDataStreamController.add(LoadingState());
    getAssignmentDetails(courseContentId).then((value) {
      if (value.error == null && value.data != null) {
        assignmentDetailsDataStreamController
            .add(DataLoadedState<AssignmentDataEntity>(value.data));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  // bool validateFormData(TextEditingController titleController) {
  //   if (Validator.isEmpty(titleController.text.trim())) {
  //     _view.showWarning("Description is required!");
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

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

  void pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      allowCompression: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        files = result.paths.map((path) => File(path!)).toList();
      });
    } else {
      print("No file selected");
    }
  }
}

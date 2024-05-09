import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/assignment_data_source.dart';
import '../../data/repositories/assignment_repository_imp.dart';
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

  Future<ResponseEntity> storeAssignment(int assignmentId, int subAssignmentId,
      int courseId, int circularId, String answer, String filePath) async {
    return _assignmentUseCase.storeAssignmentUseCase(
        assignmentId, subAssignmentId, courseId, circularId, answer, filePath);
  }

  Future<ResponseEntity> updateAssignment(int assignmentId, int subAssignmentId,
      int courseId, int circularId, String answer, String filePath) async {
    return _assignmentUseCase.updateAssignmentUseCase(
        assignmentId, subAssignmentId, courseId, circularId, answer, filePath);
  }

  List<String> fileName = [];
  List<File>? files;

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
      required String filePath}) async {
    ResponseEntity responseEntity = await storeAssignment(
        assignmentId, subAssignmentId, courseId, circularId, answer, filePath);
    if (responseEntity.error == null && responseEntity.data != null) {
      _view.showSuccess(responseEntity.message!);
    } else {
      _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }

  void pickFiles() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, allowCompression: true);

    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();
      for (var element in result.files) {
        fileName.add(element.name);
      }
    } else {
      print("No file selected");
    }
  }
}

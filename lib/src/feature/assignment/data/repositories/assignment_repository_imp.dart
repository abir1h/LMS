import 'dart:io';

import 'package:lms/src/feature/assignment/data/mapper/assignement_request_mapper.dart';
import 'package:lms/src/feature/assignment/data/mapper/collaborative_accept_review_data_mapper.dart';
import 'package:lms/src/feature/assignment/domain/entities/assignement_request_entity.dart';

import '../../domain/entities/collaborative_accept_review_data_entity.dart';
import '../mapper/assignment_data_mapper.dart';
import '../models/assignment_data_model.dart';
import '../../domain/entities/assignment_data_entity.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/repositories/assignment_repository.dart';
import '../data_sources/remote/assignment_data_source.dart';
import '../models/assignment_request_model.dart';
import '../models/collaborative_accept_review_data_model.dart';

class AssignmentRepositoryImp extends AssignmentRepository {
  final AssignmentRemoteDataSource assignmentRemoteDataSource;
  AssignmentRepositoryImp({required this.assignmentRemoteDataSource});

  @override
  Future<ResponseEntity> getAssignmentDetails(int courseContentId) async {
    ResponseModel responseModel = (await assignmentRemoteDataSource
        .getAssignmentDetailsAction(courseContentId));
    return ResponseModelToEntityMapper<AssignmentDataEntity,
            AssignmentDataModel>()
        .toEntityFromModel(responseModel,
            (AssignmentDataModel model) => model.toAssignmentDataEntity);
  }

  @override
  Future<ResponseEntity> storeAssignment(int assignmentId, int subAssignmentId,
      int courseId, int circularId, String answer, List<File> files) async {
    ResponseModel responseModel =
        (await assignmentRemoteDataSource.storeAssignmentAction(assignmentId,
            subAssignmentId, courseId, circularId, answer, files));
    return ResponseModelToEntityMapper<AssignmentDataEntity,
            AssignmentDataModel>()
        .toEntityFromModel(responseModel,
            (AssignmentDataModel model) => model.toAssignmentDataEntity);
  }

  @override
  Future<ResponseEntity> updateAssignment(
      int submissionId,
      int assignmentId,
      int subAssignmentId,
      int courseId,
      int circularId,
      String answer,
      List<File> files) async {
    ResponseModel responseModel =
        (await assignmentRemoteDataSource.updateAssignmentAction(
            submissionId,
            assignmentId,
            subAssignmentId,
            courseId,
            circularId,
            answer,
            files));
    return ResponseModelToEntityMapper<AssignmentDataEntity,
            AssignmentDataModel>()
        .toEntityFromModel(responseModel,
            (AssignmentDataModel model) => model.toAssignmentDataEntity);
  }

  @override
  Future<ResponseEntity> requestAssignment(int circularId, int courseId,
      int circularAssignmentId, int courseModuleId, String message) async {
    ResponseModel responseModel =
        (await assignmentRemoteDataSource.requestAssignmentAction(circularId,
            courseId, circularAssignmentId, courseModuleId, message));
    return ResponseModelToEntityMapper<AssignmentRequestEntity,
            AssignmentRequestModel>()
        .toEntityFromModel(responseModel,
            (AssignmentRequestModel model) => model.toAssignmentRequestEntity);
  }

  @override
  Future<ResponseEntity> getAcceptReview(int traineeId) async {
    ResponseModel responseModel =
        (await assignmentRemoteDataSource.getAcceptReviewAction(traineeId));
    return ResponseModelToEntityMapper<CollaborativeAcceptReviewDataEntity,
            CollaborativeAcceptReviewDataModel>()
        .toEntityFromModel(
            responseModel,
            (CollaborativeAcceptReviewDataModel model) =>
                model.toCollaborativeAcceptReviewDataEntity);
  }

  @override
  Future<ResponseEntity> reviewResultSubmit(
    int assignmentSubId,
    int resultId,
    String markObtained,
  ) async {
    ResponseModel responseModel = (await assignmentRemoteDataSource
        .reviewResultSubmitAction(assignmentSubId, resultId, markObtained));
    return ResponseModelToEntityMapper<CollaborativeAcceptReviewDataEntity,
            CollaborativeAcceptReviewDataModel>()
        .toEntityFromModel(
            responseModel,
            (CollaborativeAcceptReviewDataModel model) =>
                model.toCollaborativeAcceptReviewDataEntity);
  }
}

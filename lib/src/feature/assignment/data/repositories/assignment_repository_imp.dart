import '../mapper/assignment_data_mapper.dart';
import '../models/assignment_data_model.dart';
import '../../domain/entities/assignment_data_entity.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/repositories/assignment_repository.dart';
import '../data_sources/remote/assignment_data_source.dart';

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
      int courseId, int circularId, String answer, String filePath) async {
    ResponseModel responseModel =
        (await assignmentRemoteDataSource.storeAssignmentAction(assignmentId,
            subAssignmentId, courseId, circularId, answer, filePath));
    return ResponseModelToEntityMapper<AssignmentDataEntity,
            AssignmentDataModel>()
        .toEntityFromModel(responseModel,
            (AssignmentDataModel model) => model.toAssignmentDataEntity);
  }

  @override
  Future<ResponseEntity> updateAssignment(int assignmentId, int subAssignmentId,
      int courseId, int circularId, String answer, String filePath) async {
    ResponseModel responseModel =
        (await assignmentRemoteDataSource.updateAssignmentAction(assignmentId,
            subAssignmentId, courseId, circularId, answer, filePath));
    return ResponseModelToEntityMapper<AssignmentDataEntity,
            AssignmentDataModel>()
        .toEntityFromModel(responseModel,
            (AssignmentDataModel model) => model.toAssignmentDataEntity);
  }
}

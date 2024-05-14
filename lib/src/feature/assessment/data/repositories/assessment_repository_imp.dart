import '../mapper/exam_data_mapper.dart';
import '../models/exam_data_model.dart';
import '../../domain/entities/exam_data_entity.dart';
import '../mapper/question_type_data_mapper.dart';
import '../models/question_type_data_model.dart';
import '../../domain/entities/qustion_type_data_entity.dart';
import '../mapper/assessment_data_mapper.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../shared/data/models/response_model.dart';
import '../../domain/entities/assessment_data_entity.dart';
import '../../domain/repositories/assessment_repository.dart';
import '../data_sources/remote/assessment_data_source.dart';
import '../models/assessment_data_model.dart';

class AssessmentRepositoryImp extends AssessmentRepository {
  final AssessmentRemoteDataSource assessmentRemoteDataSource;
  AssessmentRepositoryImp({required this.assessmentRemoteDataSource});

  @override
  Future<ResponseEntity> getAssessmentDetails(int courseContentId) async {
    ResponseModel responseModel = (await assessmentRemoteDataSource
        .getAssessmentDetailsAction(courseContentId));
    return ResponseModelToEntityMapper<AssessmentDataEntity,
            AssessmentDataModel>()
        .toEntityFromModel(responseModel,
            (AssessmentDataModel model) => model.toAssessmentDataEntity);
  }

  @override
  Future<ResponseEntity> getQuestionType() async {
    ResponseModel responseModel =
        (await assessmentRemoteDataSource.getQuestionTypeAction());
    return ResponseModelToEntityMapper<List<QuestionTypeDataEntity>,
            List<QuestionTypeDataModel>>()
        .toEntityFromModel(
            responseModel,
            (List<QuestionTypeDataModel> models) =>
                List<QuestionTypeDataModel>.from(models)
                    .map((e) => e.toQuestionTypeDataEntity)
                    .toList());
  }

  @override
  Future<ResponseEntity> startExam(int circularAssessmentId) async {
    ResponseModel responseModel = (await assessmentRemoteDataSource
        .startExamAction(circularAssessmentId));
    return ResponseModelToEntityMapper<ExamDataEntity, ExamDataModel>()
        .toEntityFromModel(
            responseModel, (ExamDataModel model) => model.toExamDataEntity);
  }

  @override
  Future<ResponseEntity> submitExam(ExamDataEntity examDataEntity) async {
    ResponseModel responseModel = (await assessmentRemoteDataSource
        .submitExamAction(examDataEntity.toExamDataModel));
    return ResponseModelToEntityMapper<ExamDataEntity, ExamDataModel>()
        .toEntityFromModel(
            responseModel, (ExamDataModel model) => model.toExamDataEntity);
  }
}

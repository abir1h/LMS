import 'assessment_data_mapper.dart';
import '../../domain/entities/exam_data_entity.dart';
import '../models/exam_data_model.dart';
import 'question_data_mapper.dart';
import '../models/question_data_model.dart';
import '../../domain/entities/question_data_entity.dart';

abstract class ExamDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class ExamDataModelToEntityMapper
    extends ExamDataMapper<ExamDataModel, ExamDataEntity> {
  @override
  ExamDataModel fromEntityToModel(ExamDataEntity entity) {
    return ExamDataModel(
        examResultId: entity.examResultId,
        assessment: entity.assessment?.toAssessmentDataModel,
        questions: List<QuestionDataEntity>.from(entity.questions)
            .map((entity) => entity.toQuestionDataModel)
            .toList());
  }

  @override
  ExamDataEntity toEntityFromModel(ExamDataModel model) {
    return ExamDataEntity(
      examResultId: model.examResultId,
      assessment: model.assessment?.toAssessmentDataEntity,
      questions: List<QuestionDataModel>.from(model.questions)
          .map((model) => model.toQuestionDataEntity)
          .toList(),
    );
  }
}

extension ExamDataModelExt on ExamDataModel {
  ExamDataEntity get toExamDataEntity =>
      ExamDataModelToEntityMapper().toEntityFromModel(this);
}

extension ExamDataEntityExt on ExamDataEntity {
  ExamDataModel get toExamDataModel =>
      ExamDataModelToEntityMapper().fromEntityToModel(this);
}

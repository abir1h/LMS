import 'question_data_mapper.dart';
import '../models/question_data_model.dart';
import '../../domain/entities/question_data_entity.dart';
import '../../domain/entities/assessment_data_entity.dart';
import '../models/assessment_data_model.dart';

abstract class AssessmentDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class AssessmentDataModelToEntityMapper
    extends AssessmentDataMapper<AssessmentDataModel, AssessmentDataEntity> {
  @override
  AssessmentDataModel fromEntityToModel(AssessmentDataEntity entity) {
    return AssessmentDataModel(
        id: entity.id,
        courseId: entity.courseId,
        courseModuleId: entity.courseModuleId,
        assessmentTitleEn: entity.assessmentTitleEn,
        assessmentTitleBn: entity.assessmentTitleBn,
        totalMark: entity.totalMark,
        passMark: entity.passMark,
        totalTime: entity.totalTime,
        tries: entity.tries,
        isHorizontal: entity.isHorizontal,
        isCertificationAssessment: entity.isCertificationAssessment,
        questions: List<QuestionDataEntity>.from(entity.questions)
            .map((entity) => entity.toQuestionDataModel)
            .toList());
  }

  @override
  AssessmentDataEntity toEntityFromModel(AssessmentDataModel model) {
    return AssessmentDataEntity(
        id: model.id,
        courseId: model.courseId,
        courseModuleId: model.courseModuleId,
        assessmentTitleEn: model.assessmentTitleEn,
        assessmentTitleBn: model.assessmentTitleBn,
        totalMark: model.totalMark,
        passMark: model.passMark,
        totalTime: model.totalTime,
        tries: model.tries,
        isHorizontal: model.isHorizontal,
        isCertificationAssessment: model.isCertificationAssessment,
        questions: List<QuestionDataModel>.from(model.questions)
            .map((model) => model.toQuestionDataEntity)
            .toList(),);
  }
}

extension AssesmentDataModelExt on AssessmentDataModel {
  AssessmentDataEntity get toAssessmentDataEntity =>
      AssessmentDataModelToEntityMapper().toEntityFromModel(this);
}

extension AssesmentDataEntityExt on AssessmentDataEntity {
  AssessmentDataModel get toAssessmentDataModel =>
      AssessmentDataModelToEntityMapper().fromEntityToModel(this);
}

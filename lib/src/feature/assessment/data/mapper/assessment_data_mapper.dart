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
        circularId: entity.circularId,
        parentAssessmentId: entity.parentAssessmentId,
        courseModuleId: entity.courseModuleId,
        titleEn: entity.titleEn,
        titleBn: entity.titleBn,
        totalMark: entity.totalMark,
        passMark: entity.passMark,
        negativeMark: entity.negativeMark,
        totalTime: entity.totalTime,
        tries: entity.tries,
        isCertificationAssessment: entity.isCertificationAssessment,
        isHorizontal: entity.isHorizontal,
        status: entity.status,
        createdBy: entity.createdBy,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        deletedAt: entity.deletedAt,
        assessmentInstruction: entity.assessmentInstruction,
        startDate: entity.startDate,
        endDate: entity.endDate,
        questions: List<QuestionDataEntity>.from(entity.questions)
            .map((entity) => entity.toQuestionDataModel)
            .toList());
  }

  @override
  AssessmentDataEntity toEntityFromModel(AssessmentDataModel model) {
    return AssessmentDataEntity(
      id: model.id,
      courseId: model.courseId,
      circularId: model.circularId,
      parentAssessmentId: model.parentAssessmentId,
      courseModuleId: model.courseModuleId,
      titleEn: model.titleEn,
      titleBn: model.titleBn,
      totalMark: model.totalMark,
      passMark: model.passMark,
      negativeMark: model.negativeMark,
      totalTime: model.totalTime,
      tries: model.tries,
      isCertificationAssessment: model.isCertificationAssessment,
      isHorizontal: model.isHorizontal,
      status: model.status,
      createdBy: model.createdBy,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      deletedAt: model.deletedAt,
      assessmentInstruction: model.assessmentInstruction,
      startDate: model.startDate,
      endDate: model.endDate,
      questions: List<QuestionDataModel>.from(model.questions)
          .map((model) => model.toQuestionDataEntity)
          .toList(),
    );
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

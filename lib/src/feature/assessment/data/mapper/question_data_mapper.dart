import 'option_data_mapper.dart';
import '../models/option_data_model.dart';
import '../../domain/entities/option_data_entity.dart';
import '../../domain/entities/question_data_entity.dart';
import '../models/question_data_model.dart';

abstract class QuestionDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class QuestionDataModelToEntityMapper
    extends QuestionDataMapper<QuestionDataModel, QuestionDataEntity> {
  @override
  QuestionDataModel fromEntityToModel(QuestionDataEntity entity) {
    return QuestionDataModel(
      id: entity.id,
      circularCourseId: entity.circularCourseId,
      circularId: entity.circularId,
      parentQuestionId: entity.parentQuestionId,
      circularAssessmentId: entity.circularAssessmentId,
      question: entity.question,
      questionImg: entity.questionImg,
      supportingNotesEn: entity.supportingNotesEn,
      explanation: entity.explanation,
      supportingNotesBn: entity.supportingNotesBn,
      mark: entity.mark,
      negativeMark: entity.negativeMark,
      createdBy: entity.createdBy,
      questionType: entity.questionType,
      typeId: entity.typeId,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
      options: List<OptionDataEntity>.from(entity.options)
          .map((entity) => entity.toOptionDataModel)
          .toList(),
    );
  }

  @override
  QuestionDataEntity toEntityFromModel(QuestionDataModel model) {
    return QuestionDataEntity(
      id: model.id,
      circularCourseId: model.circularCourseId,
      circularId: model.circularId,
      parentQuestionId: model.parentQuestionId,
      circularAssessmentId: model.circularAssessmentId,
      question: model.question,
      questionImg: model.questionImg,
      supportingNotesEn: model.supportingNotesEn,
      explanation: model.explanation,
      supportingNotesBn: model.supportingNotesBn,
      mark: model.mark,
      negativeMark: model.negativeMark,
      createdBy: model.createdBy,
      questionType: model.questionType,
      typeId: model.typeId,
      status: model.status,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      deletedAt: model.deletedAt,
      options: List<OptionDataModel>.from(model.options)
          .map((model) => model.toOptionDataEntity)
          .toList(),
    );
  }
}

extension QuestionDataModelExt on QuestionDataModel {
  QuestionDataEntity get toQuestionDataEntity =>
      QuestionDataModelToEntityMapper().toEntityFromModel(this);
}

extension QuestionDataEntityExt on QuestionDataEntity {
  QuestionDataModel get toQuestionDataModel =>
      QuestionDataModelToEntityMapper().fromEntityToModel(this);
}

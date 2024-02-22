import 'option_data_mapper.dart';
import 'question_type_data_mapper.dart';
import '../models/Option_data_model.dart';
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
      courseId: entity.courseId,
      courseAssessmentId: entity.courseAssessmentId,
      question: entity.question,
      questionImg: entity.questionImg,
      supportingNotesEn: entity.supportingNotesEn,
      mark: entity.mark,
      negativeMark: entity.negativeMark,
      questionType: entity.questionType?.toQuestionTypeDataModel,
      typeId: entity.typeId,
      options: List<OptionDataEntity>.from(entity.options)
          .map((entity) => entity.toOptionDataModel)
          .toList(),
    );
  }

  @override
  QuestionDataEntity toEntityFromModel(QuestionDataModel model) {
    return QuestionDataEntity(
      id: model.id,
      courseId: model.courseId,
      courseAssessmentId: model.courseAssessmentId,
      question: model.question,
      questionImg: model.questionImg,
      supportingNotesEn: model.supportingNotesEn,
      mark: model.mark,
      negativeMark: model.negativeMark,
      questionType: model.questionType?.toQuestionTypeDataEntity,
      typeId: model.typeId,
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

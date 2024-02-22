import '../../domain/entities/qustion_type_data_entity.dart';
import '../models/question_type_data_model.dart';

abstract class QuestionTypeDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class QuestionTypeDataModelToEntityMapper extends QuestionTypeDataMapper<
    QuestionTypeDataModel, QuestionTypeDataEntity> {
  @override
  QuestionTypeDataModel fromEntityToModel(QuestionTypeDataEntity entity) {
    return QuestionTypeDataModel(id: entity.id, nameEn: entity.nameEn, nameBn: entity.nameBn);
  }

  @override
  QuestionTypeDataEntity toEntityFromModel(QuestionTypeDataModel model) {
    return QuestionTypeDataEntity(id: model.id, nameEn: model.nameEn, nameBn: model.nameBn);
  }
}

extension QuestionTypeDataModelExt on QuestionTypeDataModel {
  QuestionTypeDataEntity get toQuestionTypeDataEntity =>
      QuestionTypeDataModelToEntityMapper().toEntityFromModel(this);
}

extension QuestionTypeDataEntityExt on QuestionTypeDataEntity {
  QuestionTypeDataModel get toQuestionTypeDataModel =>
      QuestionTypeDataModelToEntityMapper().fromEntityToModel(this);
}

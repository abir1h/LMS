import '../../domain/entities/upcoming_class_data_entity.dart';
import '../../domain/entities/video_choice_data_entity.dart';
import '../models/upcoming_class_data_model.dart';
import '../models/video_choice_data_model.dart';

abstract class VideoChoiceDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class VideoChoiceDataModelToEntityMapper
    extends VideoChoiceDataMapper<VideoChoiceDataModel, VideoChoiceDataEntity> {
  @override
  VideoChoiceDataModel fromEntityToModel(VideoChoiceDataEntity entity) {
    return VideoChoiceDataModel(
        id: entity.id,
        choiceText: entity.choiceText,
        isCorrect: entity.isCorrect,
        questionId: entity.questionId);
  }

  @override
  VideoChoiceDataEntity toEntityFromModel(VideoChoiceDataModel model) {
    return VideoChoiceDataEntity(
        id: model.id,
        choiceText: model.choiceText,
        isCorrect: model.isCorrect,
        questionId: model.questionId);
  }
}

extension VideoChoiceDataModelExt on VideoChoiceDataModel {
  VideoChoiceDataEntity get toVideoChoiceDataEntity =>
      VideoChoiceDataModelToEntityMapper().toEntityFromModel(this);
}

extension VideoChoiceDataEntityExt on VideoChoiceDataEntity {
  VideoChoiceDataModel get toVideoChoiceDataModel =>
      VideoChoiceDataModelToEntityMapper().fromEntityToModel(this);
}

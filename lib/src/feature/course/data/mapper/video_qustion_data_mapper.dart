import 'package:lms/src/feature/course/data/mapper/video_choice_data_mapper.dart';
import 'package:lms/src/feature/course/data/models/video_choice_data_model.dart';
import 'package:lms/src/feature/course/domain/entities/video_choice_data_entity.dart';

import '../../domain/entities/video_qustion_data_entity.dart';
import '../models/video_qustion_data_model.dart';

abstract class VideoQustionDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class VideoQuestionDataModelToEntityMapper extends VideoQustionDataMapper<
    VideoQuestionDataModel, VideoQuestionDataEntity> {
  @override
  VideoQuestionDataModel fromEntityToModel(VideoQuestionDataEntity entity) {
    return VideoQuestionDataModel(
        id: entity.id,
        videoId: entity.videoId,
        questionText: entity.questionText,
        popUpTimeSecond: entity.popUpTimeSecond,
        message: entity.message,
        seen: entity.seen,
        choices: List<VideoChoiceDataEntity>.from(entity.choices)
            .map((entity) => entity.toVideoChoiceDataModel)
            .toList());
  }

  @override
  VideoQuestionDataEntity toEntityFromModel(VideoQuestionDataModel model) {
    return VideoQuestionDataEntity(
      id: model.id,
      videoId: model.videoId,
      questionText: model.questionText,
      popUpTimeSecond: model.popUpTimeSecond,
      message: model.message,
      seen: model.seen,
      choices: List<VideoChoiceDataModel>.from(model.choices)
          .map((model) => model.toVideoChoiceDataEntity)
          .toList(),
    );
  }
}

extension VideoQuestionDataModelExt on VideoQuestionDataModel {
  VideoQuestionDataEntity get toVideoQuestionDataEntity =>
      VideoQuestionDataModelToEntityMapper().toEntityFromModel(this);
}

extension VideoQustionDataEntityExt on VideoQuestionDataEntity {
  VideoQuestionDataModel get toVideoQuestionDataModel =>
      VideoQuestionDataModelToEntityMapper().fromEntityToModel(this);
}

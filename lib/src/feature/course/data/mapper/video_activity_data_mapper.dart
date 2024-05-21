import '../../domain/entities/video_activity_data_entity.dart';

import '../models/video_activity_data_model.dart';

abstract class VideoActivityDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class VideoActivityDataModelToEntityMapper extends VideoActivityDataMapper<
    VideoActivityDataModel, VideoActivityDataEntity> {
  @override
  VideoActivityDataModel fromEntityToModel(VideoActivityDataEntity entity) {
    return VideoActivityDataModel(
      id: entity.id,
      traineeId: entity.traineeId,
      circularVideoId: entity.circularVideoId,
      lastViewTime: entity.lastViewTime,
      questionsSeen: List<int>.from(entity.questionsSeen.map((x) => x)),
    );
  }

  @override
  VideoActivityDataEntity toEntityFromModel(VideoActivityDataModel model) {
    return VideoActivityDataEntity(
      id: model.id,
      traineeId: model.traineeId,
      circularVideoId: model.circularVideoId,
      lastViewTime: model.lastViewTime,
      questionsSeen: List<int>.from(model.questionsSeen.map((x) => x)),
    );
  }
}

extension VideoActivityDataModelExt on VideoActivityDataModel {
  VideoActivityDataEntity get toVideoActivityDataEntity =>
      VideoActivityDataModelToEntityMapper().toEntityFromModel(this);
}

extension VideoActivityDataEntityExt on VideoActivityDataEntity {
  VideoActivityDataModel get toVideoActivityDataModel =>
      VideoActivityDataModelToEntityMapper().fromEntityToModel(this);
}

import '../../domain/entities/video_data_entity.dart';
import '../models/video_data_model.dart';

abstract class VideoDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class VideoDataModelToEntityMapper
    extends VideoDataMapper<VideoDataModel, VideoDataEntity> {
  @override
  VideoDataModel fromEntityToModel(VideoDataEntity entity) {
    return VideoDataModel(
        id: entity.id,
        courseId: entity.courseId,
        courseModuleId: entity.courseModuleId,
        titleEn: entity.titleEn,
        titleBn: entity.titleBn,
        type: entity.type,
        url: entity.url,
        transcriptEn: entity.transcriptEn,
        transcriptBn: entity.transcriptBn,
        category: entity.category,
        history: entity.history);
  }

  @override
  VideoDataEntity toEntityFromModel(VideoDataModel model) {
    return VideoDataEntity(
        id: model.id,
        courseId: model.courseId,
        courseModuleId: model.courseModuleId,
        titleEn: model.titleEn,
        titleBn: model.titleBn,
        type: model.type,
        url: model.url,
        transcriptEn: model.transcriptEn,
        transcriptBn: model.transcriptBn,
        category: model.category,
        history: model.history);
  }
}

extension VideoDataModelExt on VideoDataModel {
  VideoDataEntity get toVideoDataEntity =>
      VideoDataModelToEntityMapper().toEntityFromModel(this);
}

extension VideoDataEntityExt on VideoDataEntity {
  VideoDataModel get toVideoDataModel =>
      VideoDataModelToEntityMapper().fromEntityToModel(this);
}

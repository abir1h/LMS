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
      circularId: entity.circularId,
      courseId: entity.courseId,
      courseModuleId: entity.courseModuleId,
      titleEn: entity.titleEn,
      titleBn: entity.titleBn,
      transcriptEn: entity.transcriptEn,
      transcriptBn: entity.transcriptBn,
      sort: entity.sort,
      status: entity.status,
      category: entity.category,
      videoUrl: entity.videoUrl,createdAt: entity.createdAt,updatedAt: entity.updatedAt
    );
  }

  @override
  VideoDataEntity toEntityFromModel(VideoDataModel model) {
    return VideoDataEntity(
      id: model.id,
      circularId: model.circularId,
      courseId: model.courseId,
      courseModuleId: model.courseModuleId,
      titleEn: model.titleEn,
      titleBn: model.titleBn,
      transcriptEn: model.transcriptEn,
      transcriptBn: model.transcriptBn,
      sort: model.sort,
      status: model.status,
      category: model.category,
      videoUrl: model.videoUrl,createdAt: model.createdAt,updatedAt: model.updatedAt
    );
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

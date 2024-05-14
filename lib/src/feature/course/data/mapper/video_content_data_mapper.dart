import 'video_data_mapper.dart';
import '../../domain/entities/video_content_data_entity.dart';
import '../models/video_content_data_model.dart';

abstract class VideoContentDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class VideoContentDataModelToEntityMapper extends VideoContentDataMapper<
    VideoContentDataModel, VideoContentDataEntity> {
  @override
  VideoContentDataModel fromEntityToModel(VideoContentDataEntity entity) {
    return VideoContentDataModel(
      videoData: entity.videoData?.toVideoDataModel,
    );
  }

  @override
  VideoContentDataEntity toEntityFromModel(VideoContentDataModel model) {
    return VideoContentDataEntity(
      videoData: model.videoData?.toVideoDataEntity,
    );
  }
}

extension VideoContentDataModelExt on VideoContentDataModel {
  VideoContentDataEntity get toVideoContentDataEntity =>
      VideoContentDataModelToEntityMapper().toEntityFromModel(this);
}

extension VideoContentDataEntityExt on VideoContentDataEntity {
  VideoContentDataModel get toVideoContentDataModel =>
      VideoContentDataModelToEntityMapper().fromEntityToModel(this);
}

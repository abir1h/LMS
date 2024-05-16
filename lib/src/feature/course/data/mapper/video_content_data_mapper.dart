import 'package:lms/src/feature/course/data/mapper/video_qustion_data_mapper.dart';
import 'package:lms/src/feature/course/data/models/video_qustion_data_model.dart';
import 'package:lms/src/feature/course/domain/entities/video_qustion_data_entity.dart';

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
      videoQustion: List<VideoQustionDataEntity>.from(entity.videoQustion!)
          .map((entity) => entity.toVideoQustionDataModel)
          .toList(),
    );
  }

  @override
  VideoContentDataEntity toEntityFromModel(VideoContentDataModel model) {
    return VideoContentDataEntity(
      videoData: model.videoData?.toVideoDataEntity,
      videoQustion: List<VideoQustionDataModel>.from(model.videoQustion!)
          .map((model) => model.toVideoQustionDataEntity)
          .toList(),
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

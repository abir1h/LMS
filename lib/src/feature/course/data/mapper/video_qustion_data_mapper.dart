import 'package:lms/src/feature/course/data/mapper/video_choice_data_mapper.dart';
import 'package:lms/src/feature/course/data/models/video_choice_data_model.dart';
import 'package:lms/src/feature/course/domain/entities/video_choice_data_entity.dart';

import '../../domain/entities/video_qustion_data_entity.dart';
import '../models/video_qustion_data_model.dart';
import 'course_data_mapper.dart';
import '../models/course_data_model.dart';
import '../../domain/entities/course_data_entity.dart';
import '../../domain/entities/all_course_data_entity.dart';
import '../models/all_course_data_model.dart';

abstract class VideoQustionDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class VideoQustionDataModelToEntityMapper extends VideoQustionDataMapper<
    VideoQustionDataModel, VideoQustionDataEntity> {
  @override
  VideoQustionDataModel fromEntityToModel(VideoQustionDataEntity entity) {
    return VideoQustionDataModel(
        id: entity.id,
        videoId: entity.videoId,
        questionText: entity.questionText,
        popUpTimeSecond: entity.popUpTimeSecond,
        status: entity.status,
        choices: List<VideoChoiceDataEntity>.from(entity.choices)
            .map((entity) => entity.toVideoChoiceDataModel)
            .toList());
  }

  @override
  VideoQustionDataEntity toEntityFromModel(VideoQustionDataModel model) {
    return VideoQustionDataEntity(
      id: model.id,
      videoId: model.videoId,
      questionText: model.questionText,
      popUpTimeSecond: model.popUpTimeSecond,
      status: model.status,
      choices: List<VideoChoiceDataModel>.from(model.choices)
          .map((model) => model.toVideoChoiceDataEntity)
          .toList(),
    );
  }
}

extension VideoQustionDataModelExt on VideoQustionDataModel {
  VideoQustionDataEntity get toVideoQustionDataEntity =>
      VideoQustionDataModelToEntityMapper().toEntityFromModel(this);
}

extension VideoQustionDataEntityExt on VideoQustionDataEntity {
  VideoQustionDataModel get toVideoQustionDataModel =>
      VideoQustionDataModelToEntityMapper().fromEntityToModel(this);
}

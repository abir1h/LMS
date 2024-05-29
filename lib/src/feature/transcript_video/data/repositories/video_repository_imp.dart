import '../../../course/data/mapper/video_activity_data_mapper.dart';
import '../../../course/domain/entities/video_activity_data_entity.dart';
import '../../../course/data/models/video_activity_data_model.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/repositories/video_repository.dart';
import '../data_sources/remote/video_data_source.dart';

class VideoRepositoryImp extends VideoRepository {
  final VideoRemoteDataSource videoRemoteDataSource;
  VideoRepositoryImp({required this.videoRemoteDataSource});

  @override
  Future<ResponseEntity> videoActivity(int circularVideoId, int lastWatchTime,
      List<int> questionSeenList) async {
    ResponseModel responseModel = (await videoRemoteDataSource
        .videoActivityAction(circularVideoId, lastWatchTime, questionSeenList));
    return ResponseModelToEntityMapper<VideoActivityDataEntity,
            VideoActivityDataModel>()
        .toEntityFromModel(responseModel,
            (VideoActivityDataModel model) => model.toVideoActivityDataEntity);
  }
}

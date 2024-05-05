import 'package:lms/src/feature/circular/data/mapper/all_circular_data_mapper.dart';

import '../models/all_circular_data_model.dart';
import '../../domain/entities/all_circular_data_entity.dart';
import '../mapper/circular_details_data_mapper.dart';
import '../models/circular_details_data_model.dart';
import '../../domain/entities/circular_details_data_entity.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/repositories/circular_repository.dart';
import '../data_sources/remote/circular_data_source.dart';

class CircularRepositoryImp extends CircularRepository {
  final CircularRemoteDataSource circularRemoteDataSource;
  CircularRepositoryImp({required this.circularRemoteDataSource});

  @override
  Future<ResponseEntity> getCirculars() async {
    ResponseModel responseModel =
        (await circularRemoteDataSource.getCircularsAction());
    return ResponseModelToEntityMapper<AllCircularDataEntity,
            AllCircularDataModel>()
        .toEntityFromModel(responseModel,
            (AllCircularDataModel model) => model.toAllCircularDataEntity);
  }

  @override
  Future<ResponseEntity> getCircularDetails(int circularId) async {
    ResponseModel responseModel =
        (await circularRemoteDataSource.getCircularDetailsAction(circularId));
    return ResponseModelToEntityMapper<CircularDetailsDataEntity,
            CircularDetailsDataModel>()
        .toEntityFromModel(
            responseModel,
            (CircularDetailsDataModel model) =>
                model.toCircularDetailsDataEntity);
  }
}

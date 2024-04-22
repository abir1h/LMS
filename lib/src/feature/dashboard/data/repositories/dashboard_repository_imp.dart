import '../mapper/dashboard_data_mapper.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/entities/dashboard_data_entity.dart';
import '../mapper/dashboard_response_mapper.dart';
import '../data_sources/remote/dashboard_data_source.dart';
import '../../domain/entities/dashboard_response_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../models/dashboard_data_model.dart';

class DashboardRepositoryImp extends DashboardRepository {
  final DashboardRemoteDataSource dashboardRemoteDataSource;
  DashboardRepositoryImp({required this.dashboardRemoteDataSource});

  // @override
  // Future<DashboardResponseEntity> userDashboard() async {
  //   return (await dashboardRemoteDataSource.userDashboardAction())
  //       .toDashboardResponseEntity;
  // }

  @override
  Future<ResponseEntity> getUserDashboard() async {
    ResponseModel responseModel =
        (await dashboardRemoteDataSource.userDashboardAction());
    return ResponseModelToEntityMapper<DashboardDataEntity,
            DashboardDataModel>()
        .toEntityFromModel(responseModel,
            (DashboardDataModel model) => model.toDashboardDataEntity);
  }
}

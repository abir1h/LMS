import '../mapper/dashboard_response_mapper.dart';
import '../data_sources/remote/dashboard_data_source.dart';
import '../../domain/entities/dashboard_response_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImp extends DashboardRepository {
  final DashboardRemoteDataSource dashboardRemoteDataSource;
  DashboardRepositoryImp({required this.dashboardRemoteDataSource});

  @override
  Future<DashboardResponseEntity> userDashboard() async {
    return (await dashboardRemoteDataSource.userDashboardAction())
        .toDashboardResponseEntity;
  }
}

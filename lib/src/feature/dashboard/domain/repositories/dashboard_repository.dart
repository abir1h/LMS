import '../entities/dashboard_response_entity.dart';

abstract class DashboardRepository{

  Future<DashboardResponseEntity> userDashboard();
}
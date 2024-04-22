import '../../../shared/domain/entities/response_entity.dart';
import '../entities/dashboard_response_entity.dart';

abstract class DashboardRepository {
  // Future<DashboardResponseEntity> userDashboard();
  Future<ResponseEntity> getUserDashboard();
}

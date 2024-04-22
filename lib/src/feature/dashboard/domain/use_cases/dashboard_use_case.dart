import '../../../shared/domain/entities/response_entity.dart';
import '../entities/dashboard_response_entity.dart';
import '../repositories/dashboard_repository.dart';

class DashboardUseCase {
  final DashboardRepository _dashboardRepository;
  DashboardUseCase({required DashboardRepository dashboardRepository})
      : _dashboardRepository = dashboardRepository;

  // Future<DashboardResponseEntity> userDashboardUseCase() async {
  //   final response = _dashboardRepository.userDashboard();
  //   return response;
  // }

  Future<ResponseEntity> userDashboardUseCase() async {
    final response = _dashboardRepository.getUserDashboard();
    return response;
  }
}

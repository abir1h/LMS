import 'dashboard_data_entity.dart';

class DashboardResponseEntity{
  final String message;
  final DashboardDataEntity? data;
  final List<Map<String, String>>? errors;

  DashboardResponseEntity({
    required this.message,
    required this.data,
    required this.errors
  });
}
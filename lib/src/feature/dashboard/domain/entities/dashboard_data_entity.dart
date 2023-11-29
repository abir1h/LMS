import 'activity_duration_data_entity.dart';
import 'curriculum_data_entity.dart';
import 'current_module_data_entity.dart';

class DashboardDataEntity{
  final CurrentModuleDataEntity? currentModuleData;
  final CurriculumDataEntity? curriculumData;
  final int discussions;
  final int noticesCount;
  final ActivityDurationDataEntity? activityDurationData;
  final List<String> noticeboardList;


  DashboardDataEntity({
    required this.currentModuleData,
    required this.curriculumData,
    required this.discussions,
    required this.noticesCount,
    required this.activityDurationData,
    required this.noticeboardList
  });

}
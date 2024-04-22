import '../../../course/domain/entities/course_data_entity.dart';
import 'course_summary_data_entity.dart';

class DashboardDataEntity {
  final List<CourseDataEntity> courses;
  final CourseSummaryDataEntity courseSummery;
  final int discussion;

  DashboardDataEntity({
    required this.courses,
    required this.courseSummery,
    required this.discussion,
  });
}

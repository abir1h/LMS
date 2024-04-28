import 'course_data_entity.dart';

class AllCourseDataEntity {
  final List<CourseDataEntity> courses;
  final List<CourseDataEntity> running;
  final List<CourseDataEntity> upcoming;
  final List<CourseDataEntity> completed;

  const AllCourseDataEntity({
    required this.courses,
    required this.running,
    required this.upcoming,
    required this.completed,
  });
}

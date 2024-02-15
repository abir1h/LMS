import 'course_data_entity.dart';

class AllCourseDataEntity {
  final List<CourseDataEntity> courses;
  final List<CourseDataEntity> running;

  const AllCourseDataEntity({
    required this.courses,
    required this.running,
  });
}

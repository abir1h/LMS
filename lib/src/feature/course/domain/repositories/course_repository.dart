import '../../../shared/domain/entities/response_entity.dart';

abstract class CourseRepository {
  Future<ResponseEntity> getCourses();
  Future<ResponseEntity> getCourseDetails(int courseId);
}

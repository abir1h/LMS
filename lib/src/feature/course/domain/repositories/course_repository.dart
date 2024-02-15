import '../../../shared/domain/entities/response_entity.dart';

abstract class CourseRepository {
  Future<ResponseEntity> getCourses();
}

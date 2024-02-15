import '../repositories/course_repository.dart';
import '../../../shared/domain/entities/response_entity.dart';

class CourseUseCase {
  final CourseRepository _courseRepository;
  CourseUseCase({required CourseRepository courseRepository})
      : _courseRepository = courseRepository;

  Future<ResponseEntity> getCoursesUseCase() async {
    final response = _courseRepository.getCourses();
    return response;
  }
}

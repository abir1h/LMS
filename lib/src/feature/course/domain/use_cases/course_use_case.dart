import '../repositories/course_repository.dart';
import '../../../shared/domain/entities/response_entity.dart';

class CourseUseCase {
  final CourseRepository _courseRepository;
  CourseUseCase({required CourseRepository courseRepository})
      : _courseRepository = courseRepository;

  Future<ResponseEntity> getCoursesUseCase(String courseStatus) async {
    final response = _courseRepository.getCourses(courseStatus);
    return response;
  }

  Future<ResponseEntity> getCourseDetailsUseCase(int courseId) async {
    final response = _courseRepository.getCourseDetails(courseId);
    return response;
  }

  Future<ResponseEntity> getScriptDetailsUseCase(int courseContentId) async {
    final response = _courseRepository.getScriptDetails(courseContentId);
    return response;
  }

  Future<ResponseEntity> getBlendedClassUseCase(int courseContentId) async {
    final response = _courseRepository.getBlendedClass(courseContentId);
    return response;
  }

  Future<ResponseEntity> getVideoDetailsUseCase(int courseContentId) async {
    final response = _courseRepository.getVideoDetails(courseContentId);
    return response;
  }
}

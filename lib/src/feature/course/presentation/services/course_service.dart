import '../../data/data_sources/remote/course_data_source.dart';
import '../../data/repositories/course_repository_imp.dart';
import '../../domain/use_cases/course_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

mixin class CourseService {
  CourseService._();
  final CourseUseCase _courseUseCase = CourseUseCase(
      courseRepository:
      CourseRepositoryImp(courseRemoteDataSource: CourseRemoteDataSourceImp()));

  Future<ResponseEntity> getCourses() async {
    return _courseUseCase.getCoursesUseCase();
  }

  Future<ResponseEntity> getCourseDetails(int courseId) async {
    return _courseUseCase.getCourseDetailsUseCase(courseId);
  }

}

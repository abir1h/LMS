import '../mapper/course_details_data_mapper.dart';
import '../models/course_details_data_model.dart';
import '../../domain/entities/course_details_data_entity.dart';
import '../mapper/all_course_data_mapper.dart';
import '../models/all_course_data_model.dart';
import '../../domain/entities/all_course_data_entity.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../domain/repositories/course_repository.dart';
import '../data_sources/remote/course_data_source.dart';

class CourseRepositoryImp extends CourseRepository {
  final CourseRemoteDataSource courseRemoteDataSource;
  CourseRepositoryImp({required this.courseRemoteDataSource});

  @override
  Future<ResponseEntity> getCourses() async {
    ResponseModel responseModel =
        (await courseRemoteDataSource.getCoursesAction());
    return ResponseModelToEntityMapper<AllCourseDataEntity,
            AllCourseDataModel>()
        .toEntityFromModel(responseModel,
            (AllCourseDataModel model) => model.toAllCourseDataEntity);
  }

  @override
  Future<ResponseEntity> getCourseDetails(int courseId) async {
    ResponseModel responseModel =
        (await courseRemoteDataSource.getCourseDetailsAction(courseId));
    return ResponseModelToEntityMapper<CourseDetailsDataEntity,
            CourseDetailsDataModel>()
        .toEntityFromModel(responseModel,
            (CourseDetailsDataModel model) => model.toCourseDataEntity);
  }
}

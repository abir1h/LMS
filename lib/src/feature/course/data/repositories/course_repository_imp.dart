import 'package:lms/src/feature/course/data/mapper/blended_class_data_mapper.dart';
import 'package:lms/src/feature/course/data/mapper/content_read_data_mapper.dart';
import 'package:lms/src/feature/course/data/models/content_read_data_model.dart';
import 'package:lms/src/feature/course/domain/entities/content_read_data_entity.dart';
import 'package:lms/src/feature/notes/data/mapper/content_data_mapper.dart';
import 'package:lms/src/feature/notes/data/models/content_data_model.dart';
import 'package:lms/src/feature/notes/domain/entities/content_data_entity.dart';

import '../../domain/entities/blended_class_data_entity.dart';
import '../mapper/video_data_mapper.dart';
import '../../domain/entities/video_data_entity.dart';
import '../mapper/script_data_mapper.dart';
import '../../domain/entities/script_data_entity.dart';
import '../mapper/course_details_data_mapper.dart';
import '../models/blended_class_data_model.dart';
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
import '../models/script_data_model.dart';
import '../models/video_data_model.dart';

class CourseRepositoryImp extends CourseRepository {
  final CourseRemoteDataSource courseRemoteDataSource;
  CourseRepositoryImp({required this.courseRemoteDataSource});

  @override
  Future<ResponseEntity> getCourses(String courseStatus) async {
    ResponseModel responseModel =
        (await courseRemoteDataSource.getCoursesAction(courseStatus));
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

  @override
  Future<ResponseEntity> getScriptDetails(int courseContentId) async {
    ResponseModel responseModel =
        (await courseRemoteDataSource.getScriptDetailsAction(courseContentId));
    return ResponseModelToEntityMapper<ScriptDataEntity, ScriptDataModel>()
        .toEntityFromModel(
            responseModel, (ScriptDataModel model) => model.toScriptDataEntity);
  }

  @override
  Future<ResponseEntity> getBlendedClass(int courseContentId) async {
    ResponseModel responseModel =
        (await courseRemoteDataSource.getBlendedClassAction(courseContentId));
    return ResponseModelToEntityMapper<BlendedClassDataEntity,
            BlendedClassDataModel>()
        .toEntityFromModel(responseModel,
            (BlendedClassDataModel model) => model.toBlendedClassDataEntity);
  }

  @override
  Future<ResponseEntity> getVideoDetails(int courseContentId) async {
    ResponseModel responseModel =
        (await courseRemoteDataSource.getScriptDetailsAction(courseContentId));
    return ResponseModelToEntityMapper<VideoDataEntity, VideoDataModel>()
        .toEntityFromModel(
            responseModel, (VideoDataModel model) => model.toVideoDataEntity);
  }

  @override
  Future<ResponseEntity> contentRead(
      int contentId,
      String contentType,
      int courseId,
      bool isCompleted,
      String lastWatchTime,
      String attendanceType) async {
    ResponseModel responseModel =
        (await courseRemoteDataSource.contentReadAction(contentId, contentType,
            courseId, isCompleted, lastWatchTime, attendanceType));
    return ResponseModelToEntityMapper<ContentReadDataEntity, ContentReadDataModel>()
        .toEntityFromModel(responseModel,
            (ContentReadDataModel model) => model.toContentReadDataEntity);
  }
}

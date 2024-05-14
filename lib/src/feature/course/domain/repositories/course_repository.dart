import '../../../shared/domain/entities/response_entity.dart';

abstract class CourseRepository {
  Future<ResponseEntity> getCourses(String courseStatus);
  Future<ResponseEntity> getCourseDetails(int courseId);
  Future<ResponseEntity> getScriptDetails(int courseContentId);
  Future<ResponseEntity> getBlendedClass(int courseContentId);
  Future<ResponseEntity> getVideoDetails(int courseContentId);
  Future<ResponseEntity> contentRead(int contentId, String contentType, int courseId, bool isCompleted, String lastWatchTime, String attendanceType);
}

import 'package:lms/src/feature/course/domain/entities/blended_course_data_entity.dart';
import 'package:lms/src/feature/course/domain/entities/trainer_data_entity.dart';

class BlendedClassDataEntity {
  final int id;
  final int courseId;
  final int courseModuleId;
  final int trainerId;
  final int batchGroupId;
  final String classType;
  final String titleEn;
  final String titleBn;
  final String classSchedule;
  final int durations;
  final String time;
  final String location;
  final String details;
  final String attachment;
  final String platform;
  final String meetingLink;
  final String videoUrl;
  final String transcript;
  final List<BlendedCourseDataEntity>? workstations;
  final BlendedCourseDataEntity? course;
  final BlendedCourseDataEntity? courseModule;
  final TrainerDataEntity? trainer;

  const BlendedClassDataEntity({
    required this.id,
    required this.courseId,
    required this.courseModuleId,
    required this.trainerId,
    required this.batchGroupId,
    required this.classType,
    required this.titleEn,
    required this.titleBn,
    required this.classSchedule,
    required this.durations,
    required this.time,
    required this.location,
    required this.details,
    required this.attachment,
    required this.platform,
    required this.meetingLink,
    required this.videoUrl,
    required this.transcript,
    required this.workstations,
    required this.course,
    required this.courseModule,
    required this.trainer,
  });
}

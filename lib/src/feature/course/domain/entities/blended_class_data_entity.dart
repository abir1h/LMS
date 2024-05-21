import 'package:lms/src/feature/course/domain/entities/blended_course_data_entity.dart';
import 'package:lms/src/feature/course/domain/entities/trainer_data_entity.dart';

class BlendedClassDataEntity {
  final int id;
  final int courseId;
  final int courseModuleId;
  final int circularId;
  final int trainerId;
  final String titleEn;
  final String titleBn;
  final String classSchedule;
  final String durations;
  final String time;
  final String locationEn;
  final String locationBn;
  final String detailsEn;
  final String detailsBn;
  final String attachment;
  final String platform;
  final String meetingLink;
  final String videoUrl;
  final String transcriptEn;
  final String transcriptBn;
  final List<BlendedCourseDataEntity>? workstations;
  final BlendedCourseDataEntity? course;
  final BlendedCourseDataEntity? courseModule;
  final TrainerDataEntity? trainer;

  const BlendedClassDataEntity({
    required this.id,
    required this.courseId,
    required this.courseModuleId,
    required this.circularId,
    required this.trainerId,
    required this.titleEn,
    required this.titleBn,
    required this.classSchedule,
    required this.durations,
    required this.time,
    required this.locationEn,
    required this.locationBn,
    required this.detailsEn,
    required this.detailsBn,
    required this.attachment,
    required this.platform,
    required this.meetingLink,
    required this.videoUrl,
    required this.transcriptEn,
    required this.transcriptBn,
    required this.workstations,
    required this.course,
    required this.courseModule,
    required this.trainer,
  });
}

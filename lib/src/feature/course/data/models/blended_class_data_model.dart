import 'package:flutter/cupertino.dart';
import 'package:lms/src/feature/course/data/models/trainer_data_model.dart';

import 'blended_course_data_model.dart';

@immutable
class BlendedClassDataModel {
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
  final BlendedCourseDataModel? course;
  final BlendedCourseDataModel? courseModule;
  final TrainerDataModel? trainer;

  const BlendedClassDataModel({
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
    required this.course,
    required this.courseModule,
    required this.trainer,
  });

  factory BlendedClassDataModel.fromJson(Map<String, dynamic> json) =>
      BlendedClassDataModel(
        id: json["id"] ?? -1,
        courseId: json["course_id"] ?? -1,
        courseModuleId: json["course_module_id"] ?? -1,
        trainerId: json["trainer_id"] ?? -1,
        batchGroupId: json["batch_group_id"] ?? -1,
        classType: json["class_type"] ?? "",
        titleEn: json["title_en"] ?? "",
        titleBn: json["title_bn"] ?? "",
        classSchedule: json["class_schedule"] ?? "",
        durations: json["durations"] ?? -1,
        time: json["time"] ?? -1,
        location: json["location"] ?? "",
        details: json["details"] ?? "",
        attachment: json["attachment"] ?? "",
        platform: json["platform"] ?? "",
        meetingLink: json["meeting_link"] ?? "",
        videoUrl: json["video_url"] ?? "",
        transcript: json["transcript"] ?? "",
        course: json['course'] != null
            ? BlendedCourseDataModel.fromJson(json['course'])
            : null,
        courseModule: json['course_module'] != null
            ? BlendedCourseDataModel.fromJson(json['course_module'])
            : null,
        trainer: json['trainer'] != null
            ? TrainerDataModel.fromJson(json['trainer'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "course_module_id": courseModuleId,
        "trainer_id": trainerId,
        "batch_group_id": batchGroupId,
        "class_type": classType,
        "title_en": titleEn,
        "title_bn": titleBn,
        "class_schedule": classSchedule,
        "durations": durations,
        "time": time,
        "location": location,
        "details": details,
        "attachment": attachment,
        "platform": platform,
        "meeting_link": meetingLink,
        "video_url": videoUrl,
        "transcript": transcript,
        "course": course?.toJson(),
        "course_module": courseModule?.toJson(),
        "trainer": trainer?.toJson(),
      };
}


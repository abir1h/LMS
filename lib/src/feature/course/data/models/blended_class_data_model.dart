import 'package:flutter/cupertino.dart';

import 'trainer_data_model.dart';
import 'blended_course_data_model.dart';

@immutable
class BlendedClassDataModel {
  final int id;
  final int courseId;
  final int courseModuleId;
  final int circularId;
  final int trainerId;
  final String titleEn;
  final String titleBn;
  final String classSchedule;
  final int durations;
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
  final List<BlendedCourseDataModel>? workstations;
  final BlendedCourseDataModel? course;
  final BlendedCourseDataModel? courseModule;
  final TrainerDataModel? trainer;

  const BlendedClassDataModel({
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

  factory BlendedClassDataModel.fromJson(Map<String, dynamic> json) =>
      BlendedClassDataModel(
        id: json["id"] ?? -1,
        courseId: json["course_id"] ?? -1,
        courseModuleId: json["course_module_id"] ?? -1,
        circularId: json["circular_id"] ?? -1,
        trainerId: json["trainer_id"] ?? -1,
        titleEn: json["title_en"] ?? "",
        titleBn: json["title_bn"] ?? "",
        classSchedule: json["class_schedule"] ?? "",
        durations: json["durations"] ?? -1,
        time: json["time"] ?? "",
        locationEn: json["location_en"] ?? "",
        locationBn: json["location_bn"] ?? "",
        detailsEn: json["details_en"] ?? "",
        detailsBn: json["details_bn"] ?? "",
        attachment: json["attachment"] ?? "",
        platform: json["platform"] ?? "",
        meetingLink: json["meeting_link"] ?? "",
        videoUrl: json["video_url"] ?? "",
        transcriptEn: json["transcript_en"] ?? "",
        transcriptBn: json["transcript_bn"] ?? "",
        workstations: json["workstations"] != null
            ? List<BlendedCourseDataModel>.from((json["workstations"])
                .map((x) => BlendedCourseDataModel.fromJson(x)))
            : [],
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
        "circular_id": circularId,
        "trainer_id": trainerId,
        "title_en": titleEn,
        "title_bn": titleBn,
        "class_schedule": classSchedule,
        "durations": durations,
        "time": time,
        "location_en": locationEn,
        "location_bn": locationBn,
        "details_en": detailsEn,
        "details_bn": detailsBn,
        "attachment": attachment,
        "platform": platform,
        "meeting_link": meetingLink,
        "video_url": videoUrl,
        "transcript_en": transcriptEn,
        "transcript_bn": transcriptBn,
        "workstations": List<BlendedCourseDataModel>.from(
            workstations!.map((x) => x.toJson())),
        "course": course?.toJson(),
        "course_module": courseModule?.toJson(),
        "trainer": trainer?.toJson(),
      };
}

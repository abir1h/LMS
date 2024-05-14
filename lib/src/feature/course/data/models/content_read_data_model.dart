import 'package:flutter/cupertino.dart';

@immutable
class ContentReadDataModel {
  final int id;
  final int circularId;
  final int courseId;
  final String contentType;
  final int contentId;
  final int traineeId;
  final bool isCompleted;
  final String lastWatchTime;
  final String createdAt;
  final String updatedAt;
  final String attendanceType;

  const ContentReadDataModel({
    required this.id,
    required this.circularId,
    required this.courseId,
    required this.contentType,
    required this.contentId,
    required this.traineeId,
    required this.isCompleted,
    required this.lastWatchTime,
    required this.createdAt,
    required this.updatedAt,
    required this.attendanceType,
  });

  factory ContentReadDataModel.fromJson(Map<String, dynamic> json) => ContentReadDataModel(
    id: json["id"]??-1,
    circularId: json["circular_id"]??-1,
    courseId: json["course_id"]??-1,
    contentType: json["content_type"]??"",
    contentId: json["content_id"]??-1,
    traineeId: json["trainee_id"]??-1,
    isCompleted: json["is_completed"]??false,
    lastWatchTime: json["last_watch_time"]??"",
    createdAt: json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
    attendanceType: json["attendance_type"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "circular_id": circularId,
    "course_id": courseId,
    "content_type": contentType,
    "content_id": contentId,
    "trainee_id": traineeId,
    "is_completed": isCompleted,
    "last_watch_time": lastWatchTime,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "attendance_type": attendanceType,
  };
}

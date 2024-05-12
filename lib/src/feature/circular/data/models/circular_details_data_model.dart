import 'package:flutter/material.dart';

import 'batch_data_model.dart';
import '../../../course/data/models/trainer_data_model.dart';

@immutable
class CircularDetailsDataModel {
  final int id;
  final int batchId;
  final int courseId;
  final String referenceNumber;
  final String nameEn;
  final String nameBn;
  final String slug;
  final String shortDescEn;
  final String shortDescBn;
  final String longDescEn;
  final String longDescBn;
  final String featuredImage;
  final String supportingDoc;
  final String startDate;
  final String endDate;
  final String publishDate;
  final String flag;
  final String url;
  final int status;
  final bool isCourseCloned;
  final bool isAssessmentsCloned;
  final bool isAssignmentsCloned;
  final bool isVideoCloned;
  final bool isProcessing;
  final int createdBy;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final int batchCoordinatorId;
  final String venueType;
  final String venueName;
  final int venueId;
  final String batchCoordinatorNameEn;
  final String batchCoordinatorNameBn;
  final List<BatchDataModel>? workstations;
  final List<TrainerDataModel>? trainers;
  final BatchDataModel? batch;
  final BatchDataModel? course;

  const CircularDetailsDataModel({
    required this.id,
    required this.batchId,
    required this.courseId,
    required this.referenceNumber,
    required this.nameEn,
    required this.nameBn,
    required this.slug,
    required this.shortDescEn,
    required this.shortDescBn,
    required this.longDescEn,
    required this.longDescBn,
    required this.featuredImage,
    required this.supportingDoc,
    required this.startDate,
    required this.endDate,
    required this.publishDate,
    required this.flag,
    required this.url,
    required this.status,
    required this.isCourseCloned,
    required this.isAssessmentsCloned,
    required this.isAssignmentsCloned,
    required this.isVideoCloned,
    required this.isProcessing,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.batchCoordinatorId,
    required this.venueType,
    required this.venueName,
    required this.venueId,
    required this.batchCoordinatorNameEn,
    required this.batchCoordinatorNameBn,
    required this.workstations,
    required this.trainers,
    required this.batch,
    required this.course,
  });

  factory CircularDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      CircularDetailsDataModel(
        id: json["id"] ?? -1,
        batchId: json["batch_id"] ?? -1,
        courseId: json["course_id"] ?? -1,
        referenceNumber: json["reference_number"] ?? "",
        nameEn: json["name_en"] ?? "",
        nameBn: json["name_bn"] ?? "",
        slug: json["slug"] ?? "",
        shortDescEn: json["short_desc_en"] ?? "",
        shortDescBn: json["short_desc_bn"] ?? "",
        longDescEn: json["long_desc_en"] ?? "",
        longDescBn: json["long_desc_bn"] ?? "",
        featuredImage: json["featured_image"] ?? "",
        supportingDoc: json["supporting_doc"] ?? "",
        startDate: json["start_date"] ?? "",
        endDate: json["end_date"] ?? "",
        publishDate: json["publish_date"] ?? "",
        flag: json["flag"] ?? "",
        url: json["url"] ?? "",
        status: json["status"] ?? -1,
        isCourseCloned: json["is_course_cloned"] ?? false,
        isAssessmentsCloned: json["is_assessments_cloned"] ?? false,
        isAssignmentsCloned: json["is_assignments_cloned"] ?? false,
        isVideoCloned: json["is_video_cloned"] ?? false,
        isProcessing: json["is_processing"] ?? false,
        createdBy: json["created_by"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
        batchCoordinatorId: json["batch_coordinator_id"] ?? -1,
        venueType: json["venue_type"] ?? "",
        venueName: json["venue_name"] ?? "",
        venueId: json["venue_id"] ?? -1,
        batchCoordinatorNameEn: json["batch_coordinator_name_en"] ?? "",
        batchCoordinatorNameBn: json["batch_coordinator_name_bn"] ?? "",
        workstations: json["workstations"] != null
            ? List<BatchDataModel>.from(
                (json["workstations"]).map((x) => BatchDataModel.fromJson(x)))
            : [],
        trainers: json["trainers"] != null
            ? List<TrainerDataModel>.from(
                (json["trainers"]).map((x) => TrainerDataModel.fromJson(x)))
            : [],
        batch: json['course'] != null
            ? BatchDataModel.fromJson(json["course"])
            : null,
        course: json['course'] != null
            ? BatchDataModel.fromJson(json["course"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "batch_id": batchId,
        "course_id": courseId,
        "reference_number": referenceNumber,
        "name_en": nameEn,
        "name_bn": nameBn,
        "slug": slug,
        "short_desc_en": shortDescEn,
        "short_desc_bn": shortDescBn,
        "long_desc_en": longDescEn,
        "long_desc_bn": longDescBn,
        "featured_image": featuredImage,
        "supporting_doc": supportingDoc,
        "start_date": startDate,
        "end_date": endDate,
        "publish_date": publishDate,
        "flag": flag,
        "url": url,
        "status": status,
        "is_course_cloned": isCourseCloned,
        "is_assessments_cloned": isAssessmentsCloned,
        "is_assignments_cloned": isAssignmentsCloned,
        "is_video_cloned": isVideoCloned,
        "is_processing": isProcessing,
        "created_by": createdBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "batch_coordinator_id": batchCoordinatorId,
        "venue_type": venueType,
        "venue_name": venueName,
        "venue_id": venueId,
        "batch_coordinator_name_en": batchCoordinatorNameEn,
        "batch_coordinator_name_bn": batchCoordinatorNameBn,
        "workstations":
            List<BatchDataModel>.from(workstations!.map((x) => x.toJson())),
        "trainers":
            List<TrainerDataModel>.from(trainers!.map((x) => x.toJson())),
        "batch": batch?.toJson(),
        "course": course?.toJson(),
      };
}

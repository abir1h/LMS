import '../../../course/domain/entities/trainer_data_entity.dart';
import 'batch_data_entity.dart';

class CircularDetailsDataEntity {
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
  final List<BatchDataEntity> workstations;
  final List<TrainerDataEntity> trainers;
  final BatchDataEntity batch;
  final BatchDataEntity course;

  CircularDetailsDataEntity({
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
    required this.workstations,
    required this.trainers,
    required this.batch,
    required this.course,
  });
}

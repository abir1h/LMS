import 'package:lms/src/feature/circular/data/mapper/batch_data_mapper.dart';
import 'package:lms/src/feature/circular/data/models/batch_data_model.dart';
import 'package:lms/src/feature/course/data/mapper/trainer_data_mapper.dart';
import 'package:lms/src/feature/course/data/models/trainer_data_model.dart';
import 'package:lms/src/feature/course/domain/entities/trainer_data_entity.dart';

import '../../domain/entities/batch_data_entity.dart';
import '../../domain/entities/circular_details_data_entity.dart';
import '../models/circular_details_data_model.dart';

abstract class CircularDetailsDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class CircularDetailsDataModelToEntityMapper extends CircularDetailsDataMapper<
    CircularDetailsDataModel, CircularDetailsDataEntity> {
  @override
  CircularDetailsDataModel fromEntityToModel(CircularDetailsDataEntity entity) {
    return CircularDetailsDataModel(
        id: entity.id,
        batchId: entity.batchId,
        courseId: entity.courseId,
        referenceNumber: entity.referenceNumber,
        nameEn: entity.nameEn,
        nameBn: entity.nameBn,
        slug: entity.slug,
        shortDescEn: entity.shortDescEn,
        shortDescBn: entity.shortDescBn,
        longDescEn: entity.longDescEn,
        longDescBn: entity.longDescBn,
        featuredImage: entity.featuredImage,
        supportingDoc: entity.supportingDoc,
        startDate: entity.startDate,
        endDate: entity.endDate,
        publishDate: entity.publishDate,
        flag: entity.flag,
        url: entity.url,
        status: entity.status,
        isCourseCloned: entity.isCourseCloned,
        isAssessmentsCloned: entity.isAssessmentsCloned,
        isAssignmentsCloned: entity.isAssignmentsCloned,
        isVideoCloned: entity.isVideoCloned,
        isProcessing: entity.isProcessing,
        createdBy: entity.createdBy,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        deletedAt: entity.deletedAt,
        workstations: List<BatchDataEntity>.from(entity.workstations)
            .map((entity) => entity.toBatchDataModel)
            .toList(),
        trainers: List<TrainerDataEntity>.from(entity.trainers)
            .map((entity) => entity.toTrainerDataModel)
            .toList(),
        batch: entity.batch.toBatchDataModel,
        course: entity.course.toBatchDataModel);
  }

  @override
  CircularDetailsDataEntity toEntityFromModel(CircularDetailsDataModel model) {
    return CircularDetailsDataEntity(
        id: model.id,
        batchId: model.batchId,
        courseId: model.courseId,
        referenceNumber: model.referenceNumber,
        nameEn: model.nameEn,
        nameBn: model.nameBn,
        slug: model.slug,
        shortDescEn: model.shortDescEn,
        shortDescBn: model.shortDescBn,
        longDescEn: model.longDescEn,
        longDescBn: model.longDescBn,
        featuredImage: model.featuredImage,
        supportingDoc: model.supportingDoc,
        startDate: model.startDate,
        endDate: model.endDate,
        publishDate: model.publishDate,
        flag: model.flag,
        url: model.url,
        status: model.status,
        isCourseCloned: model.isCourseCloned,
        isAssessmentsCloned: model.isAssessmentsCloned,
        isAssignmentsCloned: model.isAssignmentsCloned,
        isVideoCloned: model.isVideoCloned,
        isProcessing: model.isProcessing,
        createdBy: model.createdBy,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        deletedAt: model.deletedAt,
        workstations: List<BatchDataModel>.from(model.workstations!)
            .map((entity) => entity.toBatchDataEntity)
            .toList(),
        trainers: List<TrainerDataModel>.from(model.trainers!)
            .map((entity) => entity.toTrainerDataEntity)
            .toList(),
        batch: model.batch!.toBatchDataEntity,
        course: model.course!.toBatchDataEntity);
  }
}

extension CircularDetailsDataModelExt on CircularDetailsDataModel {
  CircularDetailsDataEntity get toCircularDetailsDataEntity =>
      CircularDetailsDataModelToEntityMapper().toEntityFromModel(this);
}

extension CircularDetailsDataEntityExt on CircularDetailsDataEntity {
  CircularDetailsDataModel get toCircularDetailsDataModel =>
      CircularDetailsDataModelToEntityMapper().fromEntityToModel(this);
}

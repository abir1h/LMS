import 'package:lms/src/feature/assessment/data/mapper/question_type_data_mapper.dart';

import '../../domain/entities/result_data_entity.dart';
import '../models/result_data_model.dart';
import 'option_data_mapper.dart';
import '../models/option_data_model.dart';
import '../../domain/entities/option_data_entity.dart';
import '../../domain/entities/question_data_entity.dart';
import '../models/question_data_model.dart';

abstract class ResultDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class ResultDataModelToEntityMapper
    extends ResultDataMapper<ResultDataModel, ResultDataEntity> {
  @override
  ResultDataModel fromEntityToModel(ResultDataEntity entity) {
    return ResultDataModel(
        id: entity.id,
        traineeId: entity.traineeId,
        circularAssessmentId: entity.circularAssessmentId,
        startTime: entity.startTime,
        endTime: entity.endTime,
        completionTime: entity.completionTime,
        answeredQuestion: entity.answeredQuestion,
        totalMark: entity.totalMark,
        availedMark: entity.availedMark,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        deletedAt: entity.deletedAt);
  }

  @override
  ResultDataEntity toEntityFromModel(ResultDataModel model) {
    return ResultDataEntity(
        id: model.id,
        traineeId: model.traineeId,
        circularAssessmentId: model.circularAssessmentId,
        startTime: model.startTime,
        endTime: model.endTime,
        completionTime: model.completionTime,
        answeredQuestion: model.answeredQuestion,
        totalMark: model.totalMark,
        availedMark: model.availedMark,
        status: model.status,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        deletedAt: model.deletedAt);
  }
}

extension ResultDataModelExt on ResultDataModel {
  ResultDataEntity get toResultDataEntity =>
      ResultDataModelToEntityMapper().toEntityFromModel(this);
}

extension ResultDataEntityExt on ResultDataEntity {
  ResultDataModel get toResultDataModel =>
      ResultDataModelToEntityMapper().fromEntityToModel(this);
}

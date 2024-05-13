import 'package:lms/src/feature/profile/data/mapper/emis_user_data_mapper.dart';

import '../../domain/entities/completed_course_data_entity.dart';
import '../../domain/entities/emis_user_data_entity.dart';
import '../../domain/entities/user_info_data_entity.dart';
import '../models/completed_course_data_model.dart';
import '../models/emis_user_data_model.dart';
import '../models/user_info_data_model.dart';

abstract class CompletedCourseDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CompletedCourseDataModelToEntityMapper extends CompletedCourseDataMapper<
    CompletedCourseDataModel, CompletedCourseDataEntity> {
  @override
  CompletedCourseDataModel fromEntityToModel(CompletedCourseDataEntity entity) {
    return CompletedCourseDataModel(
        id: entity.id,
        code: entity.code,
        nameEn: entity.nameEn,
        nameBn: entity.nameBn,
        circularId: entity.circularId,
        endDate: entity.endDate,
        circularStatus: entity.circularStatus,
        marks: entity.marks);
  }

  @override
  CompletedCourseDataEntity toEntityFromModel(CompletedCourseDataModel model) {
    return CompletedCourseDataEntity(
        id: model.id,
        code: model.code,
        nameEn: model.nameEn,
        nameBn:model. nameBn,
        circularId: model.circularId,
        endDate: model.endDate,
        circularStatus: model.circularStatus,
        marks: model.marks);
  }
}

extension CompletedCourseDataModelExt on CompletedCourseDataModel {
  CompletedCourseDataEntity get toCompletedCourseDataEntity =>
      _CompletedCourseDataModelToEntityMapper().toEntityFromModel(this);
}

extension CompletedCourseDataEntityExt on CompletedCourseDataEntity {
  CompletedCourseDataModel get toCompletedCourseDataModel =>
      _CompletedCourseDataModelToEntityMapper().fromEntityToModel(this);
}

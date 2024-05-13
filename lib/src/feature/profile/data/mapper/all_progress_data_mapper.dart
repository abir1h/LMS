import 'package:lms/src/feature/discussion/data/mapper/user_data_mapper.dart';
import 'package:lms/src/feature/profile/data/mapper/completed_course_data_mapper.dart';
import 'package:lms/src/feature/profile/data/mapper/progress_course_data_mapper.dart';
import 'package:lms/src/feature/profile/data/mapper/user_info_data_mapper.dart';
import 'package:lms/src/feature/profile/data/models/completed_course_data_model.dart';
import 'package:lms/src/feature/profile/data/models/progress_course_data_model.dart';
import 'package:lms/src/feature/profile/domain/entities/completed_course_data_entity.dart';
import 'package:lms/src/feature/profile/domain/entities/progress_course_data_entity.dart';

import '../../domain/entities/all_progress_data_entity.dart';
import '../models/all_progress_data_model.dart';

abstract class AllProgressDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class AllProgressDataModelToEntityMapper
    extends AllProgressDataMapper<AllProgressDataModel, AllProgressDataEntity> {
  @override
  AllProgressDataModel fromEntityToModel(AllProgressDataEntity entity) {
    return AllProgressDataModel(
        running: List<ProgressCourseDataEntity>.from(entity.running)
            .map((entity) => entity.toProgressDataModel)
            .toList(),
        completed: List<CompletedCourseDataEntity>.from(entity.completed)
            .map((entity) => entity.toCompletedCourseDataModel)
            .toList(),
        userInfoDataModel: entity.userInfoDataEntity!.toUserInfoDataModel);
  }

  @override
  AllProgressDataEntity toEntityFromModel(AllProgressDataModel model) {
    return AllProgressDataEntity(
        running: List<ProgressCourseDataModel>.from(model.running)
            .map((model) => model.toProgressDataEntity)
            .toList(),
        completed: List<CompletedCourseDataModel>.from(model.completed)
            .map((model) => model.toCompletedCourseDataEntity)
            .toList(),
        userInfoDataEntity: model.userInfoDataModel!.toUserInfoDataEntity);
  }
}

extension AllProgressDataModelExt on AllProgressDataModel {
  AllProgressDataEntity get toAllProgressDataEntity =>
      AllProgressDataModelToEntityMapper().toEntityFromModel(this);
}

extension AllProgressDataEntityExt on AllProgressDataEntity {
  AllProgressDataModel get toAllProgressDataModel =>
      AllProgressDataModelToEntityMapper().fromEntityToModel(this);
}

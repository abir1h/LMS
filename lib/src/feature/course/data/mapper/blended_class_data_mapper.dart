import '../../domain/entities/blended_course_data_entity.dart';
import '../models/blended_course_data_model.dart';
import 'blended_course_data_mapper.dart';
import 'trainer_data_mapper.dart';
import '../../domain/entities/blended_class_data_entity.dart';
import '../models/blended_class_data_model.dart';

abstract class BlendedClassDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class BlendedClassDataModelToEntityMapper extends BlendedClassDataMapper<
    BlendedClassDataModel, BlendedClassDataEntity> {
  @override
  BlendedClassDataModel fromEntityToModel(BlendedClassDataEntity entity) {
    return BlendedClassDataModel(
        id: entity.id,
        courseId: entity.courseId,
        courseModuleId: entity.courseModuleId,
        circularId: entity.circularId,
        trainerId: entity.trainerId,
        titleEn: entity.titleEn,
        titleBn: entity.titleBn,
        classSchedule: entity.classSchedule,
        durations: entity.durations,
        time: entity.time,
        locationEn: entity.locationEn,
        locationBn: entity.locationBn,
        detailsEn: entity.detailsEn,
        detailsBn: entity.detailsBn,
        attachment: entity.attachment,
        platform: entity.platform,
        meetingLink: entity.meetingLink,
        videoUrl: entity.videoUrl,
        transcriptEn: entity.transcriptEn,
        transcriptBn: entity.transcriptBn,
        workstations: List<BlendedCourseDataEntity>.from(entity.workstations!)
            .map((entity) => entity.toBlendedCourseDataModel)
            .toList(),
        course: entity.course?.toBlendedCourseDataModel,
        courseModule: entity.courseModule?.toBlendedCourseDataModel,
        trainer: entity.trainer?.toTrainerDataModel);
  }

  @override
  BlendedClassDataEntity toEntityFromModel(BlendedClassDataModel model) {
    return BlendedClassDataEntity(
        id: model.id,
        courseId: model.courseId,
        courseModuleId: model.courseModuleId,
        circularId: model.circularId,
        trainerId: model.trainerId,
        titleEn: model.titleEn,
        titleBn: model.titleBn,
        classSchedule: model.classSchedule,
        durations: model.durations,
        time: model.time,
        locationEn: model.locationEn,
        locationBn: model.locationBn,
        detailsEn: model.detailsEn,
        detailsBn: model.detailsBn,
        attachment: model.attachment,
        platform: model.platform,
        meetingLink: model.meetingLink,
        videoUrl: model.videoUrl,
        transcriptEn: model.transcriptEn,
        transcriptBn: model.transcriptBn,
        workstations: List<BlendedCourseDataModel>.from(model.workstations!)
            .map((entity) => entity.toBlendedCourseDataEntity)
            .toList(),
        course: model.course?.toBlendedCourseDataEntity,
        courseModule: model.courseModule?.toBlendedCourseDataEntity,
        trainer: model.trainer?.toTrainerDataEntity);
  }
}

extension BlendedClassDataModelExt on BlendedClassDataModel {
  BlendedClassDataEntity get toBlendedClassDataEntity =>
      BlendedClassDataModelToEntityMapper().toEntityFromModel(this);
}

extension BlendedClassDataEntityExt on BlendedClassDataEntity {
  BlendedClassDataModel get toBlendedClassDataModel =>
      BlendedClassDataModelToEntityMapper().fromEntityToModel(this);
}

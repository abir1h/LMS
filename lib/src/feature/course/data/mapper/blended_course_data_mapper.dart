import '../../domain/entities/blended_course_data_entity.dart';
import '../../domain/entities/course_content_data_entity.dart';
import '../models/blended_course_data_model.dart';
import '../models/course_content_data_model.dart';

abstract class BlendedCourseDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class BlendedCourseDataModelToEntityMapper extends BlendedCourseDataMapper<
    BlendedCourseDataModel, BlendedCourseDataEntity> {
  @override
  BlendedCourseDataModel fromEntityToModel(BlendedCourseDataEntity entity) {
    return BlendedCourseDataModel(id: entity.id, nameEn: entity.nameEn, nameBn: entity.nameBn);
  }

  @override
  BlendedCourseDataEntity toEntityFromModel(BlendedCourseDataModel model) {
    return BlendedCourseDataEntity(id: model.id, nameEn: model.nameEn, nameBn: model.nameBn);

  }
}

extension BlendedCourseDataModelExt on BlendedCourseDataModel {
  BlendedCourseDataEntity get toBlendedCourseDataEntity =>
      BlendedCourseDataModelToEntityMapper().toEntityFromModel(this);
}

extension BlendedCourseDataEntityExt on BlendedCourseDataEntity {
  BlendedCourseDataModel get toBlendedCourseDataModel =>
      BlendedCourseDataModelToEntityMapper().fromEntityToModel(this);
}

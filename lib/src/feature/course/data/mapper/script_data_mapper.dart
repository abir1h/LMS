import '../../domain/entities/script_data_entity.dart';
import '../models/script_data_model.dart';


abstract class ScriptDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class ScriptDataModelToEntityMapper
    extends ScriptDataMapper<ScriptDataModel, ScriptDataEntity> {
  @override
  ScriptDataModel fromEntityToModel(ScriptDataEntity entity) {
    return ScriptDataModel(
        id: entity.id,
        courseId: entity.courseId,
        courseModuleId: entity.courseModuleId,
        titleEn: entity.titleEn,
        titleBn: entity.titleBn,
        descriptionEn: entity.descriptionEn,
        descriptionBn: entity.descriptionBn,
        file: entity.file,
        readingTime: entity.readingTime,
        status: entity.status);
  }

  @override
  ScriptDataEntity toEntityFromModel(ScriptDataModel model) {
    return ScriptDataEntity(
        id: model.id,
        courseId: model.courseId,
        courseModuleId: model.courseModuleId,
        titleEn: model.titleEn,
        titleBn: model.titleBn,
        descriptionEn: model.descriptionEn,
        descriptionBn: model.descriptionBn,
        file: model.file,
        readingTime: model.readingTime,
        status: model.status);
  }
}

extension ScriptDataModelExt on ScriptDataModel {
  ScriptDataEntity get toScriptDataEntity =>
      ScriptDataModelToEntityMapper().toEntityFromModel(this);
}

extension ScriptDataEntityExt on ScriptDataEntity {
  ScriptDataModel get toScriptDataModel =>
      ScriptDataModelToEntityMapper().fromEntityToModel(this);
}

import 'content_count_data_mapper.dart';
import 'last_viewed_content_data_mapper.dart';
import 'upcoming_class_data_mapper.dart';
import 'course_module_data_mapper.dart';
import 'course_type_data_mapper.dart';
import '../../domain/entities/course_details_data_entity.dart';
import '../../domain/entities/course_module_data_entity.dart';
import '../models/course_details_data_model.dart';
import '../models/course_module_data_model.dart';

abstract class CourseDetailsDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class CourseDetailsDataModelToEntityMapper extends CourseDetailsDataMapper<
    CourseDetailsDataModel, CourseDetailsDataEntity> {
  @override
  CourseDetailsDataModel fromEntityToModel(CourseDetailsDataEntity entity) {
    return CourseDetailsDataModel(
      id: entity.id,
      code: entity.code,
      nameEn: entity.nameEn,
      nameBn: entity.nameBn,
      shortDescEn: entity.shortDescEn,
      shortDescBn: entity.shortDescBn,
      courseTypeId: entity.courseTypeId,
      icon: entity.icon,
      featuredImage: entity.featuredImage,
      supportingDoc: entity.supportingDoc,
      longDescEn: entity.longDescEn,
      longDescBn: entity.longDescBn,
      upcomingClass: entity.upcomingClass?.toUpcomingClassDataModel,
      contentCount: entity.contentCount?.toContentCountDataModel,
      lastViewedContent: entity.lastViewedContent?.toLastViewedContentDataModel,
      courseType: entity.courseType?.toCourseTypeDataModel,
      courseModules: List<CourseModuleDataEntity>.from(entity.courseModules!)
          .map((entity) => entity.toCourseModuleDataModel)
          .toList(),
    );
  }

  @override
  CourseDetailsDataEntity toEntityFromModel(CourseDetailsDataModel model) {
    return CourseDetailsDataEntity(
      id: model.id,
      code: model.code,
      nameEn: model.nameEn,
      nameBn: model.nameBn,
      shortDescEn: model.shortDescEn,
      shortDescBn: model.shortDescBn,
      courseTypeId: model.courseTypeId,
      icon: model.icon,
      featuredImage: model.featuredImage,
      supportingDoc: model.supportingDoc,
      longDescEn: model.longDescEn,
      longDescBn: model.longDescBn,
      upcomingClass: model.upcomingClass?.toUpcomingClassDataEntity,
      contentCount: model.contentCount?.toContentCountDataEntity,
      lastViewedContent: model.lastViewedContent?.toLastViewedContentDataEntity,
      courseType: model.courseType?.toCourseTypeDataEntity,
      courseModules: List<CourseModuleDataModel>.from(model.courseModules!)
          .map((model) => model.toCourseModuleDataEntity)
          .toList(),
    );
  }
}

extension CourseDetailsDataModelExt on CourseDetailsDataModel {
  CourseDetailsDataEntity get toCourseDataEntity =>
      CourseDetailsDataModelToEntityMapper().toEntityFromModel(this);
}

extension CourseDetailsDataEntityExt on CourseDetailsDataEntity {
  CourseDetailsDataModel get toCourseDataModel =>
      CourseDetailsDataModelToEntityMapper().fromEntityToModel(this);
}

import 'course_module_data_entity.dart';
import 'course_type_data_entity.dart';

class CourseDetailsDataEntity {
  final int id;
  final String code;
  final String nameEn;
  final String nameBn;
  final String shortDescEn;
  final String shortDescBn;
  final int courseTypeId;
  final CourseTypeDataEntity? courseType;
  final List<CourseModuleDataEntity>? courseModules;

  const CourseDetailsDataEntity({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.shortDescEn,
    required this.shortDescBn,
    required this.courseTypeId,
    required this.courseType,
    required this.courseModules,
  });
}

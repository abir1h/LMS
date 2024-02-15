import 'package:lms/src/feature/course/domain/entities/course_module_data_entity.dart';
import 'package:lms/src/feature/course/domain/entities/course_type_data_entity.dart';

import '../../data/models/course_module_data_model.dart';
import '../../data/models/course_type_data_model.dart';

class CourseDataEntity {
  final int id;
  final String code;
  final String nameEn;
  final String nameBn;
  final String shortDescEn;
  final String shortDescBn;
  final int courseTypeId;
  final CourseTypeDataEntity? courseType;
  final List<CourseModuleDataEntity>? courseModules;

  const CourseDataEntity({
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

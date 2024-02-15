import 'package:lms/src/feature/course/domain/entities/course_content_data_entity.dart';

import '../../data/models/course_content_data_model.dart';

class CourseModuleDataEntity {
  final int id;
  final int courseId;
  final String code;
  final String nameEn;
  final String nameBn;
  final String startDate;
  final String endDate;
  final int sort;
  final bool isModified;
  final List<CourseContentDataEntity>? courseContents;

  const CourseModuleDataEntity({
    required this.id,
    required this.courseId,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.startDate,
    required this.endDate,
    required this.sort,
    required this.isModified,
    required this.courseContents,
  });
}

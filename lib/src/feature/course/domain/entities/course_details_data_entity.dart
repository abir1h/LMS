import 'content_count_data_entity.dart';
import 'course_content_data_entity.dart';
import 'course_module_data_entity.dart';
import 'course_type_data_entity.dart';
import 'upcoming_class_data_entity.dart';

class CourseDetailsDataEntity {
  final int id;
  final String code;
  final String nameEn;
  final String nameBn;
  final String shortDescEn;
  final String shortDescBn;
  final int courseTypeId;
  final String icon;
  final String featuredImage;
  final String supportingDoc;
  final String longDescEn;
  final String longDescBn;
  final UpcomingClassDataEntity? upcomingClass;
  final ContentCountDataEntity? contentCount;
  final CourseContentDataEntity? lastViewedContent;
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
    required this.icon,
    required this.featuredImage,
    required this.supportingDoc,
    required this.longDescEn,
    required this.longDescBn,
    required this.upcomingClass,
    required this.contentCount,
    required this.lastViewedContent,
    required this.courseType,
    required this.courseModules,
  });
}

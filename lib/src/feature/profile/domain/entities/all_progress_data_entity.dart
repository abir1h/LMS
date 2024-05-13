import 'package:lms/src/feature/discussion/domain/entities/user_data_entity.dart';
import 'package:lms/src/feature/profile/domain/entities/completed_course_data_entity.dart';
import 'package:lms/src/feature/profile/domain/entities/user_info_data_entity.dart';

import 'progress_course_data_entity.dart';
import '../../data/models/user_info_data_model.dart';

class AllProgressDataEntity {
  final List<ProgressCourseDataEntity> running;
  final List<CompletedCourseDataEntity> completed;
  final UserInfoDataEntity? userInfoDataEntity;

  const AllProgressDataEntity(
      {required this.running,
      required this.completed,
      required this.userInfoDataEntity});
}

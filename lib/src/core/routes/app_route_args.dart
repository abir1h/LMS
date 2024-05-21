import 'dart:ui';

import '../../feature/assessment/domain/entities/exam_data_entity.dart';
import '../../feature/assignment/domain/entities/assignment_data_entity.dart';
import '../../feature/assignment/presentation/models/assignment_model.dart';
import '../../feature/course/domain/entities/course_content_data_entity.dart';
import '../../feature/notes/domain/entities/note_data_entity.dart';

enum NoteType { edit, create, readMode }

class EMISWebViewScreenArgs {
  final String webViewLink;
  EMISWebViewScreenArgs({required this.webViewLink});
}

class RootScreenArgs {
  final int index;
  RootScreenArgs({required this.index});
}

class CourseListScreenArgs {
  final String circularStatus;
  CourseListScreenArgs({required this.circularStatus});
}

class CourseDetailsScreenArgs {
  final int courseId;
  final String curriculumType;
  CourseDetailsScreenArgs(
      {required this.courseId, required this.curriculumType});
}

class CourseScriptScreenArgs {
  final int courseContentId;
  final String courseContentType;
  final String courseCode;
  final String courseDescriptionEn;
  final String courseDescriptionBn;
  CourseScriptScreenArgs({
    required this.courseContentId,
    required this.courseContentType,
    required this.courseCode,
    required this.courseDescriptionEn,
    required this.courseDescriptionBn,
  });
}

class CourseBlendedScreenArgs {
  final int courseContentId;
  CourseBlendedScreenArgs({
    required this.courseContentId,
  });
}

class CourseVideoScreenArgs {
  final CourseContentDataEntity data;
  CourseVideoScreenArgs(
      {required this.data});
}

class CourseAssessmentScreenArgs {
  final int courseContentId;
  final VoidCallback onTap;
  CourseAssessmentScreenArgs(
      {required this.courseContentId, required this.onTap});
}

class AssignmentArgs {
  final int courseContentId;
  AssignmentArgs({required this.courseContentId});
}

class AssignmentSubmitScreenArgs {
  final AssignmentModel? assignmentModel;
  final AssignmentDataEntity? assignmentDataEntity;
  final String? answer;
  AssignmentSubmitScreenArgs(
      {this.assignmentModel, this.assignmentDataEntity, this.answer});
}

class ModuleDiscussionArgs {
  final int courseId, courseModuleId;
  ModuleDiscussionArgs({required this.courseId, required this.courseModuleId});
}

class DetailedDiscussionArgs {
  final int discussionId;
  DetailedDiscussionArgs({required this.discussionId});
}

class NoteDetailsScreenArgs {
  final NoteDataEntity? noteDataEntity;
  final NoteType? noteType;
  NoteDetailsScreenArgs({this.noteType, required this.noteDataEntity});
}

class CircularDetailsScreenArgs {
  final int circularId;
  CircularDetailsScreenArgs({required this.circularId});
}

class AssessmentScreenArgs {
  final ExamDataEntity examData;
  AssessmentScreenArgs({required this.examData});
}

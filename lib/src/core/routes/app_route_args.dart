import 'dart:ui';

import '../../feature/assignment/presentation/models/assignment_model.dart';
import '../../feature/discussion/models/discussion_model.dart';
import '../../feature/notes/presentation/models/note_model.dart';

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
  final String status;
  CourseDetailsScreenArgs(
      {required this.courseId,
      required this.curriculumType,
      required this.status});
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

class CourseAssessmentScreenArgs {
  final int courseContentId;
  final VoidCallback onTap;
  CourseAssessmentScreenArgs(
      {required this.courseContentId, required this.onTap});
}

class AssignmentSubmitScreenArgs {
  final AssignmentModel? assignmentModel;
  AssignmentSubmitScreenArgs({this.assignmentModel});
}

class DetailedDiscussionArgs {
  final int discussionId;
  DetailedDiscussionArgs({required this.discussionId});
}

class NoteDetailsScreenArgs {
  final NoteModel? noteModel;
  NoteDetailsScreenArgs({this.noteModel});
}

class CircularDetailsScreenArgs {
  final int circularId;
  CircularDetailsScreenArgs({required this.circularId});
}

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

class CourseIntroductionScreenArgs {
  final String screenTitle;
  CourseIntroductionScreenArgs({required this.screenTitle});
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
  final DiscussionModel? discussionModel;
  DetailedDiscussionArgs({this.discussionModel});
}

class NoteDetailsScreenArgs {
  final NoteModel? noteModel;
  NoteDetailsScreenArgs({this.noteModel});
}
